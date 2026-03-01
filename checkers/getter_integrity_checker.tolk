import "helpers"
import "./imports/tsa_functions"

const EXIT_GETTER_MISMATCH = 1300

fun onInternalMessage(in: InMessage) {
    tsa_forbid_failures();

    val (reportedBalance, _, _, _) = readWalletData();
    tsa_fetch_value(reportedBalance, -1);

    val c4 = tsa_get_c4(1);
    var ds = c4.beginParse();
    val actualBalance = ds.loadCoins();
    tsa_fetch_value(actualBalance, -2);

    tsa_allow_failures();

    if (reportedBalance != actualBalance) {
        throw EXIT_GETTER_MISMATCH;
    }
}
