// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

        // Get ETH/USD price from Chainlink price feed
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        ); // Chainlink price feed for ETH/USD
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // Adjust to 18 decimals
    }

    // Get conversion rate for ETH to USD
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice(); // Price of 1 ETH in USD (scaled to 18 decimals)
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}