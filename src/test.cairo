use modexp::utils::get_bits_little;
use modexp::modexp_cairo::mod_exp_cairo;

const TWO_31: u256 = 2147483648;

#[test]
fn test_get_bits_little() {
    let bits = get_bits_little(0b100000111);
    println!("Testing mod_exp {:?}", bits);
}

#[test]
fn test_mod_exp_cairo() {
    assert_eq!(mod_exp_cairo(2, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(3, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(5, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(7, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(11, TWO_31 - 2, TWO_31 - 1), 1, "wrong result");
    assert_eq!(mod_exp_cairo(2, 5, 30), 2, "wrong result");
    assert_eq!(
        mod_exp_cairo(123456789, 987654321, 11111111111111111111111111111111),
        6929919895158922141640454333396,
        "wrong result"
    );
}
// #[test]
// fn test_mod_exp_circuit() {
//     assert_eq!(
//         mod_exp_circuit(2.into(), (TWO_31 - 2).into(), (TWO_31 - 1).into()),
//         1.into(),
//         "wrong result"
//     );
//     assert_eq!(
//         mod_exp_circuit(3.into(), (TWO_31 - 2).into(), (TWO_31 - 1).into()),
//         1.into(),
//         "wrong result"
//     );
//     assert_eq!(
//         mod_exp_circuit(5.into(), (TWO_31 - 2).into(), (TWO_31 - 1).into()),
//         1.into(),
//         "wrong result"
//     );
//     assert_eq!(
//         mod_exp_circuit(7.into(), (TWO_31 - 2).into(), (TWO_31 - 1).into()),
//         1.into(),
//         "wrong result"
//     );
//     assert_eq!(
//         mod_exp_circuit(11.into(), (TWO_31 - 2).into(), (TWO_31 - 1).into()),
//         1.into(),
//         "wrong result"
//     );
//     assert_eq!(mod_exp_circuit(2.into(), 5.into(), 30.into()), 2.into(), "wrong result");
//     assert_eq!(
//         mod_exp_circuit(
//             123456789.into(), 987654321.into(), 11111111111111111111111111111111.into()
//         ),
//         6929919895158922141640454333396.into(),
//         "wrong result"
//     );
// }


