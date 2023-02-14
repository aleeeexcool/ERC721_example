//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721.sol";

contract NFTSale is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private tokenId;
    
    uint public salePrice = 1000000000000000000;
    
    function setPrice(uint price) public onlyOwner returns (bool) {
        salePrice = price;
        return true;
    }
    
    function getBalanceContract() public view returns(uint){
        return address(this).balance;
    }
    
    function withdraw(address _to) external onlyOwner {
        payable(_to).transfer(address(this).balance);
    }

}