/// @desc
if(initalized){
	if (state == "Trans In"){
		if(frame<=maxFrame){
			frame++
		} else {
			state = "Still"
			alarm[0] = disappearTime*fps
		}
	} else if (state == "Trans out") { 
		if(frame>0){
			frame--
		} else {
			instance_destroy()
		}
	}
}