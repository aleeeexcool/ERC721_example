//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Enumerable.sol";

contract CoolBearsCollection is ERC721Enumerable {

    uint allTokenIds;
    uint tokenId;
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
        allTokenIds++;
        require(!_exists(tokenId));
        require(!tokenURIExists[_tokenURI]);
        require(!tokenNameExists[_name]);

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);

        tokenURIExists[_tokenURI] = true;
        tokenNameExists[_name] = true;

        CoolBear memory newCoolBear = CoolBear(
        tokenId,
        _name,
        _tokenURI,
        payable(msg.sender),
        payable(msg.sender),
        payable(address(0)),
        _price,
        0,
        true);
        allCoolBears[tokenId] = newCoolBear;
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
}
