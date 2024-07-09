// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract MyContract {
    address public shelterOwner;
    mapping(address => uint256) public rescues;
    uint256 public dogs;

    constructor(uint256 _initialSupply) {
        shelterOwner = msg.sender;
        dogs = _initialSupply;
        rescues[msg.sender] = _initialSupply;
    }

    // Function to adopt dogs
    function adopt(address _to, uint256 _dogs) public {
        require(_to != shelterOwner, "The shelter cannot adopt dogs");
        require(rescues[shelterOwner] >= _dogs, "There are not enough dogs to adopt");

        if(msg.sender != shelterOwner){
            revert("You are not the shelter");
        }

        assert(rescues[_to] + _dogs >= rescues[_to]);

        rescues[msg.sender] -= _dogs;
        rescues[_to] += _dogs;

    }

    // Function to check if an address has adopted dogs
    function checkDogs(address _to) public view returns (string memory) {
        if (rescues[_to] < 1) {
            revert ("This person has not adopted a dog");
        } else {
            revert ("This person has adopted a dog/dogs");
        }
    }

    // Function to return adopted dogs
    function returnDog(uint256 _dogs) public {
        require(msg.sender != shelterOwner, "The shelter cannot return dogs");
        require(rescues[msg.sender] >= _dogs, "This family does not own that much dogs");

        rescues[msg.sender] -= _dogs;
        rescues[shelterOwner] += _dogs;

    }
}
