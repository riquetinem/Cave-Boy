///@description take_damage
if (state != player.hurt) {
	state = player.hurt;
	
	audio_play_sound(a_ouch, 8, false);
	
	image_blend = make_color_rgb(220, 150, 150);
	
	yspeed = -6;
	xspeed = (sign(x - other.x) * 8);
	
	move(obj_solo);
	
	if (instance_exists(obj_player_stats)) {
		obj_player_stats.hp -= 1;	
	}
}