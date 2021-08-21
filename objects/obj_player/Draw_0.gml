/// @desc
if(state != hold_state){
	if(cmdRIGHT()){
		image_xscale=-1
	} else if(cmdLEFT()) {
		image_xscale=1
	}
}

//Choose sprite according to state
//if(pushDirection==UP && state == push_state){
//	sprite_index = spr_crow_push //TODO add Up animation
//} else if(pushDirection==DOWN && state == push_state){
//	sprite_index = spr_crow_push //TODO add Down animation
//} else 
if(state == push_state){
	sprite_index = spr_crow_push
} else if(state == hold_state){
	if(pushCommand() && !pullCommand()){
		sprite_index = spr_crow_push
	} else if(pullCommand() && !pushCommand()){
		sprite_index = spr_crow_pull
	} else {
		sprite_index = spr_crow_hold
	}
} else if(hspd != 0){
	sprite_index = spr_crow_walk
} else if (vspd != 0){
	sprite_index = spr_crow_walk
} else { 
	sprite_index = spr_crow_idle
}

draw_self()