/// @desc Movement & interactions

//Dcide which code to run depending on state (walking / pushing)
if (!pushing){
		///---- Walking ---- ///
	//Input for movement
	if(RUN)
		maxSpd = runSpd	
	else 
		maxSpd = walkSpd
	if(RIGHT)	hspd += moveAcc
	if(LEFT)	hspd -= moveAcc
	if(UP)		vspd -= moveAcc
	if(DOWN)	vspd += moveAcc

	//Slowing down
	vspd -= vspd/maxSpd*moveAcc
	hspd -= hspd/maxSpd*moveAcc
} else {
		///---- Pushing ---- ///
	//Check if still pushing
	switch(pushDirection){
		case "Right":
			var pushHspd = pushSpd
			var pushVspd = 0
			var isStillPushing = RIGHT
		break
		case "Left":
			var pushHspd = -pushSpd
			var pushVspd = 0
			var isStillPushing = LEFT
		break
		case "Up":
			var pushHspd = 0
			var pushVspd = -pushSpd
			var isStillPushing = UP
		break
		case "Down":
			var pushHspd = 0
			var pushVspd = pushSpd
			var isStillPushing = DOWN
		break
	}
	
	if(isStillPushing){
		//ask the wall if it can be pushed
		var pushable = pushedWall.push(wallsCanPush, pushVspd, pushHspd)
		if(pushable){
			// TODO play sound
			hspd = pushHspd
			vspd = pushVspd
		} else {
			hspd = 0
			vspd = 0
		}
	} else {
		pushing = false
		pushDirection = noone
		pushedWall = noone
		hspd = -pushHspd*5
		vspd = -pushVspd*5
		//hspd = 0
		//vspd = 0
		//x -= pushHspd*5
		//y -= pushVspd*5
		sprite_index = spr_crowPlaceholder
	}
}

//Collision detection
if(hspd != 0 && !place_free(x+roundout(hspd), y) && !pushing){
	//Check if it is a collision with a pushable wall
	pushedWall = instance_place(x+roundout(hspd), y, obj_movableWall)
	if(pushedWall != noone){
		pushing = true
		pushDirection = (hspd> 0) ? "Right" : "Left"
		sprite_index = spr_crowPushPlaceholder
		vspd = 0
		//y=round(y)
	}
	hspd = 0
	//x = round(x)
}

if(vspd != 0 && !place_free(x, y+roundout(vspd)) && !pushing){
	//Check if it is a collision with a pushable wall
	pushedWall = instance_place(x, y+roundout(vspd), obj_movableWall)
	if(pushedWall != noone){
		pushing = true
		pushDirection = (vspd> 0) ? "Down" : "Up"
		sprite_index = spr_crowPushPlaceholder
		hspd = 0
		//x = round(x)
	}
	
	vspd = 0
	//y = round(y)
}

//Movement
x += hspd
y += vspd