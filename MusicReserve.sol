pragma solidity ^0.4.18;

import "./MusicShare.sol";
import "./MusicReserveAuthorities.sol";

contract MusicReserve is MusicShare, MusicReserveAuthorities {
    /**
    * event for token purchase logging
    * @param purchaser who paid for the tokens
    * @param beneficiary who got the tokens
    * @param value weis paid for purchase
    * @param amount amount of tokens purchased
    */
    event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);

        /**
    * event when token exchanged
    * @param beneficiary who got the tokens
    * @param amount amount of tokens exchanged
    * @param value weis paid for exchange
    */
    event Exchange(address indexed beneficiary, uint256 amount, uint256 value);


    // how many token units a buyer gets per wei
    uint256 public rate;

    function MusicReserve() public {
        rate = 1050;
    }

    function() public payable {
        buyTokens(msg.sender);
    }

    // low level token purchase function
    function buyTokens(address _beneficiary) isAuthorized public payable {
        require(_beneficiary != 0x0);

        uint256 weiAmount = msg.value;

        // calculate token amount to be created
        uint256 tokens = weiAmount.mul(rate);

        _mint(_beneficiary, tokens);
        emit TokenPurchase(msg.sender, _beneficiary, weiAmount, tokens);
    }

    function exchangeTokens(uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount);
        uint256 etherToSend = _amount.div(rate);
        _burn(_amount);
        msg.sender.transfer(etherToSend);
        emit Exchange(msg.sender, _amount, etherToSend);
    }
}
