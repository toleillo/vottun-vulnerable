pragma solidity 0.8.27;

contract VulnerableLottery {
    address[] public players;
    address public recentWinner;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function enter() public payable {
        require(msg.value == 1 ether, "Must send exactly 1 Ether to enter");
        players.push(msg.sender);
    }

    function _pickWinner() internal {
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players))) % players.length;
        recentWinner = players[randomIndex];
        payable(recentWinner).transfer(address(this).balance);
        delete players;
    }

    function pickWinner() public {
        _pickWinner();
    }

    receive() external payable {}
}
