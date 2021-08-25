/// @desc item highlight
if(initalized){
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_font(fnt_basic)
	var guiW = display_get_gui_width()
	var guiH = display_get_gui_height()
	var roomGuiRatioX = guiW/room_width
	var roomGuiRatioY =	guiH/room_height
	var pixelx = roomGuiRatioX
	var pixely = roomGuiRatioY
	var xoffset = EaseOutQuad(frame, -floor(guiW*1/10), 0, maxFrame) //for movement in and out of screen
	
	//Darken behind Highlight
	draw_set_color(c_black)
	draw_set_alpha(drawAlpha*0.2)
	draw_rectangle(xoffset,guiH*1/20,xoffset+guiW*1/10,guiH*1/10,false)

	//Name
	draw_set_font(fnt_basic)
	draw_text_transformed(xoffset+pixelx,guiH*1/20+pixely,name,roomGuiRatioX,roomGuiRatioY,0)
	
	//Sprite
	draw_sprite_ext(sprite,0,xoffset+pixelx,guiH*1/10+pixely,roomGuiRatioX,roomGuiRatioY,0,c_white,0)
}


