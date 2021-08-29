/// @desc Apply upgrade and save info
transitionTime = 1 //time for the notification to slide in (out is double it)
disappearTime = 3 //seconds
initalized = false
frame = -1
maxFrame = floor(transitionTime*fps) //for in transition
drawAlpha = 1
state = noone
textWidth = noone

initalize = function(itemID){
	var itemStruct = itemID.pick()
	name = itemStruct.name
	sprite = itemStruct.sprite
	
	textWidth = string_width(name)
	frame = 0
	initalized = true
	state = "Trans In"
}
