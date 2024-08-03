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

    mapping(address => uint256) private depositTime;
    mapping(address => uint256) private depositAmount;

    event Deposit(address indexed depositer, uint256 amount);
    event Withdraw(address indexed withdrawer, uint256 amount);
    
    constructor(address _treasuryToken) Ownable(msg.sender) {
        treasuryToken = IERC20(_treasuryToken);
    }

    function setTreasuryToken(address _treasuryToken) onlyOwner public {
        treasuryToken = IERC20(_treasuryToken);
    }

    function deposit(uint256 amount) public {
        uint256 balanceToken = treasuryToken.balanceOf(msg.sender);
        require(balanceToken >= amount, "amount should be less than balance of msg.sender");

        treasuryToken.transferFrom(msg.sender, address(this), amount);
        totalDeposit += amount;
        depositAmount[msg.sender] += amount;
        depositTime[msg.sender] = block.timestamp;

        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) onlyOwner public {
        require(totalDeposit >= amount, "amount should be less than total deposit amount");
        treasuryToken.transfer(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }

    function checkValidator(address account) public view returns (
        uint256 amount, uint256 lastDepositTime, bool bDeposit) {
        amount = depositAmount[account];
        lastDepositTime = depositTime[account];
        if (amount > 0) {
            bDeposit = true;
        }
        else {
            bDeposit = false;
        }
    }
}
