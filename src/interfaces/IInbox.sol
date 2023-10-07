// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IInbox {
    function emitRequest(string memory name) external;
    function emitReview(string memory review) external;
}
