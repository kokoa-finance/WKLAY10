// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2015, 2016, 2017 Dapphub
// Adapted by Ethereum Community 2021
pragma solidity 0.7.6;

interface WKLAY9Like {
    function withdraw(uint) external;
    function deposit() external payable;
    function transfer(address, uint) external returns (bool);
    function transferFrom(address, address, uint) external returns (bool);
}

interface WKLAY10Like {
    function depositTo(address) external payable;
    function withdrawFrom(address, address, uint256) external;
}

contract WklayConverter {
    WKLAY9Like private immutable wklay9; // claimaswap wklay
    WKLAY10Like private immutable wklay10; // wklay v10

    constructor(address wklay9_, address wklay10_) {
        wklay9 = WKLAY9Like(wklay9_);
        wklay10 = WKLAY10Like(wklay10_);
    }
    
    receive() external payable {}

    function wklay9ToWklay10(address account, uint256 value) external payable {
        wklay9.transferFrom(account, address(this), value);
        wklay9.withdraw(value);
        wklay10.depositTo{value: value + msg.value}(account);
    }

    function wklay10ToWklay9(address account, uint256 value) external payable {
        wklay10.withdrawFrom(account, address(this), value);
        uint256 combined = value + msg.value;
        wklay9.deposit{value: combined}();
        wklay9.transfer(account, combined);
    }
}