// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import {MyToken} from "../src/SmartContract.sol";

contract SmartContractTest is Test{
    MyToken mytoken;

    function setUp() public{
        mytoken = new MyToken;
    }

}