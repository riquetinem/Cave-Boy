/// @description Execute the state

switch (state) {
	#region Idle State
	case spider.idle :
		if (instance_exists(obj_player)) {
			var dis = distance_to_object(obj_player);
			
			if (dis < sight && alarm[0] <= 0) {
				image_speed = 0.5;
				
				if (obj_player.x != x) {
					image_xscale = sign(obj_player.x - x);	
				}
			}
		}
	break;
	#endregion
	
	#region Jump State
	case spider.jump :
		image_index = image_number - 1;
		
		if (!place_meeting(x, y + 1, obj_solo)) {
			yspeed += gravity_acceleration;	
		} else {
			yspeed = 0;
			
			apply_friction(acceleration);
			
			if (xspeed == 0 && yspeed == 0) {
				state = spider.idle;
				alarm[0] = 15;
				image_speed = 0;
				image_index = 0;
			}
		}
		
		if (xspeed != 0) {
			image_xscale = sign(xspeed);
		}
		
		move(obj_solo);
	break;
	#endregion
}