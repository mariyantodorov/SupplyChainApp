// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

import "./erc20Interface.sol";

contract ERC20Token is ERC20Interface {
    uint256 private constant MAX_UINT256 = 2**256 - 1;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

    uint256 public totalSupply; //Total number of tokens
    string public name; //Desciptive name
    uint8 public decimals; //How many decimals when displaying amounts
    string public symbol; //Short identifier for token

    constructor(
        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) {
        balances[msg.sender] = _initialAmount;
        totalSupply = _initialAmount;
        name = _tokenName;
        decimals = _decimalUnits;
        symbol = _tokenSymbol;
    }

    //Transfer tokens from msg.sender to a specified address
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(
            balances[msg.sender] >= _value,
            "Insufficient funds for transfer source."
        );
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    //Transfer tokens from one specified address to another specified address
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 c_allowance = allowed[_from][msg.sender];
        require(
            balances[msg.sender] >= _value && c_allowance >= _value,
            "Insufficient allowed funds for transfer source."
        );
        balances[_from] -= _value;
        balances[_to] += _value;
        if (c_allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    //Return the current balance (in tokens) of a specified address
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    //Set allowed
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    //Return the remaining allowed tokens to spend
    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }
}
