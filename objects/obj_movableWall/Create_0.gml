/// @desc Set up
//Pick a random sprite
//sprite_index = sprite
solid = true
wallInTheWay = noone

init_push = function(wallsCanPush, hdist, vdist){
	//check if player can push this many walls
	if(wallsCanPush == 0){
		return false
	}
	//Check for walls
	if(!place_free(x+sign(hdist), y+sign(vdist))){
		//Check for movable walls
		wallInTheWay = instance_place(x+sign(hdist), y+sign(vdist), obj_movableWall)
		if(wallInTheWay == noone){
			return false //immovable wall
		} else if(wallInTheWay.init_push(wallsCanPush-1, hdist, vdist)){
			//Success
			return true
		} else {
			wallInTheWay = noone
			return false //second wall can not be moved
		}
	} else {
		//Case nothing in the way
		return true
	}
}

push = function(hdist, vdist){
	if(wallInTheWay != noone){
		wallInTheWay.push(hdist, vdist)
	}	
	x += hdist
	y += vdist
}

snap = function(){
	wallInTheWay = noone
	if((x % 16 != 0) && (x % 16 <= 2)){
		x -= x%16
		show_debug_message("Snapped")
	} else if (x % 16 >= 14){
		x += 16 - x%16
		show_debug_message("Snapped")
	}

	if((y % 16 != 0) && (y % 16 <= 2)){
		y -= y%16
		show_debug_message("Snapped")
	} else if (y % 16 >= 14){
		y += 16 - y%16
		show_debug_message("Snapped")
	}
	
}