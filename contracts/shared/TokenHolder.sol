// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.16;

import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @notice  Stores tokens for a parent contract.
 * @author  mStable
 * @dev     VERSION: 1.0
 *          DATE:    2022-05-30
 */
contract TokenHolder {
    using SafeERC20 for IERC20;

    /// @notice The address of the token to be stored.
    address public immutable token;
    /// @notice The address of the paraent contract the tokens are being stored for.
    address public immutable parent;

    /**
     * @notice Simple constructor that stores the parent and token addresses.
     * Also approves the parent contract to transfer the tokens from this contract.
     * @param _token The address of the token to be stored.
     */
    constructor(address _token) {
        parent = msg.sender;
        token = _token;

        IERC20(_token).safeApprove(msg.sender, type(uint256).max);
    }

    /**
     * @notice Re-approves the parent contract to spend the token.
     * Just incase for some reason approval has been reset.
     */
    function reApproveParent() external {
        IERC20(token).safeApprove(parent, type(uint256).max);
    }
}
