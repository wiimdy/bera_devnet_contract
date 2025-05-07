// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import { Script, console2 } from "forge-std/Script.sol";
import { Upgrades, Options } from "openzeppelin-foundry-upgrades/Upgrades.sol";

/// @notice This script is used to validate the upgrade of any upgradeable contract.
/// @dev This will fail if any storage collisions are detected.
/// @dev Need to run forge clean && forge compile before running this script.
contract ValidatePOLUpgrade is Script {
    function run() public {
        vm.startBroadcast();
        // To validate the upgrade, we need to provide the upgraded contract name and the options
        // Either contract name should point to the deployed contract that is being upgraded using
        // @custom:oz-upgrades-from ContractV1
        // or `referenceContract` should be specified in the Options object.

        // Check BeraChef safe upgrade
        Options memory options; // create an empty options object.
        options.referenceContract = "BeraChef_V0.sol:BeraChef_V0";
        Upgrades.validateUpgrade("BeraChef.sol", options);
        console2.log("BeraChef can be upgraded successfully.");

        // Check RewardVault safe upgrade
        options.referenceContract = "RewardVault_V0.sol:RewardVault_V0";
        Upgrades.validateUpgrade("RewardVault.sol", options);
        console2.log("RewardVault can be upgraded successfully.");

        // check RewardVault 3 days rewards duration upgrade
        options.referenceContract = "RewardVault_V1.sol:RewardVault_V1";
        Upgrades.validateUpgrade("RewardVault.sol", options);
        console2.log("RewardVault V2 can be upgraded successfully.");

        // check RewardVault incentive token management upgrade
        options.referenceContract = "RewardVault_V2.sol:RewardVault_V2";
        Upgrades.validateUpgrade("RewardVault.sol", options);
        console2.log("RewardVault V3 can be upgraded successfully.");

        // check RewardVault 3 incentive tokens upgrade
        options.referenceContract = "RewardVault_V3.sol:RewardVault_V3";
        Upgrades.validateUpgrade("RewardVault.sol", options);
        console2.log("RewardVault V4 can be upgraded successfully.");

        // Check RewardVaultFactory safe upgrade
        options.referenceContract = "RewardVaultFactory_V0.sol:RewardVaultFactory_V0";
        Upgrades.validateUpgrade("RewardVaultFactory.sol", options);
        console2.log("RewardVaultFactory can be upgraded successfully.");
        vm.stopBroadcast();
    }
}
