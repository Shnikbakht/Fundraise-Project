// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minimumUSD = 1 * 1e18; // Represents $1 in 18-decimal scaling
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
 
        // Fund function
    function fund() public payable {

        require(
            msg.value.getConversionRate() >= minimumUSD,
            "You need to send more ETH!"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        }
    
    function withraw() public {
        for (uint funderIndex = 0; funderIndex>funders.length;funderIndex++){
          address funder = funders[funderIndex];
          addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool callSuccess,)= payable(msg.sender).call{value:address(this).balance}("");
        require (callSuccess,"call failed");
    }

}
