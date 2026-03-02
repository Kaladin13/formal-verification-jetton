import "./imports/tsa_functions"
import "helpers"
import "messages"

const EXIT_CROSS_CONTRACT_FEE = 1102

global gTransferAmount: coins
global gForwardedAmount: coins
global gFoundInternalTransfer: bool

@method_id(65621)
fun on_internal_message_send(
    _balance: int,
    msg_value: int,
    in_msg_full: cell,
    msg_body: slice,
    _input_id: int,
) {
    var header = in_msg_full.beginParse();
    val flags = header.loadUint(4);
    tsa_assert_not(((flags & 1) != 0) || ((flags & 8) != 0));

    val senderAny = header.loadAddressAny();
    val destinationAny = header.loadAddressAny();
    assertAddressAnyIsStd(senderAny);
    assertAddressAnyIsStd(destinationAny);

    val value = header.loadCoins();
    tsa_assert(msg_value == value);
    tsa_assert(msg_value == GAS_AMOUNT);
    tsa_assert(!header.loadBool());

    val ihrFee = header.loadCoins();
    val fwdFee = header.loadCoins();
    tsa_assert(ihrFee + fwdFee == 0);

    val senderAddress = senderAny.castToInternal();

    val (walletBalance, ownerAddress, masterAddress, _) = readWalletData();
    assertAddressIsStd(masterAddress);
    tsa_assert(senderAddress.bitsEqual(ownerAddress));

    val transfer = lazy AllowedTransferMessage.fromSlice(msg_body);
    match (transfer) {
        TransferForChecks => {
            tsa_assert(transfer.amount > 0);
            tsa_assert(transfer.amount <= walletBalance);
            tsa_assert(transfer.forwardTonAmount == FWD_GAS_AMOUNT);
            tsa_assert(hasRefForwardPayload(transfer.forwardPayload));

            gTransferAmount = transfer.amount;
            tsa_fetch_value(transfer.amount, -1);
        }
    }
}

@method_id(71561)
fun on_out_message(
    _contract_message_number: int,
    _msg_full: cell,
    msg_body: slice,
    _receiver_contract_id: int,
    sender_contract_id: int,
) {
    if (sender_contract_id != 1) {
        return;
    }

    if (msg_body.remainingBitsCount() < 32) {
        return;
    }

    var body = msg_body;
    val op = body.loadUint(32);
    if (op == 0x178d4519) {
        body.loadUint(64);
        gForwardedAmount = body.loadCoins();
        gFoundInternalTransfer = true;
        tsa_fetch_value(gForwardedAmount, -2);
    }
}

fun onInternalMessage(in: InMessage) {
    tsa_forbid_failures();

    gFoundInternalTransfer = false;
    gTransferAmount = 0;
    gForwardedAmount = 0;

    tsa_send_internal_message(1, 0);

    tsa_allow_failures();

    if (gFoundInternalTransfer && gForwardedAmount != gTransferAmount) {
        throw EXIT_CROSS_CONTRACT_FEE;
    }
}
