//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./ERC721Enumerable.sol";
import "./ERC721URIStorage.sol";

contract CoolBearsCollection is ERC721, ERC721Enumerable, ERC721URIStorage {

    address public owner;
    uint currentTokenId;
    string public collectionName;
    string public collectionNameSymbol;

    struct CoolBear {
        uint tokenId;
        string tokenName;
        string tokenURI;
        address payable mintedBy;
        address payable currentOwner;
        address payable previousOwner;
        uint price;
        uint numberOfTransfers;
        bool forSale;
    }

    mapping(uint => CoolBear) public allCoolBears;
    mapping(string => bool) public tokenNameExists;
    mapping(string => bool) public tokenURIExists;

    constructor() ERC721("Cool Bears Collection", "CB") {}

    function mintCoolBear(string memory _name, string memory _tokenURI, uint _price) external {
        require(msg.sender != address(0));
        require(!_exists(currentTokenId));
        require(!tokenURIExists[_tokenURI]);
        require(!tokenNameExists[_name]);

        _mint(msg.sender, currentTokenId);
        _setTokenURI(currentTokenId, _tokenURI);
        currentTokenId++;

        tokenURIExists[_tokenURI] = true;
        tokenNameExists[_name] = true;

        CoolBear memory newCoolBear = CoolBear(
        currentTokenId,
        _name,
        _tokenURI,
        payable(msg.sender),
        payable(msg.sender),
        payable(address(0)),
        _price,
        0,
        true);
        allCoolBears[currentTokenId] = newCoolBear;
    }

    function getTokenOwner(uint _tokenId) public view returns(address) {
        address _tokenOwner = ownerOf(_tokenId);
        return _tokenOwner;
    }

    function getTokenMetaData(uint _tokenId) public view returns(string memory) {
        string memory tokenMetaData = tokenURI(_tokenId);
        return tokenMetaData;
    }

    function getNumberOfTokensMinted() public view returns(uint) {
        uint totalNumberOfTokensMinted = totalSupply();
        return totalNumberOfTokensMinted;
    }

    function getTotalNumberOfTokensOwnedByAnAddress(address _owner) public view returns(uint) {
        uint totalNumberOfTokensOwned = balanceOf(_owner);
        return totalNumberOfTokensOwned;
    }

    function getTokenExists(uint _tokenId) public view returns(bool) {
        bool tokenExists = _exists(_tokenId);
        return tokenExists;
    }

    function buyToken(uint _tokenId) public payable {
        require(msg.sender != address(0));
        require(_exists(_tokenId));

        address tokenOwner = ownerOf(_tokenId);

        require(tokenOwner != address(0));
        require(tokenOwner != msg.sender);

        CoolBear memory coolbear = allCoolBears[_tokenId];

        require(msg.value >= coolbear.price);
        require(coolbear.forSale);

        _transfer(tokenOwner, msg.sender, _tokenId);
        address payable sendTo = coolbear.currentOwner;
        sendTo.transfer(msg.value);
        coolbear.previousOwner = coolbear.currentOwner;
        coolbear.currentOwner = payable(msg.sender);
        coolbear.numberOfTransfers += 1;
        allCoolBears[_tokenId] = coolbear;
    }

    function changeTokenPrice(uint _tokenId, uint _newPrice) public {
        require(msg.sender != address(0));
        require(_exists(_tokenId));

        address tokenOwner = ownerOf(_tokenId);

        require(tokenOwner == msg.sender);

        CoolBear memory coolbear = allCoolBears[_tokenId];
        coolbear.price = _newPrice;
        allCoolBears[_tokenId] = coolbear;
    }

    function toggleForSale(uint _tokenId) public {
        require(msg.sender != address(0));
        require(_exists(_tokenId));

        address tokenOwner = ownerOf(_tokenId);

        require(tokenOwner == msg.sender);

        CoolBear memory coolbear = allCoolBears[_tokenId];

        if(coolbear.forSale) {
        coolbear.forSale = false;
        } else {
        coolbear.forSale = true;
        }
        allCoolBears[_tokenId] = coolbear;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        pure
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _burn(uint _tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(_tokenId);
    }

    function tokenURI(
        uint _tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(_tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint _tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, _tokenId);
    }
}
