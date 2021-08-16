/// @desc Movement & interactions

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

//Collision detection
if(!place_free(x+hspd, y)){
	hspd = 0
	
}

if(!place_free(x, y+vspd)){
	vspd = 0
}

//Movement
x += hspd
y += vspd