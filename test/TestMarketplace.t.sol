// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../src/Marketplace.sol";

contract TestMarketPlace is Test {
    NFTMarketplace marketplace;

    function setUp() public {
        marketplace = new NFTMarketplace();
    }

    function testCreateToken() public {
        // msg.sender for the next call will be address 1
        vm.prank(address(1));
        // created a token
        marketplace.createToken("tokenUri", 0.01 ether);
        vm.prank(address(2));
        marketplace.createToken("tokenUri", 0.01 ether);
        // checking for the update of tokenIds counter
        assertEq(marketplace._tokenIds(), 2);
        // created new address
        address alice = makeAddr("alice");
        // sending 2 ethers to new address
        vm.deal(alice, 2 ether);
        vm.prank(alice);
        // execute sale function called
        marketplace.executeSale{value: 0.01 ether}(1);
        // itemSold will be increase due to sale
        assertEq(marketplace._itemsSold(), 1);
        // checking the balance of smart contract
        assertEq(marketplace.balanceOf(alice), 1);
        vm.prank(alice);
        // checking balance of alice address
        assertEq(marketplace.balanceOf(alice), 1);
    }

    // When sending price for listing is less than tha actual listing price
    function testFailLowListPrice() public {
        vm.prank(address(1));
        marketplace.createToken("tokenUri", 0.001 ether);
    }

    // This test will fail because only owner can update the list price
    function testFailUpdateListPrice() public {
        vm.prank(address(1));
        marketplace.updateListPrice(0.22 ether);
    }

    // This function passes because the msg.sender will be the owner of the contract
    function testUpdateListPrice() public {
        marketplace.updateListPrice(0.22 ether);
        assertEq(marketplace.listPrice(), 0.22 ether);
    }
}
