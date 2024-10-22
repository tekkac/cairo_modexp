use core::circuit::u384;
use modexp::utils::get_bits_little;
use modexp::modexp_cairo::mod_exp_cairo;
use modexp::modexp_circuit::mod_exp_circuit;

const TWO_31: u256 = 2147483648;
const PREV_PRIME_256: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43;
const PREV_PRIME_384: u384 =
    u384 {
        limb0: 0xfffffffffffffffffffffec3,
        limb1: 0xffffffffffffffffffffffff,
        limb2: 0xffffffffffffffffffffffff,
        limb3: 0xffffffffffffffffffffffff
    };
const PREV_PRIME_384_M1: u384 =
    u384 {
        limb0: 0xfffffffffffffffffffffec2,
        limb1: 0xffffffffffffffffffffffff,
        limb2: 0xffffffffffffffffffffffff,
        limb3: 0xffffffffffffffffffffffff
    };
const PREV_PRIME_384_M2: u384 =
    u384 {
        limb0: 0xfffffffffffffffffffffec1,
        limb1: 0xffffffffffffffffffffffff,
        limb2: 0xffffffffffffffffffffffff,
        limb3: 0xffffffffffffffffffffffff
    };

#[test]
fn test_get_bits_little() {
    let bits = get_bits_little(0b100000111);
    assert_eq!(bits, array![1, 1, 1, 0, 0, 0, 0, 0, 1]);
    let bits = get_bits_little(0);
    assert_eq!(bits, array![]);
    let bits = get_bits_little(0b1);
    assert_eq!(bits, array![1]);
    let bits = get_bits_little(core::num::traits::Bounded::<u256>::MAX);
    assert_eq!(bits.len(), 256);
}

#[test]
fn test_mod_exp_cairo() {
    assert_eq!(mod_exp_cairo(2, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(3, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(5, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(7, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(11, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(
        mod_exp_cairo(PREV_PRIME_256 - 2, PREV_PRIME_256 - 1, PREV_PRIME_256), 1, "wrong result"
    );
    assert_eq!(
        mod_exp_cairo(123456789, 987654321, 11111111111111111111111111111111),
        6929919895158922141640454333396,
        "wrong result"
    );
}

#[test]
fn test_mod_exp_cairo_one() {
    assert_eq!(
        mod_exp_cairo(PREV_PRIME_256 - 2, PREV_PRIME_256 - 1, PREV_PRIME_256),
        1.into(),
        "wrong result"
    );
}

#[test]
fn test_mod_exp_circuit() {
    let TWO_31_M1: u384 = 2147483647.into();
    let TWO_31_M2: u384 = 2147483646.into();
    assert_eq!(mod_exp_circuit(2.into(), TWO_31_M2, TWO_31_M1), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(3.into(), TWO_31_M2, TWO_31_M1), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(5.into(), TWO_31_M2, TWO_31_M1), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(7.into(), TWO_31_M2, TWO_31_M1), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(11.into(), TWO_31_M2, TWO_31_M1), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(2.into(), TWO_31_M2, TWO_31_M1.into()), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(2.into(), 5.into(), 30.into()), 2.into(), "wrong result");
    assert_eq!(
        mod_exp_circuit(
            123456789.into(), 987654321.into(), 11111111111111111111111111111111.into()
        ),
        6929919895158922141640454333396.into(),
        "wrong result"
    );
    assert_eq!(
        mod_exp_circuit(PREV_PRIME_384_M2, PREV_PRIME_384_M1, PREV_PRIME_384),
        1.into(),
        "wrong result"
    );
}

#[test]
fn test_mod_exp_circuit_one() {
    assert_eq!(
        mod_exp_circuit(PREV_PRIME_384_M2, PREV_PRIME_384_M1, PREV_PRIME_384),
        1.into(),
        "wrong result"
    );
}

#[test]
fn test_edge_case_circuit() {
    assert_eq!(mod_exp_circuit(12.into(), 42.into(), 0.into()), 0.into(), "wrong result");
    assert_eq!(mod_exp_circuit(12.into(), 42.into(), 1.into()), 0.into(), "wrong result");
    assert_eq!(mod_exp_circuit(0.into(), 42.into(), 42.into()), 0.into(), "wrong result");
    assert_eq!(mod_exp_circuit(42.into(), 0.into(), 42.into()), 1.into(), "wrong result");
    assert_eq!(mod_exp_circuit(0.into(), 0.into(), 42.into()), 1.into(), "wrong result");
}

#[test]
fn test_edge_case_cairo() {
    assert_eq!(mod_exp_cairo(12, 42, 0), 0, "wrong result");
    assert_eq!(mod_exp_cairo(12, 42, 1), 0, "wrong result");
    assert_eq!(mod_exp_cairo(0, 42, 42), 0, "wrong result");
    assert_eq!(mod_exp_cairo(42, 0, 42), 1, "wrong result");
    assert_eq!(mod_exp_cairo(0, 0, 42), 1, "wrong result");
}

