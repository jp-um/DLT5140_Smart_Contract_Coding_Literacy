pragma solidity ^0.5.12;

contract SharedWallet {

	uint public walletBalance;
	address public walletOwner;
    // allowed users
    mapping(address => bool) public isAuthorized;

	constructor (address owner)  public {
		walletBalance = 0;
		walletOwner = owner;
		isAuthorized[walletOwner] = true;
	}

	function addAuthorised(address addressToAdd) public {
		require(msg.sender == walletOwner);
		isAuthorized[addressToAdd] = true;
	}

	function removeAuthorised(address addressToRemove) public {
		require(msg.sender == walletOwner);
		require(addressToRemove != walletOwner);
		isAuthorized[addressToRemove] = false;		
	}
	
	function deposit() public payable {
		 walletBalance = walletBalance + msg.value;
	}

	function payOut(address payable destination, uint amount) public {
		require(isAuthorized[msg.sender]);
		// or require(isAuthorized[msg.sender] == true);
		require(amount <= walletBalance);
		walletBalance = walletBalance - amount;
		destination.transfer(amount);
	}


}
