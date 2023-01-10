//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721 {
    event Transfer(address indexed from, address indexed to, uint indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns(uint);

    //This func just shows how many NFTs owner has

    function ownerOf(uint tokenId) external view returns(address);

    //This func shows what the owner of "tokenId"

    function safeTransferFrom(
        address from,
        address to,
        uint tokenId
    ) external;

    //This one allows to transfer NFT berween the addresses (save transfer)

    function transferFrom(
        address from,
        address to,
        uint tokenId
    ) external;

    //This one works like "safeTransferFrom" but less save

    function approve(
        address to,
        uint tokenId
    ) external;

    //Allows "to" doing something with "tokenId"

    function setApprovalForAll(
        address operator,
        bool approved
    ) external;

    //Alows "operator" doing anything with owner's NFTs

    function getApproved(
        uint tokenId
    ) external view returns(address);

    //Shows which address can manage the token by "tokenId"

    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns(bool);
    
    //Shows the ability of the operator to dispose of the token or not 
}