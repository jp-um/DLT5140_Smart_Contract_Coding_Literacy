pragma solidity ^0.5.12;

contract PiggyBank {
    
	int numberOfDeposits;
    uint timeOfFirstDeposit;
    bool isBroken;
    address payable jpAccountAddress; // payable as you want to
    address payable piggyBank;
    // address public owner;


	constructor() public {
		numberOfDeposits = 0;
		timeOfFirstDeposit = 0;
		isBroken = false;
		jpAccountAddress = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C; // taken from remix IDE
		piggyBank = 0xDd7e0CA48332aECCf7839209eE43eeC8a3ba0Eb5;
	}

    // payable will either send or recieve money
	function depositToPiggyBank() public payable {
		// Any money sent with this 
        // goes into the piggy bank contract.
        //require(msg.sender==jpAccountAddress);

        // The piggy bank has not been broken
        require(isBroken == false);


        // If this is the first deposit,  record the
        // date and time of first deposit.
        if (numberOfDeposits==0)
	        timeOfFirstDeposit = now;
        
        numberOfDeposits = numberOfDeposits+1;
        piggyBank.transfer(msg.value);
	}

	function breakPiggyBank() public payable {
	    // goes into the piggy bank contract.
        //require(msg.sender==jpAccountAddress);

        // The piggy bank has not been broken
        //require(isBroken == false);
	    
		// It must be one year since the first deposit.
        //require (now - timeOfFirstDeposit > 365 days);

        // Send all money in the piggy bank to John.
        jpAccountAddress.transfer(100);

        //isBroken = true;
	}
	
}

