package org.usvm.checkers

import org.ton.bytecode.TsaContractCode
import org.ton.bytecode.setTSACheckerFunctions
import org.usvm.machine.BocAnalyzer
import org.usvm.resolveResourcePath
import org.usvm.test.resolver.TvmSymbolicTest
import org.usvm.test.resolver.TvmTestFailure
import java.nio.file.Path

data class GetterIntegrityChecker(
    private val resourcesDir: Path?,
) : TvmChecker {
    private val checkerResourcePath = resourcesDir.resolveResourcePath(CHECKER_PATH)

    override fun findConflictingExecutions(
        contractUnderTest: TsaContractCode,
        stopWhenFoundOneConflictingExecution: Boolean,
    ): List<TvmSymbolicTest> {
        val checkerContract = BocAnalyzer.loadContractFromBoc(checkerResourcePath).also { setTSACheckerFunctions(it) }
        return runAnalysisAndExtractFailingExecutions(
            listOf(checkerContract, contractUnderTest),
            stopWhenFoundOneConflictingExecution,
            inputInfo = null,
        )
    }

    fun getDescription(conflictingExecutions: List<TvmSymbolicTest>): ResultDescription {
        val hasMismatch = conflictingExecutions.any { test ->
            check(test.result is TvmTestFailure) { "Unexpected execution: $test" }
            (test.result as TvmTestFailure).exitCode == EXIT_GETTER_MISMATCH
        }
        return ResultDescription(hasGetterIntegrityViolation = hasMismatch)
    }

    data class ResultDescription(
        val hasGetterIntegrityViolation: Boolean,
    )

    companion object {
        private const val CHECKER_PATH = "/checkers/boc/getter_integrity_checker.boc"
        const val EXIT_GETTER_MISMATCH = 1300
    }
}
