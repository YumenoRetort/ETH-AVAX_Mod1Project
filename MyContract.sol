// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract MyContract {

    mapping(address => uint256) public balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balances[msg.sender] = _initialSupply; // Assign initial supply to contract deployer
    }

    // Function to transfer tokens to another address
    function transfer(address _to, uint256 _amount) public {
        // Check if sender has enough tokens
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Check for overflow in balance calculation
        assert(balances[_to] + _amount >= balances[_to]);

        // Transfer tokens
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }

    // Function to burn tokens (reduce total supply)
    function burn(uint256 _amount) public {
        // Check if there are enough tokens to burn
        if(balances[msg.sender] >= _amount){
            // Ensure total supply
            assert(totalSupply >= _amount);

            // Burn tokens
            balances[msg.sender] -= _amount;
            totalSupply -= _amount;
            
        }
        else{
            revert("Insufficient balance to burn");
        }

    }
}

