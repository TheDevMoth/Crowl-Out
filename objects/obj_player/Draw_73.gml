// Show collision box
if(global.showCollisionBox){
	draw_set_alpha(0.5)
	draw_set_color(c_red)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	draw_set_alpha(1)
	draw_set_color(c_white)
}
