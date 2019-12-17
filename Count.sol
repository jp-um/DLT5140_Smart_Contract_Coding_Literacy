pragma solidity ^0.5.12;

// A contract which counts
contract TrialRun {

	uint public count; // this is a dummy counter 

	constructor() public {
		count = 0;
	}

	function up() public payable {
	    require(msg.value >= 1 ether);
		count = count + 1; // increment the counter !
	}
} 
