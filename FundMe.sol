//Get funds from user
//Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "PriceConvertor.sol";

contract FundME {
    using PriceConvertor for uint256; //Attaching the library to all uint256.

    uint256 public minUsd = 5e18;

    address[] public funders;
    mapping(address funders => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        //Allow users to send $
        //Have a minimum $ sent
        require(msg.value.getConversionRate() >= minUsd, "didn't send enough ETH"); //1e18 = 1 * 10 ** 18 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender];
    }
 }