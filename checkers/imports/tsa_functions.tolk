// generated

import "@stdlib/common"

@pure
fun tsa_ret_1<A>(): A
    asm "NOP"

@pure
fun tsa_ret_2<A, B>(): (A, B)
    asm "NOP"

@pure
fun tsa_ret_3<A, B, C>(): (A, B, C)
    asm "NOP"

@pure
fun tsa_ret_4<A, B, C, D>(): (A, B, C, D)
    asm "NOP"

@pure
fun tsa_ret_5<A, B, C, D, E>(): (A, B, C, D, E)
    asm "NOP"

@pure
fun tsa_ret_6<A, B, C, D, E, F>(): (A, B, C, D, E, F)
    asm "NOP"

@pure
fun tsa_ret_7<A, B, C, D, E, F, G>(): (A, B, C, D, E, F, G)
    asm "NOP"

@pure
fun tsa_ret_8<A, B, C, D, E, F, G, H>(): (A, B, C, D, E, F, G, H)
    asm "NOP"

@pure
fun tsa_ret_9<A, B, C, D, E, F, G, H, I>(): (A, B, C, D, E, F, G, H, I)
    asm "NOP"

@pure
fun tsa_ret_10<A, B, C, D, E, F, G, H, I, J>(): (A, B, C, D, E, F, G, H, I, J)
    asm "NOP"

@method_id(1)
fun tsa_forbid_failures() {
}

@method_id(2)
fun tsa_allow_failures() {
}

@method_id(3)
fun tsa_assert(condition: bool) {
}

@method_id(4)
fun tsa_assert_not(condition: bool) {
}

@method_id(5)
fun tsa_fetch_value(value: unknown, value_id: int) {
}

@method_id(6)
fun tsa_send_internal_message(contract_id: int, input_id: int) {
}

@method_id(7)
fun tsa_get_c4(contract_id: int): cell {
    return tsa_ret_1<cell>();
}

@method_id(8)
fun tsa_send_external_message(contract_id: int, input_id: int) {
}

@method_id(9)
fun tsa_get_balance(contract_id: int): int {
    return tsa_ret_1<int>();
}

@method_id(10)
fun tsa_set_c4(contract_id: int, value: cell) {
}

@method_id(11)
fun tsa_make_address_random(address_data: slice) {
}

@method_id(12)
fun tsa_make_slice_independent_from_random_addresses(independent_slice: slice) {
}

@method_id(13)
fun tsa_input_was_accepted(input_id: int): int {
    return tsa_ret_1<int>();
}

@method_id(14)
fun tsa_send_internal_message_with_body(body: slice, contract_id: int, input_id: int) {
}

@method_id(15)
fun tsa_send_external_message_with_body(body: slice, contract_id: int, input_id: int) {
}

@method_id(100)
fun tsa_mk_int(bits: int, signed: int): int {
    return tsa_ret_1<int>();
}

@method_id(10000)
fun tsa_call_0_0(id_contract: int, id_method: int) {
}

@method_id(10001)
fun tsa_call_0_1(p0: unknown, id_contract: int, id_method: int) {
}

@method_id(10002)
fun tsa_call_0_2(p0: unknown, p1: unknown, id_contract: int, id_method: int) {
}

@method_id(10003)
fun tsa_call_0_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int) {
}

@method_id(10004)
fun tsa_call_0_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int) {
}

@method_id(10005)
fun tsa_call_0_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int) {
}

@method_id(10006)
fun tsa_call_0_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int) {
}

@method_id(10007)
fun tsa_call_0_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int) {
}

@method_id(10008)
fun tsa_call_0_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int) {
}

@method_id(10009)
fun tsa_call_0_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int) {
}

@method_id(10010)
fun tsa_call_0_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int) {
}

@method_id(10100)
fun tsa_call_1_0(id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10101)
fun tsa_call_1_1(p0: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10102)
fun tsa_call_1_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10103)
fun tsa_call_1_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10104)
fun tsa_call_1_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10105)
fun tsa_call_1_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10106)
fun tsa_call_1_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10107)
fun tsa_call_1_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10108)
fun tsa_call_1_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10109)
fun tsa_call_1_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10110)
fun tsa_call_1_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): unknown {
    return tsa_ret_1<unknown>();
}

@method_id(10200)
fun tsa_call_2_0(id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10201)
fun tsa_call_2_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10202)
fun tsa_call_2_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10203)
fun tsa_call_2_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10204)
fun tsa_call_2_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10205)
fun tsa_call_2_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10206)
fun tsa_call_2_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10207)
fun tsa_call_2_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10208)
fun tsa_call_2_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10209)
fun tsa_call_2_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10210)
fun tsa_call_2_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown) {
    return tsa_ret_2<unknown, unknown>();
}

@method_id(10300)
fun tsa_call_3_0(id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10301)
fun tsa_call_3_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10302)
fun tsa_call_3_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10303)
fun tsa_call_3_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10304)
fun tsa_call_3_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10305)
fun tsa_call_3_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10306)
fun tsa_call_3_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10307)
fun tsa_call_3_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10308)
fun tsa_call_3_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10309)
fun tsa_call_3_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10310)
fun tsa_call_3_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown) {
    return tsa_ret_3<unknown, unknown, unknown>();
}

@method_id(10400)
fun tsa_call_4_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10401)
fun tsa_call_4_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10402)
fun tsa_call_4_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10403)
fun tsa_call_4_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10404)
fun tsa_call_4_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10405)
fun tsa_call_4_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10406)
fun tsa_call_4_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10407)
fun tsa_call_4_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10408)
fun tsa_call_4_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10409)
fun tsa_call_4_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10410)
fun tsa_call_4_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown) {
    return tsa_ret_4<unknown, unknown, unknown, unknown>();
}

@method_id(10500)
fun tsa_call_5_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10501)
fun tsa_call_5_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10502)
fun tsa_call_5_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10503)
fun tsa_call_5_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10504)
fun tsa_call_5_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10505)
fun tsa_call_5_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10506)
fun tsa_call_5_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10507)
fun tsa_call_5_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10508)
fun tsa_call_5_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10509)
fun tsa_call_5_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10510)
fun tsa_call_5_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_5<unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10600)
fun tsa_call_6_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10601)
fun tsa_call_6_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10602)
fun tsa_call_6_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10603)
fun tsa_call_6_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10604)
fun tsa_call_6_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10605)
fun tsa_call_6_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10606)
fun tsa_call_6_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10607)
fun tsa_call_6_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10608)
fun tsa_call_6_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10609)
fun tsa_call_6_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10610)
fun tsa_call_6_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_6<unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10700)
fun tsa_call_7_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10701)
fun tsa_call_7_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10702)
fun tsa_call_7_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10703)
fun tsa_call_7_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10704)
fun tsa_call_7_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10705)
fun tsa_call_7_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10706)
fun tsa_call_7_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10707)
fun tsa_call_7_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10708)
fun tsa_call_7_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10709)
fun tsa_call_7_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10710)
fun tsa_call_7_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_7<unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10800)
fun tsa_call_8_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10801)
fun tsa_call_8_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10802)
fun tsa_call_8_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10803)
fun tsa_call_8_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10804)
fun tsa_call_8_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10805)
fun tsa_call_8_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10806)
fun tsa_call_8_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10807)
fun tsa_call_8_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10808)
fun tsa_call_8_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10809)
fun tsa_call_8_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10810)
fun tsa_call_8_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_8<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10900)
fun tsa_call_9_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10901)
fun tsa_call_9_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10902)
fun tsa_call_9_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10903)
fun tsa_call_9_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10904)
fun tsa_call_9_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10905)
fun tsa_call_9_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10906)
fun tsa_call_9_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10907)
fun tsa_call_9_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10908)
fun tsa_call_9_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10909)
fun tsa_call_9_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(10910)
fun tsa_call_9_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_9<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11000)
fun tsa_call_10_0(id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11001)
fun tsa_call_10_1(p0: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11002)
fun tsa_call_10_2(p0: unknown, p1: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11003)
fun tsa_call_10_3(p0: unknown, p1: unknown, p2: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11004)
fun tsa_call_10_4(p0: unknown, p1: unknown, p2: unknown, p3: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11005)
fun tsa_call_10_5(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11006)
fun tsa_call_10_6(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11007)
fun tsa_call_10_7(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11008)
fun tsa_call_10_8(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11009)
fun tsa_call_10_9(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

@method_id(11010)
fun tsa_call_10_10(p0: unknown, p1: unknown, p2: unknown, p3: unknown, p4: unknown, p5: unknown, p6: unknown, p7: unknown, p8: unknown, p9: unknown, id_contract: int, id_method: int): (unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown) {
    return tsa_ret_10<unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown, unknown>();
}

// Typed helpers for checker contracts.

fun tsa_call_4_0_wallet_data(id_contract: int, id_method: int): (coins, address, address, cell) {
    val (balance, owner, master, code) = tsa_call_4_0(id_contract, id_method);
    return (
        balance as coins,
        owner as address,
        master as address,
        code as cell,
    );
}

// Tolk does not expose raw `in_msg_full` directly in `onInternalMessage`,
// so we reconstruct a canonical internal-message header for method-0 checker calls.
fun build_tsa_in_msg_full(senderAddress: address, valueCoins: coins, createdLt: uint64, createdAt: uint32): cell {
    return beginCell()
        .storeUint(6, 4) // int_msg_info first 4 bits: 0 | ihr_disabled=1 | bounce=1 | bounced=0
        .storeAddress(senderAddress)
        .storeAddress(contract.getAddress())
        .storeCoins(valueCoins)
        .storeBool(false) // empty extra currencies map
        .storeCoins(0)    // ihr_fee
        .storeCoins(0)    // fwd_fee
        .storeUint(createdLt, 64)
        .storeUint(createdAt, 32)
        .endCell();
}

fun tsa_call_recv_internal(senderAddress: address, valueCoins: coins, createdLt: uint64, createdAt: uint32, body: slice, contract_id: int) {
    val inMsgFull = build_tsa_in_msg_full(senderAddress, valueCoins, createdLt, createdAt);
    tsa_call_0_4(contract.getOriginalBalance(), valueCoins, inMsgFull, body, contract_id, 0);
}
