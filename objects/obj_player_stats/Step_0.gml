/// @description Begin the game
if (keyboard_check_pressed(vk_space) && room == rm_title) {
	room_goto(rm_one);
	audio_stop_sound(a_tittle);
	audio_play_sound(a_cave, 10, true);
}

//Change music if on the main screen for too long
if (!audio_is_playing(a_tittle) && !audio_is_playing(a_cave)) {
	audio_play_sound(a_cave, 10, true);
}