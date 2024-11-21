// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage{
    uint256 public  favoriteNumber;
 
    struct People{
        string name;
        uint256 favoriteNumber;
    }
    People[] public people;
    function store(uint _favoriteNumber) public virtual{
        favoriteNumber=_favoriteNumber;
    }

    function addPerson(uint _favoriteNumber, string memory _name) public{
        People memory newPerson = People(_name,_favoriteNumber);
        people.push(newPerson);
    }
    
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
}
