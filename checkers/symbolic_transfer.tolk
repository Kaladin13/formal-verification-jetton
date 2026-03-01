import "messages"
import "helpers"
import "./imports/tsa_functions"

fun onInternalMessage(in: InMessage) {
    tsa_forbid_failures();

    assertBasicTransferContext(in.senderAddress, in.valueCoins, in.valueExtra);

    val (totalSupply, ownerAddress, masterAddress, _) = readWalletData();
    assertAddressIsStd(masterAddress);

    tsa_assert(in.senderAddress.bitsEqual(ownerAddress));

    val msg = lazy AllowedTransferMessage.fromSlice(in.body);
    match (msg) {
        TransferForChecks => {
            tsa_assert(msg.amount > 0);
            tsa_assert(msg.amount <= totalSupply);
            tsa_assert(msg.forwardTonAmount == FWD_GAS_AMOUNT);
            tsa_assert(hasRefForwardPayload(msg.forwardPayload));
        }
    }

    tsa_allow_failures();
    tsa_call_recv_internal(in.senderAddress, in.valueCoins, in.createdLt, in.createdAt, in.body, 1);
}
