// 
function approach(current, increment, target){
	if (current < target)
	{
	    current = min(current+increment, target); 
	}
	else
	{
	    current = max(current-increment, target);
	}
	return current;
}

//Removes the fraction from a number
function trunc(number){
	return floor(abs(number))*sign(number)
}

//Rounds away from zero.
// roundout(1.3) = 2; roundout(-2.4) = -3
function roundout(number){
	return trunc(number)+sign(number)
}