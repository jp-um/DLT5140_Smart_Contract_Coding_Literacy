pragma solidity ^0.5.12;

contract Gambling {
    
    enum STATUS { AWAIT_BET, AWAIT_GUESS, AWAIT_RESULT }
    enum COIN { HEAD, TAIL }
    
	STATUS betStatus;	
	COIN guess;
	uint public betAmount;
    address payable public jane;
    address payable public peter;
    
	constructor(address payable _jane, address payable _peter) public {
    	betStatus = STATUS.AWAIT_BET;
    	jane = _jane;
    	peter = _peter;
    	betAmount = 0;
    	
	}

    function createBet() public payable {
    	require (betStatus == STATUS.AWAIT_BET);
        require (msg.sender == jane);

    	betAmount = msg.value;	
    	betStatus = STATUS.AWAIT_GUESS;
	}

	function makeGuess(COIN g) public payable {
    	require (betStatus == STATUS.AWAIT_GUESS);
        require (msg.sender == peter);
        require (msg.value == betAmount);
	
    	guess = g;
	    betStatus = STATUS.AWAIT_RESULT;
	}

	function revealCoin(COIN toss) public {
	    require (betStatus == STATUS.AWAIT_RESULT);
        require (msg.sender == jane);
	
    	if (guess == toss) {
            peter.transfer(betAmount * 2);
        } else {
            jane.transfer(betAmount * 2);
        }
 
    	betStatus = STATUS.AWAIT_BET;
    }
	
}
