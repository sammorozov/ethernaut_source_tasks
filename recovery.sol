// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Recovery {

  //generate tokens
  function generateToken(string memory _name, uint256 _initialSupply) public {
    new SimpleToken(_name, msg.sender, _initialSupply);
  
  }
}

contract SimpleToken {

  string public name;
  mapping (address => uint) public balances;

  // constructor
  constructor(string memory _name, address _creator, uint256 _initialSupply) {
    name = _name;
    balances[_creator] = _initialSupply;
  }

  // collect ether in return for tokens
  receive() external payable {
    balances[msg.sender] = msg.value * 10;
  }

  // allow transfers of tokens
  function transfer(address _to, uint _amount) public { 
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] = balances[msg.sender] - _amount;
    balances[_to] = _amount;
  }

  // clean up after ourselves
  function destroy(address payable _to) public {
    selfdestruct(_to);
  }
}


/*

Contract addresses are deterministic and are calculated by keccak256(address, nonce) 
where the address is the address of the contract (or ethereum address that created
 the transaction) and nonce is the number of contracts the spawning contract
  has created (or the transaction nonce, for regular transactions).

Because of this,
 one can send ether to a pre-determined address
  (which has no private key) and later create a contract
   at that address which recovers the ether. This is a non-intuitive
    and somewhat secretive way to (dangerously) store ether without
     holding a private key.

An interesting blog post by Martin
 Swende details potential use cases of this.

If you're going to implement this technique,
 make sure you don't miss the nonce, or your
  funds will be lost forever.
*/
