import "./imports/tsa_functions"
import "messages"

const GAS_AMOUNT = 300000000
const FWD_GAS_AMOUNT = 240000000

fun assertAddressIsStd(addr: address) {
    val asSlice = beginCell().storeAddress(addr).endCell().beginParse();
    tsa_assert(asSlice.remainingBitsCount() == 267);
    tsa_assert(asSlice.preloadUint(11) == 1024);
}

fun assertAddressAnyIsStd(addr: any_address) {
    tsa_assert(addr.isInternal());
    val asSlice = beginCell().storeAddressAny(addr).endCell().beginParse();
    tsa_assert(asSlice.remainingBitsCount() == 267);
    tsa_assert(asSlice.preloadUint(11) == 1024);
}

fun assertBasicTransferContext(
    senderAddress: address,
    valueCoins: coins,
    valueExtra: ExtraCurrenciesMap,
) {
    // Tolk entrypoint exposes normalized message fields instead of raw msg_cell flags.
    tsa_assert(valueCoins == GAS_AMOUNT);
    tsa_assert(valueExtra.isEmpty());
    assertAddressIsStd(senderAddress);
    assertAddressIsStd(contract.getAddress());
}

fun readWalletData(): (coins, address, address, cell) {
    return tsa_call_4_0_wallet_data(1, 97026);
}
