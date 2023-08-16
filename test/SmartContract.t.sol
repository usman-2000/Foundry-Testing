// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {console, Test} from "forge-std/Test.sol";
import {MyToken} from "../src/SmartContract.sol";

contract SmartContractTest is Test {
    MyToken mytoken;

    function setUp() public {
        mytoken = new MyToken();
    }

    function testSafeMint() public {
        vm.expectRevert();
        vm.prank(address(1));
        mytoken.safeMint(address(2), "https://sdasda.com");
    }

    function testSafeMintCorrectAddress() public {
        mytoken.safeMint(address(2), "https://sdasda.com");
    }

    function testSetUser() public {
        vm.expectRevert();
        vm.prank(address(1));
        mytoken.setUser(2, address(2), 22221313);
        // console.log(address(1));
    }
}
