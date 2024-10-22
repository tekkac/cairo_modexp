use core::num::traits::Zero;
use core::circuit::CircuitElement as CE;
use core::circuit::CircuitInput as CI;
use core::circuit::{
    u384, circuit_add, circuit_sub, circuit_mul, EvalCircuitTrait, CircuitOutputsTrait,
    CircuitModulus, CircuitInputs, AddInputResultTrait
};
use modexp::utils::get_u384_bits_little;

fn mod_exp_loop_inner(n: u384, bit: u384, base: u384, res: u384) -> (u384, u384) {
    let (_one, _base, _bit, _res) = (
        CE::<CI<0>> {}, CE::<CI<1>> {}, CE::<CI<2>> {}, CE::<CI<3>> {}
    );

    // Circuit
    // base_if_bit_else_one = (1 - bit)*(one) + bit*base
    // new_res = res * base_if_bit_else_one
    // new_base = base * base
    let base_if_bit_else_one = circuit_add(
        circuit_mul(circuit_sub(_one, _bit), _one), circuit_mul(_bit, _base)
    );
    let new_res = circuit_mul(base_if_bit_else_one, _res);
    let new_base = circuit_mul(_base, _base);

    let modulus = TryInto::<_, CircuitModulus>::try_into([n.limb0, n.limb1, n.limb2, n.limb3])
        .unwrap();

    let mut circuit_inputs = (new_res, new_base,).new_inputs();
    // Fill inputs:
    circuit_inputs = circuit_inputs.next([1, 0, 0, 0]);
    circuit_inputs = circuit_inputs.next(base);
    circuit_inputs = circuit_inputs.next(bit);
    circuit_inputs = circuit_inputs.next(res);

    let outputs = circuit_inputs.done().eval(modulus).unwrap();
    (outputs.get_output(new_res), outputs.get_output(new_base))
}

// Compute the modular exponentiation
// x^y mod n
pub fn mod_exp_circuit(x: u384, y: u384, n: u384) -> u384 {
    if n.is_zero() {
        return 0.into();
    }
    if n == 1.into() {
        return 0.into();
    }
    if y.is_zero() {
        return 1.into();
    }
    if x.is_zero() {
        return 0.into();
    }
    let bits = get_u384_bits_little(y);
    let mut res = 1.into();
    let mut base = x;
    for bit in bits {
        let (_res, _base) = mod_exp_loop_inner(n, bit.into(), base, res);
        res = _res;
        base = _base;
    };
    res
}
