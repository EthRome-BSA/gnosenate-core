// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IInbox {

    struct Review {
        uint8 score;
        string name; 
        string review;
    }

    function registerContract(string calldata name) external;

    function registerCall(
        string calldata name,
        address caller,
        address contractAddress
    ) external returns (address, uint256);

    function propagateReview(
        address caller,
        address contractAddress,
        Review memory review,
        bytes memory response
    ) external;
}
