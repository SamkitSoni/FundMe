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

    address public owner;

    constructor() {
        owner = msg.sender;
     }

    function fund() public payable {
        //Allow users to send $
        //Have a minimum $ sent
        require(msg.value.getConversionRate() >= minUsd, "didn't send enough ETH"); //1e18 = 1 * 10 ** 18 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender];
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);
        //actually withdraw the funds

        // //msg.sender = address;
        // //payable(msg.sender) = payable address
        // //transfer
        // payable(msg.sender).transfer(address(this).balance);//this refers to the whole contract
        // //send(difference between send and transfer is that; transfer returns the error whereas the send returns the true or false value.
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Fail"); 
        // //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be Owner !");
        _; //whatever you wanna do in the function
        //order of this undersocre matters
    }
 }