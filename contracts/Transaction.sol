// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

contract Transaction {
    function getBalance(address _address) public view returns (uint256) {
        uint256 balance = address(_address).balance;
        return balance;
    }
}
