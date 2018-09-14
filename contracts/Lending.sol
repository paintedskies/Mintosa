pragma solidity ^0.4.18;

contract Lending
{    
    /* User Flow
        1) Lender decides to give the money to the borrower, clicks on *Lend money*
            1a) addLoan(borrower) gets called (borrower_borrower_address) by lender address and the msg value whatever the lender decides to give
            NOTE: Ether paid from lender to SmartContract        
        2) Borrower later logs in and sees that request is fulfilled, clicks Accept loan
            2a) withdraw() gets called with his account
            NOTE: Ether gets paid from SmartContract to borrower
        3) When Borrower is able to payback, he clicks on *Payback loan*
            3a) paybackLoan get's called by borrower account and the msg value whatever the borrower decides to paybackLoan
            NOTE: Ether gets paid from borrower to Smart Contract
        4) Lender login and sees that his loan is paid back (either partially or fully) If he decides to withdraw
            4a)Withdraw() gets called by lender address 
            NOTE: Ether gets paid from Smart Contract to lender
            
    */	  
    
	struct loan{
        	address lender;
       		uint amount;
    	}

    //List of all withdrawals
	mapping (address => uint) pendingWithdrawals;
	
	//borrower addresses mapped to loans
	mapping (address => loan) loanList;
	
	 function Lending() public {
    	}
	function addLoan(address borrower) payable public {
	    loanList[borrower].lender = msg.sender;
	    loanList[borrower].amount = msg.value;
	    pendingWithdrawals[borrower] += msg.value;
	}
	
    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent re-entrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
    
    function paybackLoan() payable public {
        loanList[msg.sender].amount -= msg.value;
        pendingWithdrawals[loanList[msg.sender].lender] += msg.value;
    }
}