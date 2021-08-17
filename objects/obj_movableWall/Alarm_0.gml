/// @desc Snap to grid
if(x % 16 < 1){
	x -= x%16
} else if (x % 16 > 15){
	x += 16 - x%16
}

if(y % 16 < 1){
	y -= y%16
} else if (y % 16 > 15){
	y += 16 - y%16
}