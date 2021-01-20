pragma solidity >=0.4.22 <0.8.0;
contract Token {

    string private name;
    mapping(address => uint)public balances;
    uint private totalSuply;
    mapping(address => bool)public isCreated;
    uint nbHolder;
    address top1;
    address top2;
    address top3;
    
    // CONSTRUCTOR
    
    constructor() public {
        name = "MyToken";
        totalSuply = 500;
    }
    
    //  FUNCTIONS
    function transferFrom(address _From, address _To, uint amount) public {
        require(balances[_From] > amount, "Balance is not enough !");
        balances[_From] = balances[_From] - amount;
        checkTopHoldersDown(_From);
        balances[_To] = balances[_To] + amount;
        if(!isCreated[_To]){ 
            nbHolder += 1;
            isCreated[_To] = true;
        }
        checkTopHoldersUp(_To);
    }
    
    function mintToken(address _To, uint amount) public {
        require(amount <= totalSuply, "Amount is over the total supply !");
        balances[_To] = balances[_To] + amount;
        totalSuply -= amount;
        if(!isCreated[_To]){ 
            nbHolder += 1;
            isCreated[_To] = true;
        }
        checkTopHoldersUp(_To);
    }
    
    function burnToken(address _To, uint amount) public {
        require(balances[_To] > amount, "Balance is not enough to burn that much !");
        balances[_To] = balances[_To] - amount;
        checkTopHoldersDown(_To);
    }
    
    function checkTopHoldersUp(address _To) public {
        if(balances[_To] > balances[top1] && _To != top1){
            top3 = top2;
            top2 = top1;
            top1 = _To;
        } else if (balances[_To] > balances[top2] && _To != top2 && _To != top1) {
            top3 = top2;
            top2 = _To;
        } else if (balances[_To] > balances[top3] && _To != top3 && _To != top2 && _To != top1) {
            top3 = _To;
        }
    }
    
    function checkTopHoldersDown(address _To) public {
        if(_To == top1){
            if(balances[_To] < balances[top3]){
                top1 = top2;
                top2 = top3;
                top3 = _To;
                
            } else if (balances[_To] < balances[top2]) {
                top1 = top2;
                top2 = _To;
            }
        } else if (_To == top2) {
            if(balances[_To] < balances[top3]){
                top2 = top3;
                top3 = _To;
                
            }
        }
    }
    
    function getTop1Holder() public view returns (address) {
        return top1;
    }
    
    function getTop2Holder() public view returns (address) {
        return top2;
    }
    
    function getTop3Holder() public view returns (address) {
        return top3;
    }
    
    function getTotalSupply() public view returns (uint) {
        return totalSuply;
    }
}
