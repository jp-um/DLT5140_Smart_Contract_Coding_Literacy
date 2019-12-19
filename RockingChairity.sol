pragma solidity ^0.5.12;

contract RockingChairity {

	enum ChairityState { Empty, Ready, Waiting }
	
	ChairityState public mode;
	
	constructor () public {
	    mode = ChairityState.Empty;
	}

    // setup the initial "fund" of 50 ethers
    // we will distribute these to charities in need
	function setup() public payable {
		require(mode == ChairityState.Empty);
		require(msg.value == 50 ether); // setup 50 eth fund
		mode = ChairityState.Ready;
	}

	function setBeneficiary() public {
	    // [REQ] has to be called by ALICE
	    // [INPUT] We have to receive the address (and we need to store it)
		require(mode == ChairityState.Ready);
		mode = ChairityState.Waiting;
	}

	function setAmount() public {
	    // [REQ] only Bob may call this
	    // [REQ] amount should be less than or equal to balance
	    // [INPUT] we need to set the amount
		require(mode == ChairityState.Waiting);
		mode = ChairityState.Ready;
		// [PROCESS] send money (amount) to the charities address
		// [PROCESS] update balance (?)
	}
	
}
