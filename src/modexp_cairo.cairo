use core::num::traits::Zero;
use core::integer::u512_safe_div_rem_by_u256;
use core::num::traits::WideMul;

use modexp::utils::get_bits_little;


pub fn mod_exp_cairo(x: u256, y: u256, n: u256) -> u256 {
    if n <= 1 {
        return 0;
    };
    if y.is_zero() {
        return 1;
    };
    if x.is_zero() {
        return 0;
    };

    let mut result = 1_u256;
    let mut base: u256 = x;
    let modulus: NonZero<u256> = n.try_into().unwrap();
    let bits = get_bits_little(y);
    for bit in bits {
        if bit == 1 {
            result = u256_mul_mod(result, base, modulus);
        }
        base = u256_mul_mod(base, base, modulus);
    };

    result
}

fn u256_mul_mod(a: u256, b: u256, n: NonZero<u256>) -> u256 {
    let (_, r) = u512_safe_div_rem_by_u256(a.wide_mul(b), n);
    r
}
