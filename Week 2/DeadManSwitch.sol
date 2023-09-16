pragma solidity ^0.8.18;

contract DeadManSwitch {
    address public owner;
    address payable public to_send_address;
    uint256 public last_active_block;
    
    constructor(address payable _to_send_address) {
        owner = msg.sender;
        to_send_address = _to_send_address;
        last_active_block = block.number;
        
    }

    function still_alive() public {
        //if user calls this function, it means they are still active
        last_active_block = block.number;
    }

    function deadManSwtich_Active() public {
        require(msg.sender == owner, "Only owner is allowed to call this function");
        require(block.number >= last_active_block + 10, "The owner is still active");

        // Send all of the contract's balance to the set address address
        to_send_address.transfer(address(this).balance);
    }
}