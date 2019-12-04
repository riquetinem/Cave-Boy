/// @description Initialize some variables

hp = 3;
max_hp = 3;
sapphires = 0;

var cameraWidth = camera_get_view_width(view_camera[0]);
var cameraHeight = camera_get_view_height(view_camera[0]);

display_set_gui_size(cameraWidth, cameraHeight);

// Start the musi
audio_play_sound(a_tittle, 5, true);