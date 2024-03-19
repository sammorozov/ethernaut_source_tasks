// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}


// Usage of delegatecall is particularly risky and has been used as an attack vector
// on multiple historic hacks. With it, your contract is practically saying
// "here, -other contract- or -other library-, do whatever you want with my state".
// Delegates have complete access to your contract's state.
//  The delegatecall function is a powerful feature, but a dangerous one, and must
// be used with extreme care.

// Please refer to the The Parity Wallet Hack Explained article for an accurate
// explanation of how this idea was used to steal 30M USD.




// contract Hash{
//   function getHash(string memory  _func) external pure returns(bytes32){
//     return  keccak256(abi.encodePacked(_func));
//   } 

// }    0:
//     bytes32: 0xdd365b8b15d5d78ec041b851b68c8b985bee78bee0b87c4acf261024d8beabab