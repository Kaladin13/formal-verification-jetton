package org.usvm.report

import kotlinx.serialization.Serializable
import org.ton.bytecode.TsaContractCode
import org.ton.extractJettonContractInfo
import org.usvm.checkers.BlacklistAddressChecker
import org.usvm.checkers.ConditionalBlockingChecker
import org.usvm.checkers.GetterIntegrityChecker
import org.usvm.checkers.TransferFeeChecker
import org.usvm.getContractFromBytes
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardCopyOption.REPLACE_EXISTING
import java.util.jar.JarFile
import kotlin.io.path.ExperimentalPathApi
import kotlin.io.path.Path
import kotlin.io.path.createTempDirectory
import kotlin.io.path.deleteRecursively
import kotlin.io.path.extension

@Serializable
data class JettonWalletPropertiesReport(
    val analyzedAddress: String,
    val jettonWalletCodeHashBase64: String,
    val blacklistedAddresses: Set<String>,
    val hasHiddenTransferFee: Boolean,
    val hasConditionalBlocking: Boolean,
    val hasGetterIntegrityViolation: Boolean,
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
            hasHiddenTransferFee = result.hasHiddenTransferFee,
            hasConditionalBlocking = result.hasConditionalBlocking,
            hasGetterIntegrityViolation = result.hasGetterIntegrityViolation,
        )
    }
}

data class FullAnalysisResult(
    val blacklistedAddresses: Set<String>,
    val hasHiddenTransferFee: Boolean,
    val hasConditionalBlocking: Boolean,
    val hasGetterIntegrityViolation: Boolean,
)

@OptIn(ExperimentalPathApi::class)
fun runFullAnalysis(contract: TsaContractCode): FullAnalysisResult {
    val targetResourcesDir = makeTmpDirForResourcesForJarEnvironmentOrNull()

    try {
        // Blacklist checker (existing)
        val blacklistAddressChecker = BlacklistAddressChecker(targetResourcesDir)
        val blacklistedAddressesExecutions =
            blacklistAddressChecker.findConflictingExecutions(
                contract,
                stopWhenFoundOneConflictingExecution = false,
            )
        val blacklistedAddresses =
            if (blacklistedAddressesExecutions.isNotEmpty()) {
                blacklistAddressChecker.getDescription(blacklistedAddressesExecutions).blacklistedAddresses
            } else {
                emptySet()
            }

        // Transfer fee checker
        val transferFeeChecker = TransferFeeChecker(targetResourcesDir)
        val feeExecutions = transferFeeChecker.findConflictingExecutions(contract)
        val hasHiddenTransferFee =
            if (feeExecutions.isNotEmpty()) {
                transferFeeChecker.getDescription(feeExecutions).hasHiddenTransferFee
            } else {
                false
            }

        // Conditional blocking checker
        val conditionalBlockingChecker = ConditionalBlockingChecker(targetResourcesDir)
        val blockingExecutions = conditionalBlockingChecker.findConflictingExecutions(contract)
        val hasConditionalBlocking =
            if (blockingExecutions.isNotEmpty()) {
                conditionalBlockingChecker.getDescription(blockingExecutions).hasConditionalBlocking
            } else {
                false
            }

        // Getter integrity checker
        val getterIntegrityChecker = GetterIntegrityChecker(targetResourcesDir)
        val getterExecutions = getterIntegrityChecker.findConflictingExecutions(contract)
        val hasGetterIntegrityViolation =
            if (getterExecutions.isNotEmpty()) {
                getterIntegrityChecker.getDescription(getterExecutions).hasGetterIntegrityViolation
            } else {
                false
            }

        return FullAnalysisResult(
            blacklistedAddresses = blacklistedAddresses,
            hasHiddenTransferFee = hasHiddenTransferFee,
            hasConditionalBlocking = hasConditionalBlocking,
            hasGetterIntegrityViolation = hasGetterIntegrityViolation,
        )
    } finally {
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
