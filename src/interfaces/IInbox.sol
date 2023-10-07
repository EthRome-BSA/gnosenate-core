// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IInbox {
    function emitRequest(string calldata name) external returns (address, uint256);
    function emitReview(string calldata review) external;
}
