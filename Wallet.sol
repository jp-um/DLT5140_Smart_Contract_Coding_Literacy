pragma solidity ^0.5.12;

// A contract which counts
contract Wallet {
    
    // Wallets can only be open or close
    enum WALLET { OPEN, CLOSE }
    
    // state of this wallet contract
    WALLET state public;

	constructor() public {
	    state = WALLET.CLOSE; // closed at first
	}

	function openWallet() public {
	    require(state == WALLET.CLOSE);
	    state = WALLET.OPEN;
	}

	function closeWallet() public {
    	require(state == WALLET.OPEN);
        state = WALLET.CLOSE;
	}

	function deposit() public payable {
        require(state == WALLET.OPEN);
        
	}
	
	function withdraw(uint amount) public {
    	require(state == WALLET.OPEN);
    	msg.sender.transfer(amount);
	}
	
} 
