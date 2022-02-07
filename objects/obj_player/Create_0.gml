/// @desc Set up variables and states

// Variables that control feel
moveAcc = 0.3
walkSpd = 1
runSpd = 3
pushSpd = 0.125
wallsCanPush = 1 //number of walls crow can push together
pushKnockbackMult = -4 //
pullBufferDistance = 6 //Minimum number of pixels between the player and the object behind them when pulling. to disallow players from half pulling
swingDistance = 2 //The up and down movement of shown items in pixels

// Variables used for logic
framesToPush = TILE_W/pushSpd
crntPF = 0 // current push frame
maxSpd = walkSpd
hspd = 0
vspd = 0
state = noone
pushDirection = noone
pullDirection = noone
pushCommand = noone
pullCommand = noone
wallsPushed = ds_list_create() //Objects being currently pushed by the player
heldPickableSpr = noone
drawHalo = noone
global.snap = true
alarm[0] = 1

/// ---- State code ---- ///
/// Free State ///
free_state = function(){
	//Input for movement
	if(cmdRUN())
		maxSpd = runSpd	
	else 
		maxSpd = walkSpd
	if(cmdRIGHT())	hspd += moveAcc
	if(cmdLEFT())	hspd -= moveAcc
	if(cmdUP())		vspd -= moveAcc
	if(cmdDOWN())	vspd += moveAcc

	//Slowing down
	vspd -= vspd/maxSpd*moveAcc
	hspd -= hspd/maxSpd*moveAcc
	//Snap speed to zero (since the above equation can go on forever)
	if(abs(vspd) < moveAcc/4) vspd = 0
	if(abs(hspd) < moveAcc/4) hspd = 0
	
	//Collision detection
	if(hspd != 0 && !place_free(x+roundout(hspd), y)){
		pushDirection = find_direction(hspd, "h")
		pushCommand = command_from_direction(pushDirection)
		pullDirection = find_opposite_direction(pushDirection)
		pullCommand = command_from_direction(pullDirection)
		hspd = 0
		vspd = 0
		state = hold_state
	}
	if(vspd != 0 && !place_free(x, y+roundout(vspd))){
		pushDirection = find_direction(vspd, "v")
		pushCommand = command_from_direction(pushDirection)
		pullDirection = find_opposite_direction(pushDirection)
		pullCommand = command_from_direction(pullDirection)
		hspd = 0
		vspd = 0
		state = hold_state
	}
	
	//Movement
	x += hspd
	y += vspd
}

/// Push State ///
push_state = function(){
	//Player pushing
	if(pushCommand()) {
		push(pushDirection)
		lastDir = pushDirection
	//Player pulling
	} else if (pullCommand()) {
		push(pullDirection)
		lastDir = pullDirection
	//player does not change direction
	} else {
		push(lastDir)
	}
}

/// Hold State ///
hold_state = function(){
	if(pushCommand() && !pullCommand()){
		init_push("Push")
	} else if (pullCommand() && !pushCommand()){
		init_push("Pull")
	} else if (cmdPICKUP()){
		for(var i = 0; i<ds_list_size(wallsPushed); i++){
			if(object_is_ancestor(wallsPushed[|i].object_index, obj_pickable)){
				state = collect_state
				collect(wallsPushed[|i].object_index)
				heldPickableSpr = wallsPushed[|i].sprite_index
				letGo(0)
				break
			}
		}
	//Player let go
	} else if(!cmdHOLD()){
		state = free_state
		letGo()
	}
}

/// Collect State ///
collect_state = function(){
	//No input just showing off the item
	if(!drawHalo && (cmdMove())){
		collect_end()
	}
}

state = free_state

/// ---- Functions ---- ///
init_push = function(pushOrPull){
	//Check for walls
	if(!instance_place(x+hsign_from_direction(pushDirection), y+vsign_from_direction(pushDirection), obj_wall)){
		ds_list_clear(wallsPushed)
		//Check for movable walls, if none are found it is an immovable wall
		numWallsBeingPushed = instance_place_list(x+hsign_from_direction(pushDirection)*maxSpd, y+vsign_from_direction(pushDirection)*maxSpd, obj_movableWall, wallsPushed, false)
		
		var pushable = false
		var pullable = false
		if(numWallsBeingPushed <= wallsCanPush && numWallsBeingPushed != 0){
			//Pullable
			pushable = true //pushable until proven otherwise
			for(var i = 0; i<numWallsBeingPushed; i+=1){
				pushable = (pushable && wallsPushed[|i].init_push(floor(wallsCanPush/numWallsBeingPushed), pushSpd*hsign_from_direction(pushDirection), pushSpd*vsign_from_direction(pushDirection)))
			}
			
			//Pushable
			pullable = place_free(x+(TILE_W*hsign_from_direction(pullDirection)), y+(TILE_H*vsign_from_direction(pullDirection)))
		}
		if(pushOrPull=="Push"){
			if(pushable){
				state = push_state
				
				for(var i = 0; i<numWallsBeingPushed; i+=1){
					wallsPushed[|i].push(pushSpd*hsign_from_direction(pushDirection), pushSpd*vsign_from_direction(pushDirection))
				}
				x += pushSpd*hsign_from_direction(pushDirection)
				y += pushSpd*vsign_from_direction(pushDirection)
				
				crntPF = 1
				lastDir = pushDirection
			} else
				state = hold_state
		} else {
			if (pullable){
				state = push_state
				for(var i = 0; i<numWallsBeingPushed; i+=1){
					wallsPushed[|i].push(pushSpd*hsign_from_direction(pullDirection), pushSpd*vsign_from_direction(pullDirection))
				}
				x += pushSpd*hsign_from_direction(pullDirection)
				y += pushSpd*vsign_from_direction(pullDirection)
				
				crntPF = -1
				lastDir = pullDirection
			} else
				state = hold_state
		}
	}
}
push = function(pDirection){
	if(abs(crntPF)<framesToPush && crntPF!=0){
		for(var i = 0; i<numWallsBeingPushed; i+=1){
			wallsPushed[|i].push(pushSpd*hsign_from_direction(pDirection), pushSpd*vsign_from_direction(pDirection))
		}
		x += pushSpd*hsign_from_direction(pDirection)
		y += pushSpd*vsign_from_direction(pDirection)
		if(pDirection == pushDirection)
			crntPF++
		else
			crntPF--
	} else {
		state = hold_state
		crntPF = 0
	}
}

letGo = function(moveMult = 1){
	x -= hsign_from_direction(pushDirection)
	y -= vsign_from_direction(pushDirection)
	vspd = pushKnockbackMult*pushSpd*vsign_from_direction(pushDirection)*moveMult
	hspd = pushKnockbackMult*pushSpd*hsign_from_direction(pushDirection)*moveMult
	
	global.snap = true
	alarm[0] = 1
	
	ds_list_clear(wallsPushed)
	numWallsBeingPushed = 0
	pushDirection = noone
	pullDirection = noone
	pushCommand = noone
	pullCommand = noone
}

collect = function(itemID){
	//check Item type
	//if Upgrade create upgrade showoff object
	if(object_is_ancestor(itemID.object_index, obj_pickableUpgrade)){
		var showoffID = instance_create_layer(0,0,"Controllers",obj_showoff_upgrade)
		showoffID.initalize(itemID)
		drawHalo = true
	//if collectable create collectable showoff object
	} else if(object_is_ancestor(itemID.object_index, obj_pickableCollectible)){
		var showoffID = instance_create_layer(0,0,"Controllers",obj_showoff_collectible)
		showoffID.initalize(itemID)
		drawHalo = false
	} else {
		show_error("Pickable item not upgrade nor collectable", true)
	}
	
}

collect_end = function(){
	if(state == collect_state){
		heldPickableSpr = noone
		state = free_state
	}
}

