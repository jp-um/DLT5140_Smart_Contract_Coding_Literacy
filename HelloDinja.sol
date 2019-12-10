pragma solidity ^0.5.12;

// Just a Hello World basic program (contract)

contract HelloDinja {
    
    /* 
        Functions can be declared pure in which case they promise not to read from or modify the state.
    */
    function helloDinja () public pure returns (string memory) { // this memory is required as string is an array implementation
        return 'Hello, Dinja!';
    }
    
}


