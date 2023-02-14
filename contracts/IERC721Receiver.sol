// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns(bytes4);
}

//This interface and func "_checkOnERC721Received" in ERC721.sol allow us
//to understand that any address ("to" in func "_checkOnERC721Received") can receive NFT token
//and answer on our call in the func "_checkOnERC721Received"

//That is the difference between func "_transfer" and "_saveTransfer"!