// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Changeowner{

    address public timeZone1Library;
    address public timeZone2Library;
    uint public owner; 
    
    function addressToUint(address _addr) public  pure returns(uint256){
        return uint(uint160(_addr));
    }


    function setTime(uint256 _time) public {
        owner = _time;

    }
}



// 0x67A7EdaF656ECd9676F0a8F481D6cFe1E05aF33e

/*

As the previous level, delegate mentions, 
the use of delegatecall to call libraries can be risky.
 This is particularly true for contract libraries that have their own state.
  This example demonstrates why the library keyword should be used for building libraries,
   as it prevents the libraries from storing and accessing state variables.
*/
