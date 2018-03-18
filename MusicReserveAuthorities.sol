pragma solidity ^0.4.18;

import './Ownable.sol';

contract MusicReserveAuthorities is Ownable {
    event AuthorityAdded(address indexed _authority, address indexed _by);
    event AuthorityRemoved(address indexed _authority, address indexed _by);

    mapping(address => bool) public authorities;

    modifier isAuthorized() {
        require(authorities[msg.sender]);
        _;
    }

    function addAuthority(address _address) onlyOwner public {
        authorities[_address] = true;
        emit AuthorityAdded(_address, owner);
    }

    function removeAuthority(address _address) onlyOwner public {
        delete authorities[_address];
        emit AuthorityRemoved(_address, owner);
    }
}
