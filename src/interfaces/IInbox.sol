// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IInbox {
    function registerContract(string calldata name) external;

    function registerCall(
        string calldata name,
        address caller,
        address contractAddress
    ) external returns (address, uint256);

    function emitReview(
        string calldata review,
        address caller,
        address contractAddress
    ) external;
}
