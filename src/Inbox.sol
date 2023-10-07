// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";
import "sismo-connect-solidity/SismoConnectLib.sol";

contract Inbox is IInbox, SismoConnect {

    
    using SismoConnectHelper for SismoConnectVerifiedResult;
    // Events
    event RequestEmited(bytes32 nameEncoded);
    event ProtocolRegistered(bytes32 nameEncoded);
    event ReviewEmited(bytes32 name, bytes32 review);

    // Errors
    error ProtocolNotRegistered(bytes32 name);
    error NotAContract(address _address);
    error NotRegisteredForReview(address _address, string message);

    // Mappings
    mapping(address => bytes32) contractToAppName;
    mapping(address => mapping(address => uint256)) userToContractVisitationFreq;
    mapping(bytes32 => mapping(uint256 => bytes32)) protocolToUsersReview;

    bytes16 private _appId = 0x0;
    bool private _isImpersonationMode = true;

    //Constructor
    constructor() SismoConnect(buildConfig(_appId, _isImpersonationMode)) {}

    /**
    Function to register the contract's name
    @param name : The name the cotnract wants to give its app in the registry.
     */
    function registerContract(string calldata name) external {
        if (_isContract(msg.sender)) {
            contractToAppName[msg.sender] = keccak256(abi.encode(name));
            emit ProtocolRegistered(keccak256(abi.encode(name)));
        } else {
            revert NotAContract(msg.sender);
        }
    }

    /**
    Function to register the call by the user of some contract
    @param name : Name given to the App by the contract
    @param caller : address of the caller
    @param contractAddress : address of the contract calling the function
     */

    function registerCall(
        string calldata name,
        address caller,
        address contractAddress
    ) external returns (address, uint256) {
        bytes32 nameEncoded = keccak256(abi.encode(name));

        if (contractToAppName[caller] == 0) {
            revert ProtocolNotRegistered(nameEncoded);
        }

        if (!_isContract(contractAddress)) {
            revert NotAContract(contractAddress);
        }

        uint256 freq = userToContractVisitationFreq[caller][contractAddress]++;
        emit RequestEmited(nameEncoded);
        return (caller, freq);
    }

    /**
    Function to write and emit a review
    @param review : review to write
    @param caller : address calling the contract
    @param contractAddress : contract address calling the function
     */
    function propagateReview(
        address caller,
        address contractAddress,
        Review memory review,
        bytes memory response
    ) external {
        if (userToContractVisitationFreq[caller][contractAddress] == 0) {
            revert NotRegisteredForReview(
                caller,
                "Use the protocol to make review"
            );
        }

        SismoConnectVerifiedResult memory result = verify({
            responseBytes: response,
            auth: buildAuth({authType: AuthType.VAULT}),
            signature: buildSignature({message: abi.encode(caller, review)})
        });

        uint256 vaultId = result.getUserId(AuthType.VAULT);
        bytes32 encodedReview = keccak256(abi.encode(review.score, review));
        bytes32 encodedName = keccak256(abi.encode(review.name));

        protocolToUsersReview[encodedName][vaultId] = encodedReview;

        // TODO : implement logic with the review.

        emit ReviewEmited(encodedName, encodedReview);
    }

    /**
    Function to verify if an address is a contract
    @param _candidateAddress : address to verify
     */

    function _isContract(
        address _candidateAddress
    ) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_candidateAddress)
        }
        return size == 0;
    }
}
