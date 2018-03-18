pragma solidity ^0.4.18;

import './MintableToken.sol';
import './BurnableToken.sol';

contract MusicShare is MintableToken, BurnableToken {
    string public name = 'Music Share';
    string public symbol = 'MUS';
    uint8 public decimals = 18;
}
