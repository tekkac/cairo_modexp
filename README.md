# Modular exponentation in Cairo

## About
An Cairo implementation of modular exponentation:
$
\text{modexp}(x,y,n) = x^y\ \mathbf{mod}\ n
$

Pseudo-code algorithm for the non-trivial cases:
```
result = 1
base = x
for bits in get_bits_little_endian(y):
    if bit == 1:
        result = (result * base) mod n
    base = (base * base) mod n
return result
```

Two implementations are provided:
  - `mod_exp_cairo(x: u256, y: u256, n:u256) -> u256` using u512 wide multiplication
  - `mod_exp_circuit(x: u384, y: u384, n:u384) -> u384` using Circuits for the inner loop

### Pre-requisites
 - [asdf](https://asdf-vm.com/guide/getting-started.html)
 - [Scarb >= v2.8.2](https://docs.swmansion.com/scarb/)

### Usage

```bash
scarb fmt
scarb build
scarb test
```
