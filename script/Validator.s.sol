// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Validator} from "../src/Validator.sol";

contract ValidatorScript is Script {

    address internal constant treasuryToken = 0x43E309117Aa5D4681d9788dBb359A802d52961dC;
    uint256 internal constant dailyTokenAmount = 100 * 1e18;
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Validator validator = new Validator(treasuryToken, dailyTokenAmount);
        console.log("Validator address: ", address(validator));
        vm.stopBroadcast();
    }
}
