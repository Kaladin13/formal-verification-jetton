import "messages"
import "helpers"
import "./imports/tsa_functions"

const EXIT_FEE_DETECTED = 1100

fun onInternalMessage(in: InMessage) {
    tsa_forbid_failures();

    assertBasicTransferContext(in.senderAddress, in.valueCoins, in.valueExtra);

    val (balanceBefore, ownerAddress, masterAddress, _) = readWalletData();
    assertAddressIsStd(masterAddress);

    tsa_assert(in.senderAddress.bitsEqual(ownerAddress));

    val msg = lazy AllowedTransferMessage.fromSlice(in.body);
    match (msg) {
        TransferForChecks => {
            tsa_assert(msg.amount > 0);
            tsa_assert(msg.amount <= balanceBefore);
            tsa_assert(msg.forwardTonAmount == FWD_GAS_AMOUNT);
            tsa_assert(hasRefForwardPayload(msg.forwardPayload));

            tsa_fetch_value(msg.amount, -1);
            tsa_fetch_value(balanceBefore, -2);

            tsa_call_recv_internal(in.senderAddress, in.valueCoins, in.createdLt, in.createdAt, in.body, 1);

            val (balanceAfter, _, _, _) = readWalletData();
            tsa_fetch_value(balanceAfter, -3);

            tsa_allow_failures();
            if (balanceBefore - msg.amount != balanceAfter) {
                throw EXIT_FEE_DETECTED;
            }
        }
    }
}
