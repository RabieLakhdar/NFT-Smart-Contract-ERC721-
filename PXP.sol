// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.1/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@5.0.1/access/Ownable.sol";

contract PixelPioneers is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    uint256 private MAX_SUPPLY;
    uint256 public _mint_users_supply;

    constructor(address initialOwner)
        ERC721("PixelPioneers", "PXP")
        Ownable(initialOwner)
    {
        MAX_SUPPLY = 1000;
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        require(_nextTokenId < MAX_SUPPLY, "Max NFT limit reached");
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following function for self mint without owner legibility
    function safeMintForUsers(address to, string memory uri) public {
        require(_nextTokenId < MAX_SUPPLY, "Max NFT limit reached");
        uint256 tokenId = _nextTokenId++;
        _mint_users_supply++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
