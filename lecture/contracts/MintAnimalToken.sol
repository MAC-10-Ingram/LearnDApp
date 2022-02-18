// SPDX-License-Identifier: MIT
//라이센스

//사용할 컴파일러 버전
pragma solidity ^0.8.0;

//NFT에 대한 인터페이스가 ERC721
//openzeppelin에서는 ERC721Enumerable를 통해서 확장된 기능을 제공
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintAnimalToken is ERC721Enumerable {
    //생성자() ERC721(name, symbol) {}
    constructor() ERC721("h662Animals","HAS"){

    }

    mapping(uint256 => uint256) public animalTypes;

    function mintAnimalToken() public {
        //유일한 값
        //totalSupply는 오픈체펠린에서 제공, 현제까지 발행된 토큰의 갯수 반환
        uint256 animalTokenId = totalSupply() + 1;

        //랜덤한 수를 만드는법
        //현재시간, 메세지 작성자, 아이디를 시드로 해서 랜덤하게 1 ~ 5를 생성
        uint256 animalType = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, animalTokenId))) % 5 + 1;

        animalTypes[animalTokenId] = animalType;

        //ERC721가 제공하는 함수
        //1) 발행을 요청한 사람, msg.sender = 명령어를 실행한 사람
        //2) NFT를 증명하는 토큰 아이디
        _mint(msg.sender,animalTokenId);
    }
}