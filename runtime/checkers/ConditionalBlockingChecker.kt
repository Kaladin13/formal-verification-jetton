package org.usvm.checkers

import org.ton.bytecode.TsaContractCode
import org.ton.bytecode.setTSACheckerFunctions
import org.usvm.machine.BocAnalyzer
import org.usvm.resolveResourcePath
import org.usvm.test.resolver.TvmSymbolicTest
import org.usvm.test.resolver.TvmTestFailure
import java.nio.file.Path

data class ConditionalBlockingChecker(
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
        val hasConditionalBlocking = conflictingExecutions.any { test ->
            check(test.result is TvmTestFailure) { "Unexpected execution: $test" }
            (test.result as TvmTestFailure).exitCode == EXIT_STATE_MODIFIED
        }
        return ResultDescription(hasConditionalBlocking = hasConditionalBlocking)
    }

    data class ResultDescription(
        val hasConditionalBlocking: Boolean,
    )

    companion object {
        private const val CHECKER_PATH = "/checkers/boc/conditional_blocking_checker.boc"
        const val EXIT_STATE_MODIFIED = 1200
    }
}
