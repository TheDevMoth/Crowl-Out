/// @desc item highlight
if(initalized){
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_font(fnt_basic)
	var guiW = display_get_gui_width()
	var guiH = display_get_gui_height()
	var roomGuiRatioX = guiW/room_width
	var roomGuiRatioY =	guiH/room_height

	//Darken screen
	draw_set_color(c_black)
	draw_set_alpha(drawAlpha*0.4)
	draw_rectangle(0,0,guiW,guiH,false)
	//darken behind text
	draw_set_alpha(drawAlpha*0.4)
	draw_rectangle(0,guiH*3/4,guiW,guiH,false)

	//Item Name
	draw_set_color(c_white)
	draw_set_alpha(drawAlpha)
	draw_set_font(fnt_highlightTitle)
	draw_text_transformed(guiW/2,guiH*1/20,name,roomGuiRatioX,roomGuiRatioY,0)

	//Description
	draw_set_font(fnt_basic)
	draw_text_ext_transformed(guiW/2,guiH*0.77,description,-1,guiW/3,roomGuiRatioX,roomGuiRatioY,0)

	//Sprite Highlight
	gpu_set_blendmode(bm_add)
	draw_circle_color(guiW/2,guiH/2,guiH/4,$FF09BDEF,$00000000,false)
	gpu_set_blendmode(bm_normal)
	//Sprite
	draw_sprite_ext(sprite,0,guiW/2,guiH/2,roomGuiRatioX,roomGuiRatioY,0,c_white,drawAlpha)
	
	draw_set_alpha(1)
}


