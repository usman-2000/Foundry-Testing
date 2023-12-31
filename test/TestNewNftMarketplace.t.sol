// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/NewNftMarketplace.sol";

contract TestNFTMarket is Test {
    NFTMarket nftmarket;

    function setUp() public {
        nftmarket = new NFTMarket();
    }

    function testCreatingToken() public {
        vm.prank(address(1));
        nftmarket.createNFT("TokenUri");
        // address(1) balance should be 1 as it created a new nft
        assertEq(nftmarket.balanceOf(address(1)),1);
        vm.prank(address(1));
        nftmarket.listNFT(1, 1 ether);
        assertEq(nftmarket._tokenIDs(), 1);
        vm.prank(address(2));
        nftmarket.createNFT("TokenUri1");
        assertEq(nftmarket._tokenIDs(), 2);
        vm.deal(address(3), 2 ether);
        // address(3) will buy nft of address(1) whose tokenid is 1
        vm.prank(address(3));
        nftmarket.buyNFT{value: 1 ether}(1);
        assertEq(nftmarket.balanceOf(address(3)), 1);
        vm.prank(address(1));
        nftmarket.withdrawFunds();
        // Address(1) balance should be 0
        assertEq(nftmarket.balanceOf(address(1)),0);
    }

    // The listing of this specific seller of specific token id will be cancel
    function testCancelListing() public {
        vm.prank(address(1));
        nftmarket.createNFT("TokenUri");
        vm.prank(address(1));
        // listing the nft on the marketplace
        nftmarket.listNFT(1, 1 ether);
        vm.prank(address(1));
        // cancel the listed Nft
        nftmarket.cancelListing(1);
    }

    // This will fail because the address who cancel this listing is not the actual seller.
    function testFailCancelListing() public{
        vm.prank(address(1));
        nftmarket.createNFT("TokenUri");
        vm.prank(address(1));
        // listing the nft on the marketplace
        nftmarket.listNFT(1, 1 ether);
        vm.prank(address(2));
        // can't cancel the listing of token id 1 because this address is not the seller
        nftmarket.cancelListing(1);
    }

    // test will fail because it has zero balance
    function testFailWithdrawFunds() public{
        vm.prank(address(1));
        nftmarket.withdrawFunds();
    }
}
