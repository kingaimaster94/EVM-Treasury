// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Validator is ReentrancyGuard, Ownable {
    IERC20 public treasuryToken;
    string public name = "Validator Treaury";
    string public symbol = "ValidatorNetork";

    uint256 public totalDeposit;
    uint256 public dailyTokenAmount;

    mapping(address => uint256) private depositTime;
    mapping(address => uint256) private depositAmount;

    event Deposit(address indexed depositer, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);
    
    constructor(address _treasuryToken, uint256 _dailyTokenAmount) Ownable(msg.sender) {
        treasuryToken = IERC20(_treasuryToken);
        dailyTokenAmount = _dailyTokenAmount;
    }

    function setTreasuryToken(address _treasuryToken) onlyOwner public {
        treasuryToken = IERC20(_treasuryToken);
    }

    function setDailyTokenAmount(uint256 _dailyTokenAmount) onlyOwner public {
        dailyTokenAmount = _dailyTokenAmount;
    }

    function deposit(uint256 amount) public {
        uint256 balanceToken = treasuryToken.balanceOf(msg.sender);
        require(balanceToken >= amount, "amount should be less than balance of msg.sender");

        treasuryToken.transferFrom(msg.sender, address(this), amount);
        totalDeposit += amount;
        uint256 timestamp = block.timestamp;
        uint256 daily = (timestamp - depositTime[msg.sender]) / 1 days;
        if (daily * dailyTokenAmount > depositAmount[msg.sender]) {
            depositAmount[msg.sender] = 0;
        }
        depositAmount[msg.sender] += amount;
        depositTime[msg.sender] = timestamp;

        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) onlyOwner public {
        require(totalDeposit >= amount, "amount should be less than total deposit amount");
        treasuryToken.transfer(msg.sender, amount);
        totalDeposit -= amount;
        emit Withdraw(msg.sender, amount);
    }

    function checkValidator(address account) public view returns (
        uint256 amount, uint256 lastDepositTime, uint256 nCheckVal) {
        amount = depositAmount[account];
        lastDepositTime = depositTime[account];
        uint256 timestamp = block.timestamp;
        uint256 daily = (timestamp - lastDepositTime) / 1 days;
        if (lastDepositTime == 0) {
            nCheckVal = 0;
        }
        else if (daily * dailyTokenAmount > amount) {
            nCheckVal = 1;
        }
        else {
            nCheckVal = 2;
        }
    }
}
