/// === In and Out === ///
function EaseInOutCubic(inputvalue,outputmin,outputmax,inputmax){
	inputvalue /= inputmax * 0.5

	if (inputvalue < 1)
	{
	   return outputmax * 0.5 * power(inputvalue, 3) + outputmin
	}

	return outputmax * 0.5 * (power(inputvalue - 2, 3) + 2) + outputmin
}

function EaseInOutQuart(inputvalue,outputmin,outputmax,inputmax){
	if(inputvalue >= 0){
		inputvalue /= inputmax * 0.5

		if (inputvalue < 1) 
		{
		    return outputmax * 0.5 * power(inputvalue, 4) + outputmin
		}

		return outputmax * -0.5 * (power(inputvalue - 2, 4) - 2) + outputmin
	} else {
		return 0
	}
}

/// === Out === ///
function EaseOutQuart(inputvalue,outputmin,outputmax,inputmax){
	return -outputmax * (power(inputvalue / inputmax - 1, 4) - 1) + outputmin;
}

function EaseOutCubic(inputvalue,outputmin,outputmax,inputmax){
	return outputmax * (power(inputvalue/inputmax - 1, 3) + 1) + outputmin;
}

function EaseOutQuad(inputvalue,outputmin,outputmax,inputmax){
	inputvalue /= inputmax;
	return -outputmax * inputvalue * (inputvalue - 2) + outputmin;
}