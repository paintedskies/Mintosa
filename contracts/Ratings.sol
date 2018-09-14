pragma solidity ^0.4.17;
contract Ratings {

	address public lender;
	RateStar[] public ratings;
	
	/* Each Rating has a from address, to address and a rating value */
	struct RateStar{
	    address from;
	    address to;
	    uint ratingv;
	}

/* Assigning address to lender */
	constructor() public{
		lender = msg.sender;
	}
/* Log Statement to verify rating success or fail */
    event rateCast(bool success, address src, address to);
    
/* Rate using Rating value and address to rate */
	function rate(address toRate,uint ratingval) public returns (bool) {
		require(toRate != address(0));
		if (msg.sender == toRate) {
			emit rateCast(false, address(0), address(0));
			return false;
		}

    else{
    		/* Assign values to from, to and ratingval eg. 5 */
          	RateStar memory newRate;
	        newRate.from = msg.sender;
	        newRate.to = toRate;
	        newRate.ratingv=ratingval;
	        ratings.push(newRate);
	        emit rateCast(true, msg.sender, toRate);
	        return true;	
	      }
  }
}