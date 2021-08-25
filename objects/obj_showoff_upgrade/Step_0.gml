/// @desc
if(initalized){
	if(disappearing){
		drawAlpha -= 1/(disappearTime*fps)
	} else if(cmdSKIP()){
		disappearing = true
		alarm[0] = disappearTime*fps
	}
}