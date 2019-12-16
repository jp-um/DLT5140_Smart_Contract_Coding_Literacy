pragma solidity ^0.5.12;

contract PiggyBank {
    
	uint public bal;
    uint timeOfFirstDeposit;
    uint numberOfDeposits;
    bool isBroken;
    address payable public owner;

	constructor(address payable _owner) public {
		bal = 0;
		timeOfFirstDeposit = 0;
		numberOfDeposits = 0;
		isBroken = false;
		owner = _owner;
	}

    // payable will either send or recieve money
	function depositToPiggyBank() public payable {
        // anyone may deposit

        // The piggy bank has not been broken
        require(isBroken == false);


        // If this is the first deposit,  record the
        // date and time of first deposit.
        if (numberOfDeposits==0)
	        timeOfFirstDeposit = now;
        
        numberOfDeposits = numberOfDeposits + 1;
        bal = bal + msg.value;
	}
	

	function breakPiggyBank() public {
	    // only owner may break contract
        require(msg.sender == owner);

        // The piggy bank has not been broken
        require(isBroken == false);
	    
		// It must be one year since the first deposit.
        //require (now - timeOfFirstDeposit > 365 days);

        // Send all money in the piggy bank to John.
//        bal = address(this).balance;
        owner.transfer(address(this).balance);
        isBroken = true;
        
	}
	
	
}
