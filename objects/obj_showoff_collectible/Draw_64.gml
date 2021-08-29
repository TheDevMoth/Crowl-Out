/// @desc item highlight
if(initalized){
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_font(fnt_basic)
	var guiW = display_get_gui_width()
	var guiH = display_get_gui_height()
	var roomGuiRatioX = guiW/room_width
	var roomGuiRatioY =	guiH/room_height
	var pixelx = roomGuiRatioX
	var pixely = roomGuiRatioY
	var xoffset = EaseOutQuad(frame, 0, floor(guiW*1/5), maxFrame)-floor(guiW*1/5) //for movement in and out of screen
	
	//Positions and measurements
	var boxTop = guiH*1/20
	var boxRight = (textWidth*roomGuiRatioX*3/4)+pixelx*2
	var boxBottom = 18*pixely+sprite_get_height(sprite)*roomGuiRatioY*2
	
	
	//Darken behind Highlight
	draw_set_color(c_black)
	draw_set_alpha(0.4)
	draw_rectangle(xoffset+pixelx,boxTop,xoffset+boxRight,boxBottom,false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	
	//Name
	draw_set_font(fnt_basic)
	draw_text_transformed(xoffset+pixelx,boxTop+pixely,name,roomGuiRatioX*3/4,roomGuiRatioY*3/4,0)
	
	//Sprite
	draw_sprite_ext(sprite,0,xoffset+boxRight/2,boxBottom-sprite_get_height(sprite)*roomGuiRatioY,roomGuiRatioX*2,roomGuiRatioY*2,0,c_white,1)
}


