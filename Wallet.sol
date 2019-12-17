pragma solidity ^0.5.12;

// A contract which counts
contract Wallet {
    
    // Wallets can only be open or close
    enum WalletState { OPENED, CLOSED }
    
    // state of this wallet contract
    WalletState public mode;
    
	constructor() public {
	    mode = WalletState.CLOSED; // closed at first
	}

    // students add comments !!
	function openWallet() public {
	    require(mode == WalletState.CLOSED);
	    mode = WalletState.OPENED;
	}

    // students add comments !!
	function closeWallet() public {
    	require(mode == WalletState.OPEN);
        mode = WalletState.CLOSE;
	}

    // students add comments !! 
	function deposit() public payable {
        require(mode == WalletState.OPEN);
        
	}
	
	function withdraw(uint amount) public {
    	require(mode == WalletState.OPEN);
    	require(amount <= address(this).balance);
    	msg.sender.transfer(amount);
	}
	
} 
