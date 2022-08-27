//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.16;

contract iterable_mapping {


// this willcost a lot gas cause only to get the array of mapped keys length,first , last element will net these state variables.
// might be there a better way to get this done.
    mapping(address => uint) public balance ;
    mapping(address => bool) public isINSERTED;
    mapping(address => uint) public indexof_ARRAY;

    address[] public keys;
    
    receive() external payable{
        deposit();
    }

     function getfirst() public view returns(uint){
         
         return balance[keys[1]];
     }

     function getlast() public view returns(uint){
         return balance[keys[(keys.length) - 1]];
     }

     function getarraysize() public view returns(uint){
         return keys.length ;
     }


    function deposit() public payable {
        require(msg.value > 0);
        balance[msg.sender] = msg.value ;
        isINSERTED[msg.sender] = true;

        keys.push(msg.sender);
         indexof_ARRAY[msg.sender] = keys.length - 1 ;

    }

    function withdraw(uint _amount) external {
        require(_amount <= balance[msg.sender]);
        uint withdrawamount = _amount ;
        balance[msg.sender] -= _amount;

        

        delete keys[indexof_ARRAY[msg.sender]];
        payable(msg.sender).transfer(withdrawamount);
    } 
}
