package org.usvm.report

import kotlinx.serialization.Serializable
import mu.KotlinLogging
import org.ton.bytecode.TsaContractCode
import org.ton.extractJettonContractInfo
import org.usvm.checkers.BlacklistAddressChecker
import org.usvm.checkers.ConditionalBlockingChecker
import org.usvm.checkers.TransferFeeChecker
import org.usvm.getContractFromBytes
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardCopyOption.REPLACE_EXISTING
import java.util.jar.JarFile
import java.util.concurrent.Executors
import java.util.concurrent.Future
import kotlin.io.path.ExperimentalPathApi
import kotlin.io.path.Path
import kotlin.io.path.createTempDirectory
import kotlin.io.path.deleteRecursively
import kotlin.io.path.extension

private val logger = KotlinLogging.logger {}

@Serializable
data class JettonWalletPropertiesReport(
    val analyzedAddress: String,
    val jettonWalletCodeHashBase64: String,
    val blacklistedAddresses: Set<String>,
    val allTransfersBlocked: Boolean,
    val hasHiddenTransferFee: Boolean,
    val hasConditionalBlocking: Boolean,
    val errors: List<String> = emptyList(),
)

fun runAnalysisAndCreateReport(address: String): JettonWalletPropertiesReport {
    val contractInfo = extractJettonContractInfo(address)
    val contractBytes = contractInfo.contractBytes
    val contract = getContractFromBytes(contractBytes)

    return runFullAnalysis(contract).let { result ->
        JettonWalletPropertiesReport(
            analyzedAddress = address,
            jettonWalletCodeHashBase64 = contractInfo.jettonWalletCodeHashBase64,
            blacklistedAddresses = result.blacklistedAddresses,
            allTransfersBlocked = result.allTransfersBlocked,
            hasHiddenTransferFee = result.hasHiddenTransferFee,
            hasConditionalBlocking = result.hasConditionalBlocking,
            errors = result.errors,
        )
    }
}

data class FullAnalysisResult(
    val blacklistedAddresses: Set<String>,
    val allTransfersBlocked: Boolean,
    val hasHiddenTransferFee: Boolean,
    val hasConditionalBlocking: Boolean,
    val errors: List<String> = emptyList(),
)

@OptIn(ExperimentalPathApi::class)
fun runFullAnalysis(contract: TsaContractCode): FullAnalysisResult {
    val targetResourcesDir = makeTmpDirForResourcesForJarEnvironmentOrNull()
    val errors = mutableListOf<String>()

    val executor = Executors.newFixedThreadPool(3)

    try {
        // Launch all three checkers in parallel
        val blacklistFuture: Future<BlacklistAddressChecker.ResultDescription> =
            executor.submit<BlacklistAddressChecker.ResultDescription> {
                runCatching {
                    val checker = BlacklistAddressChecker(targetResourcesDir)
                    val executions = checker.findConflictingExecutions(
                        contract,
                        stopWhenFoundOneConflictingExecution = false,
                    )
                    checker.getDescription(executions)
                }.getOrElse { e ->
                    logger.error(e) { "BlacklistAddressChecker failed" }
                    synchronized(errors) { errors += "BlacklistAddressChecker failed: ${e.message}" }
                    BlacklistAddressChecker.ResultDescription(emptySet(), allTransfersBlocked = false)
                }
            }

        val feeFuture: Future<Boolean> = executor.submit<Boolean> {
            runCatching {
                val checker = TransferFeeChecker(targetResourcesDir)
                val executions = checker.findConflictingExecutions(contract)
                if (executions.isNotEmpty()) {
                    checker.getDescription(executions).hasHiddenTransferFee
                } else {
                    false
                }
            }.getOrElse { e ->
                logger.error(e) { "TransferFeeChecker failed" }
                synchronized(errors) { errors += "TransferFeeChecker failed: ${e.message}" }
                false
            }
        }

        val blockingFuture: Future<Boolean> = executor.submit<Boolean> {
            runCatching {
                val checker = ConditionalBlockingChecker(targetResourcesDir)
                val executions = checker.findConflictingExecutions(contract)
                if (executions.isNotEmpty()) {
                    checker.getDescription(executions).hasConditionalBlocking
                } else {
                    false
                }
            }.getOrElse { e ->
                logger.error(e) { "ConditionalBlockingChecker failed" }
                synchronized(errors) { errors += "ConditionalBlockingChecker failed: ${e.message}" }
                false
            }
        }

        val blacklistResult = blacklistFuture.get()
        return FullAnalysisResult(
            blacklistedAddresses = blacklistResult.blacklistedAddresses,
            allTransfersBlocked = blacklistResult.allTransfersBlocked,
            hasHiddenTransferFee = feeFuture.get(),
            hasConditionalBlocking = blockingFuture.get(),
            errors = errors,
        )
    } finally {
        executor.shutdown()
        targetResourcesDir?.deleteRecursively()
    }
}

private fun makeTmpDirForResourcesForJarEnvironmentOrNull(): Path? {
    val uri =
        JettonWalletPropertiesReport::class.java.protectionDomain.codeSource.location
            .toURI()
    val extension = Path(uri.path).extension

    if (extension != "jar") {
        return null
    }

    JarFile(uri.schemeSpecificPart).use { jar ->
        val resourcesPrefix = "resources"
        val targetResourcesDir = createTempDirectory()
        jar
            .entries()
            .asSequence()
            .filter { it.name.startsWith(resourcesPrefix) }
            .forEach { entry ->
                // Determine the target path for each entry
                val targetPath = targetResourcesDir.resolve(entry.name.removePrefix("$resourcesPrefix/"))
                if (entry.isDirectory) {
                    Files.createDirectories(targetPath)
                } else {
                    // Create parent directories if necessary
                    Files.createDirectories(targetPath.parent)
                    // Copy the file from the JAR to the target path
                    jar.getInputStream(entry).use { input ->
                        Files.copy(input, targetPath, REPLACE_EXISTING)
                    }
                }
            }

        return targetResourcesDir
    }
}
