// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Validator} from "../src/Validator.sol";

contract ValidatorScript is Script {

    address internal constant treasuryToken = 0x7b7958d29C37522B3970211C4b72662Dd18b01DA;
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Validator validator = new Validator(treasuryToken);
        console.log("Validator address: ", address(validator));
        vm.stopBroadcast();
    }
}
