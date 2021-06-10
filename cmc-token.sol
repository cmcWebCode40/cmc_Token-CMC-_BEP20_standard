//SPDX-License-Identifier: GL-3.0 

pragma solidity ^0.8.4;


contract cmcToken {
    uint public totalSupply = 100000 * 10 **18 ;
    string public name = "cmcToken";
    string public symbol = "CMC";
    uint  public decimal = 18;
    address public onwer;
    
    string internal INSUFFICIENT_BALANCE = 'insufficient Balance';
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    
    
    event Transfer (
        address indexed from,
        address indexed to,
        uint indexed value
    );
        
    event Approval(
        address indexed owner, 
        address indexed spender,
        uint value
    );
    
    constructor(){
        balances[msg.sender] = totalSupply;
        onwer = msg.sender;
    }
    
    function balanceOf(address _owner) public view returns(uint256){
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns(bool){
        require(balanceOf(msg.sender) >= _value,INSUFFICIENT_BALANCE);
        balances[_to] += _value;
        balances[msg.sender] -=_value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint _value) public returns(bool){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns(bool){
        require(balanceOf(_from)>=_value, INSUFFICIENT_BALANCE);
        require(allowance[_from][msg.sender] >= _value, 'allowance very low');
        balances[_to] +=_value;
        emit Transfer(_from, _to, _value);
        return true;
        
    }
    
}
