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
        // assertEq(marketplace.idToListedToken[1].owner,address(1));

        // Here, changing the address to address(3) but it has 0 ether. So, giving it 2 ethers by vm.deal .

        // vm.prank(address(3));
        // vm.deal(address(3),2 ether);

        // It is working until i do not call executeSale method. When i call it, the prank function reverts.

        address alice = makeAddr("alice");
        vm.deal(alice,2 ether);
        vm.prank(alice);
        marketplace.executeSale{value: 0.01 ether}(1);
        // assertEq(marketplace._itemsSold(),1);
        assertEq(marketplace.balanceOf(alice),0);
    }

    // function testFailLowListPrice() public{
    //     vm.prank(address(1));
    //     marketplace.createToken("tokenUri",0.001 ether);

    // }

    
}