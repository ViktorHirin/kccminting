// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTmint is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(string => uint8) hashes;

    uint256 TOTAL_SUPPLY = 10000;
    uint256  MINT_FEE;
    address payable owner;

    constructor() ERC721("KSF token", "KSFNFT") {
        owner = payable(msg.sender);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function setMintFee(uint256 _fee) public onlyOwner {
        MINT_FEE = _fee;
    }
    
    function getMintFee() public view returns(uint256) {
        return MINT_FEE;
    }
    
    function setOwner(address _new) public onlyOwner {
        owner = payable(_new);
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function mintToken(address user, string memory metadataURI)
    public 
    returns (uint256)
    {
        
        _tokenIds.increment();
        uint256 id = _tokenIds.current();
        require(id <= TOTAL_SUPPLY, "Tokens are minted over totalSupply!");
        _safeMint(user, id);
        _setTokenURI(id, metadataURI);
        return id;
    }
}