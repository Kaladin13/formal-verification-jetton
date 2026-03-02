package org.usvm.checkers

import org.ton.TvmInputInfo
import org.ton.bytecode.MethodId
import org.ton.bytecode.TsaContractCode
import org.ton.bytecode.setTSACheckerFunctions
import org.usvm.FirstFailureTerminator
import org.usvm.machine.BocAnalyzer
import org.usvm.machine.IntercontractOptions
import org.usvm.machine.NoAdditionalStopStrategy
import org.usvm.machine.TvmOptions
import org.usvm.machine.analyzeInterContract
import org.usvm.resolveResourcePath
import org.usvm.test.resolver.TvmSymbolicTest
import org.usvm.test.resolver.TvmTestFailure
import java.nio.file.Path

data class CrossContractFeeChecker(
    private val resourcesDir: Path?,
) : TvmChecker {
    private val checkerPath = resourcesDir.resolveResourcePath(CHECKER_PATH)

    override fun findConflictingExecutions(
        contractUnderTest: TsaContractCode,
        stopWhenFoundOneConflictingExecution: Boolean,
    ): List<TvmSymbolicTest> {
        val checkerContract = BocAnalyzer.loadContractFromBoc(checkerPath)
            .also { setTSACheckerFunctions(it) }

        val additionalStopStrategy =
            if (stopWhenFoundOneConflictingExecution) {
                FirstFailureTerminator()
            } else {
                NoAdditionalStopStrategy
            }

        val analysisResult = analyzeInterContract(
            contracts = listOf(checkerContract, contractUnderTest),
            startContractId = 0,
            methodId = MethodId.ZERO,
            additionalStopStrategy = additionalStopStrategy,
            options = TvmOptions(
                turnOnTLBParsingChecks = false,
                enableOutMessageAnalysis = true,
            ),
            inputInfo = TvmInputInfo(),
        )

        return analysisResult.tests.filter { it.result is TvmTestFailure }
    }

    fun getDescription(conflictingExecutions: List<TvmSymbolicTest>): ResultDescription {
        val hasCrossContractFee = conflictingExecutions.any { test ->
            check(test.result is TvmTestFailure) { "Unexpected execution: $test" }
            (test.result as TvmTestFailure).exitCode == EXIT_CROSS_CONTRACT_FEE
        }
        return ResultDescription(hasCrossContractFee = hasCrossContractFee)
    }

    data class ResultDescription(
        val hasCrossContractFee: Boolean,
    )

    companion object {
        private const val CHECKER_PATH = "/checkers/boc/cross_contract_fee_checker.boc"
        const val EXIT_CROSS_CONTRACT_FEE = 1102
    }
}
