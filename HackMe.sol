//SPDX-License-Identifier: MIT
// Code from https://hackernoon.com/smart-contract-vulnerabilities-understanding-and-safeguarding-against-delegatecall-attacks
// Common in scenarios like proxy contracts, upgradeable contracts, or modular contracts

pragma solidity ^0.8.20;

contract Lib {
    uint public someNumber;

    function doSomething(uint _num) public {
        someNumber = _num;
    }
}

contract HackMe {
    address public lib;
    address public owner;
    uint public someNumber;

    constructor(address _lib) {
        lib = _lib;
        owner = msg.sender;
    }

    function doSomething(uint _num) public {
        lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)", _num));
    }
}
