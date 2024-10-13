use core::circuit::u384;

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


// Returns the bits of the 384 bit integer in little endian format.
pub fn get_u384_bits_little(s: u384) -> Array<felt252> {
    let mut bits = ArrayTrait::new();
    let mut s_limb0: u128 = Into::<_, felt252>::into(s.limb0).try_into().unwrap();
    while s_limb0 != 0 {
        let (q, r) = core::traits::DivRem::div_rem(s_limb0, 2);
        bits.append(r.into());
        s_limb0 = q;
    };
    let mut s_limb1: u128 = Into::<_, felt252>::into(s.limb1).try_into().unwrap();
    if s_limb1 != 0 {
        while bits.len() != 96 {
            bits.append(0);
        }
    }
    while s_limb1 != 0 {
        let (q, r) = core::traits::DivRem::div_rem(s_limb1, 2);
        bits.append(r.into());
        s_limb1 = q;
    };
    let mut s_limb2: u128 = Into::<_, felt252>::into(s.limb2).try_into().unwrap();
    if s_limb2 != 0 {
        while bits.len() != 192 {
            bits.append(0);
        }
    }
    while s_limb2 != 0 {
        let (q, r) = core::traits::DivRem::div_rem(s_limb2, 2);
        bits.append(r.into());
        s_limb2 = q;
    };
    let mut s_limb3: u128 = Into::<_, felt252>::into(s.limb3).try_into().unwrap();
    if s_limb3 != 0 {
        while bits.len() != 288 {
            bits.append(0);
        }
    }
    while s_limb3 != 0 {
        let (q, r) = core::traits::DivRem::div_rem(s_limb3, 2);
        bits.append(r.into());
        s_limb3 = q;
    };
    bits
}
