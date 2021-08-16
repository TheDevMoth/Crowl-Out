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