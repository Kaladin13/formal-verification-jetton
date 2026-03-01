// Typed message schemas used by checker contracts.

type ForwardPayloadInline = RemainingBitsAndRefs
type ForwardPayloadRef = Cell<RemainingBitsAndRefs>
type ForwardPayloadEither = ForwardPayloadInline | ForwardPayloadRef

struct (0x0f8a7ea5) TransferForChecks {
    queryId: uint64
    amount: coins
    destination: any_address
    responseDestination: any_address
    customPayload: cell?
    forwardTonAmount: coins
    forwardPayload: ForwardPayloadEither
}

struct (0x178d4519) InternalTransferStepStandard {
    rest: RemainingBitsAndRefs
}

struct (0x595f07bc) BurnStandard {
    rest: RemainingBitsAndRefs
}

struct (0x6d8e5e3c) WithdrawTonsStandard {
    rest: RemainingBitsAndRefs
}

struct (0x768a50b2) WithdrawJettonsStandard {
    rest: RemainingBitsAndRefs
}

type AllowedTransferMessage = TransferForChecks

type AllowedStandardJettonMessage =
    | TransferForChecks
    | InternalTransferStepStandard
    | BurnStandard
    | WithdrawTonsStandard
    | WithdrawJettonsStandard

fun hasRefForwardPayload(payload: ForwardPayloadEither): bool {
    return match (payload) {
        ForwardPayloadRef => true,
        ForwardPayloadInline => false,
    };
}

fun isKnownStandardJettonMessage(body: slice): bool {
    try {
        val msg = lazy AllowedStandardJettonMessage.fromSlice(body);
        return match (msg) {
            TransferForChecks => true,
            InternalTransferStepStandard => true,
            BurnStandard => true,
            WithdrawTonsStandard => true,
            WithdrawJettonsStandard => true,
        };
    } catch (e) {
        if (e == 63) {
            return false;
        }

        throw e;
    }
}
