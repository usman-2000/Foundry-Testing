// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/NewNftMarketplace.sol";

contract TestNFTMarket is Test{
    NFTMarket nftmarket;

    function setUp() public{
        nftmarket = new NFTMarket();
    }

    function testCreatingToken() public{
        vm.prank(address(1));
        nftmarket.createNFT("TokenUri");
        vm.prank(address(1));
        nftmarket.listNFT(1,1 ether);
        assertEq(nftmarket._tokenIDs(),1);
        vm.prank(address(2));
        nftmarket.createNFT("TokenUri1");
        assertEq(nftmarket._tokenIDs(),2);
        vm.deal(address(3),2 ether);
        vm.prank(address(3));
        nftmarket.buyNFT{value : 1 ether}(1);
        assertEq(nftmarket.balanceOf(address(3)),1);
    }

    function testCancelListing() public{
        vm.prank(address(1));
        nftmarket.createNFT("TokenUri");
        vm.prank(address(1));
        // listing the nft on the marketplace
        nftmarket.listNFT(1,1 ether);
        vm.prank(address(1));
        // cancel the listed Nft
        nftmarket.cancelListing(1);
    }
}