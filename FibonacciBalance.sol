//Example from the Mastering Ethereum book
// Version of Solidity compiler this program was written for
pragma solidity ^0.6.4;

contract FibonacciBalance {
    address public fibonacciLibrary;
    // The current Fibonacci number to withdraw
    uint public calculatedFibNumber;
    // The starting Fibonacci sequence number
    uint public start = 3;
    uint public withdrawalCounter;
    // The Fibonacci function selector
    bytes4 constant fibSig = bytes4(keccak256("setFibonacci(uint256)"));

    // Constructor - loads the contract with ether
    constructor(address _fibonacciLibrary) public payable {
        fibonacciLibrary = _fibonacciLibrary;
    }

    // Withdraw function
    function withdraw() public {
        withdrawalCounter += 1;
        // Calculate the Fibonacci number for the current withdrawal user
        // This sets `calculatedFibNumber`
        (bool success, ) = fibonacciLibrary.delegatecall(abi.encodeWithSelector(fibSig, withdrawalCounter));
        require(success, "Delegatecall failed");

        // Transfer the calculated Fibonacci value as Ether
        msg.sender.transfer(calculatedFibNumber * 1 ether);
    }

    // Fallback function - allows users to call Fibonacci library functions
    fallback() external payable {
        fibonacciLibrary.delegatecall(msg.data);
    }
}
