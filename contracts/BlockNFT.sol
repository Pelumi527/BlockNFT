//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BlockNFT is ERC721 {
    
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;

    uint maxSupply = 10;

    string public baseExtension = ".json";
    string currentBaseURI;
    constructor() ERC721("BlockNFT", "BNFT"){
        _tokenId.increment();
    }

    function mintNFT(uint mintAmount) public returns(bool){
        require(_tokenId.current() <= maxSupply, "All NFT has being minted");
        for(uint i = 1; i <= mintAmount; i++ ){
            _safeMint(msg.sender, _tokenId.current());
            _tokenId.increment();
        }
        return true;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), baseExtension)) : "";
    }

    function setBaseURl(string memory _newBaseURI) public {
        currentBaseURI = _newBaseURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return currentBaseURI;
    }

    function totalMinted() public view returns(uint) {
        return _tokenId.current()- 1;
    }
}

