/// @desc Snap to grid
var playerHolding;

with(obj_player){
	playerHolding = (state == hold_state)
}
if(!playerHolding){
	if((x % 16 != 0) && (x % 16 <= 1)){
		if (!place_meeting(x-x%16,y, all)){
			x -= x%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 8
		}
	} else if (x % 16 >= 15){
		if (!place_meeting(x+16-x%16,y, all)){
			x += 16 - x%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 8
		}
	
	}

	if((y % 16 != 0) && (y % 16 <= 1)){
		if (!place_meeting(x,y-y%16, all)){
			y -= y%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 8
		}
	} else if (y % 16 >= 15){
		if (!place_meeting(x,y+16-y%16, all)){
			y += 16 - y%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 8
		}
	}
} else {
	alarm[8] = 0
}
