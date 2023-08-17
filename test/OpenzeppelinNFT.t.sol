// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/OpenZeppelinNft.sol";
import "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

contract OpenZeppelinNftTests is Test {
    using stdStorage for StdStorage;

    OpenZeppelinNft private nft;

    function setUp() public {
        nft = new OpenZeppelinNft("TestNFT","TNFT","baseURI");
    }

    function testFail_ForNoMintPrice() public {
        vm.expectRevert(bytes("No mint price paid"));
        nft.mintTo(address(1));
    }

    function testWithMintPrice() public {
        nft.mintTo{value: 0.08 ether}(address(1));
    }

    function testFail_TotalSupplyLimitCross() public {
        uint256 slot = stdstore.target(address(nft)).sig("currentTokenId()").find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
        vm.store(address(nft), loc, mockedCurrentTokenId);
        nft.mintTo{value: 0.08 ether}(address(1));
    }

    function testFailMintToZeroAddress() public {
        nft.mintTo{value: 0.08 ether}(address(0));
    }

    function testRegisteredNewMintOwner() public {
        nft.mintTo{value: 0.08 ether}(address(1));
        assertEq(nft.ownerOf(1), address(1));

        // second method (Tutorial)
        // nft.mintTo{value: 0.08 ether}(address(1));
        // uint256 slotOfNewOwner = stdstore.target(address(nft)).sig(nft.ownerOf.selector).with_key(1).find();
        // uint160 ownerOfTokenIdOne = uint160(uint256(vm.load(address(nft),bytes32(abi.encode(slotOfNewOwner)))));
        // assertEq(address(ownerOfTokenIdOne),address(1));
    }

    function testBalanceOfOwner() public {
        nft.mintTo{value: 0.08 ether}(address(1));
        assertEq(nft.balanceOf(address(1)), 1);

        nft.mintTo{value: 0.08 ether}(address(1));
        assertEq(nft.balanceOf(address(1)), 2);
    }
}
