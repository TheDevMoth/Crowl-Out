/// @desc Movement & interactions

//Run current state function
state()

////Collision detection
//if(!place_free(x+roundout(hspd), y)){
//	pushDirection = find_direction(hspd, "h")
//	vspd = 0
//	//Check if it is a collision with a pushable wall
//	ds_list_clear(wallsPushed)
//	var numWallsBeingPushed = instance_place_list(x+roundout(hspd), y, obj_movableWall, wallsPushed, false)
//	if(numWallsBeingPushed <= wallsCanPush){
//		var pushable = true //pushable until proven otherwise
//		for(var i = 0; i<numWallsBeingPushed; i+=1){
//			pushable = (pushable && wallsPushed[|i].push(floor(wallsCanPush/numWallsBeingPushed), 0, pushSpd*sign(hspd)))
//		}
//		if(pushable){
//			// TODO play sound
//			hspd = pushSpd*sign(hspd)
//		} else {
//			hspd = 0
//		}
//	} else {
//		hspd = 0
//	}
//}

//if(!place_free(x, y+roundout(vspd))){
//	vpushing = true
//	hspd = 0
//	//Check if it is a collision with a pushable wall
//	ds_list_clear(wallsPushed)
//	var numWallsBeingPushed = instance_place_list(x, y+roundout(vspd), obj_movableWall, wallsPushed, false)
//	if(numWallsBeingPushed <= wallsCanPush){
//		var pushable = true //pushable until proven otherwise
//		for(var i = 0; i<numWallsBeingPushed; i+=1){
//			pushable = (pushable && wallsPushed[|i].push(floor(wallsCanPush/numWallsBeingPushed), pushSpd*sign(vspd), 0))
//		}
//		if(pushable){
//			// TODO play sound
//			vspd = pushSpd*sign(vspd)
//		} else {
//			vspd = 0
//		}
//	} else {
//		vspd = 0
//	}
//} else {
//	vpushing = false
//}

////Movement
//x += hspd
//y += vspd

