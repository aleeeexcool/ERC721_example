//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTSale is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    uint256 public salePrice = 100000000000000000;

    constructor() ERC721("Dao Donations NFT", "DDN") public {
    }

    function mintNFT(string memory tokenURI) public payable returns (bool) {
        
        require(msg.value >= salePrice, 'value sent needs to be atleast sale price');

          _tokenIds.increment();
          uint256 newItemId = _tokenIds.current();
          _mint(address(msg.sender), newItemId);
          _setTokenURI(newItemId, tokenURI);

        return true;
    }
    
    function withdraw(address payable owner) public onlyOwner returns(bool) {
        owner.transfer(address(this).balance);
        return true;

    }
    
    function setPrice(uint256 price) public onlyOwner returns (bool) {
        salePrice = price;
        return true;
    }
    
    function getBalanceContract() public view returns(uint){
        return address(this).balance;
    }
    

}