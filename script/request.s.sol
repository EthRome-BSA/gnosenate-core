// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "src/BaseReviewer.sol";
import "src/Inbox.sol";
import "src/Registry.sol";
import "src/VanillaVault.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        bytes16 appId = 0;
        Registry reg = new Registry();
        Inbox inbox = new Inbox(appId, "base", address(reg));
        Vault vault = new Vault(
            0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
            address(inbox),
            "base"
        );

        vm.stopBroadcast();
    }
}
