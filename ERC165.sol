//SPDX-License-Identifier: MIT

import "./IERC165.sol";

pragma solidity ^0.8.0;

contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) external view virtual returns(bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

