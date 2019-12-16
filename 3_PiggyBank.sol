pragma solidity ^0.5.12;

contract PiggyBank {
    
	uint public johnBal;
	uint public peterBal;
	uint public janeBal;
	uint public bal;
    uint timeOfFirstDeposit;
    uint numberOfDeposits;
    bool isBroken;
    address payable public johnOwner;
    address payable public janeOwner;
    address payable public peterOwner;

	constructor(address payable _johnOwner, address payable _peterOwner, address payable _janeOwner) public {
		bal = 0;
		johnBal = 0;
		peterBal = 0;
		janeBal = 0;
		timeOfFirstDeposit = 0;
		numberOfDeposits = 0;
		isBroken = false;
		johnOwner = _johnOwner;
		janeOwner = _janeOwner;
		peterOwner = _peterOwner;
	}

    // payable will either send or recieve money
	function depositToPiggyBank() public payable {
        // only these three may deposit
        require(msg.sender == johnOwner || msg.sender == janeOwner || msg.sender == peterOwner);

        // The piggy bank has not been broken
        require(isBroken == false);


        // If this is the first deposit,  record the
        // date and time of first deposit.
        if (numberOfDeposits==0)
	        timeOfFirstDeposit = now;
        
        numberOfDeposits = numberOfDeposits + 1;
        bal = bal + msg.value;
        if (msg.sender == johnOwner) {
            johnBal = johnBal + msg.value;
        } else if (msg.sender == janeOwner) {
            janeBal = janeBal + msg.value;
        } else if (msg.sender == peterOwner) {
            peterBal = peterBal + msg.value;
        }
	}
	

	function breakPiggyBank() public {
	    // only owner may break contract
        require(msg.sender == johnOwner || msg.sender == janeOwner || msg.sender == peterOwner);

        // The piggy bank has not been broken
        require(isBroken == false);
	    
		// It must be one year since the first deposit.
        //require (now - timeOfFirstDeposit > 365 days);
        
        uint limit = address(this).balance / 3;
        if (msg.sender == johnOwner) {
            require(johnBal > limit );
            johnOwner.transfer(address(this).balance);
        } else if (msg.sender == janeOwner) {
            require(janeBal > limit );
            janeOwner.transfer(address(this).balance);
        } else if (msg.sender == peterOwner) {
            require(peterBal > limit );
            peterOwner.transfer(address(this).balance);
        }

        isBroken = true;
        bal = 0;
        
	}
	
	
}
