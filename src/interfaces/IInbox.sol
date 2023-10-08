// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import {Structs} from "src/libraries/structs.sol";

interface IInbox {
    function registerContract(address caller) external;

    function registerCall(
        address caller,
        address contractAddress
    ) external returns (address, uint256);

    function propagateReview(
        Structs.Review memory review,
        bytes memory response
    ) external;
}
