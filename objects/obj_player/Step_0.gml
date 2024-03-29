/// @description Controlling the players state

#region Set up controls for the player
right = keyboard_check(vk_right);
left = keyboard_check(vk_left);
up = keyboard_check(vk_up);
down = keyboard_check(vk_down);
up_release = keyboard_check_released(vk_up);
#endregion

#region State Machine
switch (state) {
#region Move State
	case player.moving:
	if (xspeed == 0) {
		sprite_index = spr_player_idle;
	}
	else {
		sprite_index = spr_player_walk;
	}
	//Check if player is on the ground
	if (!place_meeting(x, y + 1, obj_solo)) {
		yspeed += gravity_acceleration;
		
		//Player is in the air
		sprite_index = spr_player_jump;
		image_index = (yspeed > 0);
		
		//Control the jump height
		if (up_release && yspeed < -6) {
			yspeed = -3;
		}
	} else {
		yspeed = 0;
		
		//Jumping code
		if (up) {
			yspeed = jump_height;
			audio_play_sound(a_jump, 5, false);
		}
	}
	//Change direction of sprite
	if (xspeed != 0) {
		image_xscale = sign(xspeed);
	}
	//Check for moving left or right
	if (right or left) {
		xspeed += (right - left) * acceleration;
		xspeed = clamp(xspeed, -max_speed, max_speed);
	}
	else {
		apply_friction(acceleration);
	}
	
	if (place_meeting(x, y + yspeed + 1, obj_solo) && yspeed > 0) {
		audio_play_sound(a_step, 6, false);
	}
	
	move(obj_solo);
	
	//Check for ledge grab state
	var falling = y - yprevious > 0;
	var wasnt_wall = !position_meeting(x + grab_widht * image_xscale, yprevious, obj_solo);
	var is_wall = position_meeting(x + grab_widht * image_xscale, y, obj_solo);
	
	if (falling && wasnt_wall && is_wall){
		xspeed = 0;
		yspeed = 0;
		
		//Move against the ledge 
		while (!place_meeting(x + image_xscale, y, obj_solo)) { 
			x += image_xscale;
		}
	
		//Check vertical position
		while (position_meeting(x + grab_widht * image_xscale, y - 1, obj_solo)) {
			y -= 1;	
		}
	
		//Change sprite and state
		sprite_index = spr_player_ledge_grab;
		state = player.ledge_grab;
	
		audio_play_sound(a_step, 6, false);
	}
	break;
#endregion
#region Ledge Grab state
	case player.ledge_grab:
		if(down) {
			state = player.moving;
		}
		
		if (up) {
			state = player.moving;
			yspeed = jump_height;
		}
	break;
#endregion
#region Door state
	case player.door:
		sprite_index = spr_player_exit;
		//Fade out
		if (image_alpha > 0) {
			image_alpha -= 0.05;	
		} else {
			//Go to the next room
			room_goto_next();
		}
	break;
#endregion
#region Hurt state
	case player.hurt:
		sprite_index = spr_player_hurt;
		
		//Change direction as we fly around
		if (xspeed != 0) {
			image_xscale = sign(xspeed);	
		}
		
		if (!place_meeting(x, y + 1, obj_solo)) {
			yspeed += gravity_acceleration;	
		} else {
			yspeed = 0;
			apply_friction(acceleration);
		}
		
		direction_move_bounce(obj_solo);
		
		//Change back to the other states
		if (xspeed == 0 && yspeed == 0) {
			//Check health
			if (obj_player_stats.hp <= 0 ) {
				state = player.death;	
			} else {
				image_blend = c_white;
				state = player.moving;
			}
		}
	break;
#endregion
#region Death state
	case player.death:
		with (obj_player_stats) {
			hp = max_hp;
			sapphires = 0;
		}
		
		room_restart();
	break;
 #endregion
}
#endregion
