/// @desc Snap to grid
var canSnap = true

with(obj_player){
	if(state == hold_state){
		canSnap = (ds_list_find_index(wallsPushed,id)==-1)
	}
}
if(canSnap){
	if((x % 16 != 0) && (x % 16 <= 1.5)){
		if (!place_meeting(x-x%16,y, all)){
			x -= x%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 10
		}
	} else if (x % 16 >= 14.5){
		if (!place_meeting(x+16-x%16,y, all)){
			x += 16 - x%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 10
		}
	
	}

	if((y % 16 != 0) && (y % 16 <= 1.5)){
		if (!place_meeting(x,y-y%16, all)){
			y -= y%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 10
		}
	} else if (y % 16 >= 14.5){
		if (!place_meeting(x,y+16-y%16, all)){
			y += 16 - y%16
			show_debug_message("Snapped")
		} else {
			alarm[0] = 10
		}
	}
} else {
	alarm[8] = 0
}
