// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../src/Marketplace.sol";

contract TestMarketPlace is Test{
    NFTMarketplace marketplace;

    function setUp() public{
        marketplace = new NFTMarketplace();
    }

    function testCreateToken() public{
        vm.prank(address(1));
        marketplace.createToken("tokenUri",0.01 ether);
        vm.prank(address(2));
        marketplace.createToken("tokenUri",0.01 ether);
        assertEq(marketplace._tokenIds(),2);
        assertEq(marketplace.idToListedToken[1].owner,address(1));
    }

    function testFailLowListPrice() public{
        vm.prank(address(1));
        marketplace.createToken("tokenUri",0.001 ether);

    }

    
}