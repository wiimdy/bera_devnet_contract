// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.26;

import { IPOLErrors } from "./IPOLErrors.sol";
import { IBeraChef } from "./IBeraChef.sol";

/// @notice Interface of the Distributor contract.
interface IDistributor is IPOLErrors {
    /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
    /*                           EVENTS                           */
    /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/

    event Distributed(bytes indexed valPubkey, uint64 indexed nextTimestamp, address indexed receiver, uint256 amount);

    /**
     * @notice Distribute the rewards to the reward allocation receivers.
     * @dev Permissionless function to distribute rewards by providing the necessary Merkle proofs. Reverts if the
     * proofs are invalid.
     * @param nextTimestamp The timestamp of the next beacon block to distribute for. The EIP-4788 Beacon Roots
     * contract is queried by this key, returning the parent beacon block root from the next timestamp.
     * @param proposerIndex The proposer index of the beacon block. This should be the validator index corresponding
     * to the pubkey in the validator registry in the beacon state.
     * @param pubkey The validator pubkey of the proposer.
     * @param proposerIndexProof The Merkle proof of the proposer index in the beacon block.
     * @param pubkeyProof The Merkle proof of the validator pubkey of the proposer in the beacon block.
     */
    function distributeFor(
        uint64 nextTimestamp,
        uint64 proposerIndex,
        bytes calldata pubkey,
        bytes32[] calldata proposerIndexProof,
        bytes32[] calldata pubkeyProof
    )
        external;

    /// @notice Returns the address of the BeraChef contract.
    function beraChef() external view returns (IBeraChef);
}
