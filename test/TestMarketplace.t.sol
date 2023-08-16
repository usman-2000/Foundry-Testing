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
        marketplace._tokenIds();
        assertEq(marketplace._tokenIds(),1);

    }

    
}