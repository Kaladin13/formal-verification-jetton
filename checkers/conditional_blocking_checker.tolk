import "./imports/tsa_functions"

const EXIT_STATE_MODIFIED = 1200

fun assertAddressIsStd(addr: address) {
    val asSlice = beginCell().storeAddress(addr).endCell().beginParse();
    tsa_assert(asSlice.remainingBitsCount() == 267);
    tsa_assert(asSlice.preloadUint(11) == 1024);
}

fun onInternalMessage(in: InMessage) {
    tsa_forbid_failures();

    val c4Before = tsa_get_c4(1);

    val (_, ownerAddress, masterAddress, _) = tsa_call_4_0_wallet_data(1, 97026);

    assertAddressIsStd(in.senderAddress);
    tsa_assert_not(in.senderAddress.bitsEqual(ownerAddress));
    tsa_assert_not(in.senderAddress.bitsEqual(masterAddress));

    var bodyCopy = in.body;
    val op = bodyCopy.loadMessageOp();
    tsa_assert(op != 0);
    tsa_assert(op != 0x0f8a7ea5);
    tsa_assert(op != 0x178d4519);
    tsa_assert(op != 0x595f07bc);
    tsa_assert(op != 0x6d8e5e3c);
    tsa_assert(op != 0x768a50b2);

    tsa_assert(in.valueCoins > 0);

    tsa_call_recv_internal(in.senderAddress, in.valueCoins, in.createdLt, in.createdAt, in.body, 1);

    val c4After = tsa_get_c4(1);

    tsa_allow_failures();
    if (c4Before.hash() != c4After.hash()) {
        throw EXIT_STATE_MODIFIED;
    }
}
