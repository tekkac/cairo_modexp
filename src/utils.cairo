// Returns the bits of the 256 bit number in little endian format.
pub fn get_bits_little(s: u256) -> Array<felt252> {
    let mut bits = ArrayTrait::new();
    let mut s_low = s.low;
    while s_low != 0 {
        let (q, r) = core::traits::DivRem::div_rem(s_low, 2);
        bits.append(r.into());
        s_low = q;
    };
    let mut s_high = s.high;
    if s_high != 0 {
        while bits.len() != 128 {
            bits.append(0);
        }
    }
    while s_high != 0 {
        let (q, r) = core::traits::DivRem::div_rem(s_high, 2);
        bits.append(r.into());
        s_high = q;
    };
    bits
}
