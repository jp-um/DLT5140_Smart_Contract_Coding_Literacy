pragma solidity ^0.5.12;

contract RockingChairity {

	enum ChairityState { Empty, Ready, Waiting }
	
	ChairityState public mode;
	uint public contractBalance;
	address payable public contractBeneficiary;
	uint public donationAmount;
	uint public timerStart;
	
	address public depositingOfficer;
	address public beneficiaryAssignmentOfficer;
	
	constructor (address _depositingOfficer,
	    address _beneficiaryAssignmentOfficer) public {
	    mode = ChairityState.Empty;
	    depositingOfficer = _depositingOfficer;
	    beneficiaryAssignmentOfficer = _beneficiaryAssignmentOfficer;
	    contractBalance = 0;
	    donationAmount = 0;
	}

    // setup the initial "fund" of 100 ethers
    // we will distribute these to charities in need
	function setup() public payable {
		require(mode == ChairityState.Empty);
		mode = ChairityState.Ready;
		contractBalance = msg.value;
	}

    function deposit() public payable {
        require(mode == ChairityState.Waiting || mode == ChairityState.Ready);
        require(msg.value > 0);
        contractBalance = contractBalance + msg.value;
    }

	function setBeneficiary(address payable beneficiary) public {
	    // Alice's address is D87...148, check she is making the call
	    require(msg.sender == beneficiaryAssignmentOfficer);
	    
		require(mode == ChairityState.Ready);
		mode = ChairityState.Waiting;
		contractBeneficiary = beneficiary;
	}

    function accept() public {
        require(msg.sender == beneficiaryAssignmentOfficer);
        
        contractBeneficiary.transfer(donationAmount);
        contractBalance = contractBalance - donationAmount;
        donationAmount = 0;
    }
    
    function reject() public {
        require(msg.sender == beneficiaryAssignmentOfficer);
        donationAmount = 0;
    }
    
    function timeout() public {
        require(now - timerStart >= 6 hours);
        contractBeneficiary = address(0);
    }

	function setAmount(uint amount) public {
	    require(msg.sender == depositingOfficer);
	    require(amount <= contractBalance);
		require(mode == ChairityState.Waiting);
		timerStart = now;
		mode = ChairityState.Ready;
		// send the money to the charity
		// contractBeneficiary.transfer(amount);
		// update the balance left after you dish out the money
		
		donationAmount = amount;
	}
	
}
