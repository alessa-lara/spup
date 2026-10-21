extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"

class_name Game

const SaveManager = preload("res://addons/MetroidvaniaSystem/Template/Scripts/SaveManager.gd")
const SAVE_PATH = "user://save_data.sav"

@export var starting_map: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MetSys.reset_state()
	self.set_player($Player)

	MetSys.set_save_data()
	
	self.room_loaded.connect(self.init_room, CONNECT_DEFERRED)
	self.load_room(starting_map)
	
	var start := map.get_node_or_null(^"Save")
	if start:
		player.position = start.position

	$CanvasLayer/Minimap.set_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, 8)
	
func init_room():
	MetSys.get_current_room_instance().adjust_camera_limits($Player/Camera)
	self.player.on_enter()
	
	# Initializes MetSys.get_current_coords(), so you can use it from the beginning.
	if MetSys.last_player_position.x == Vector2i.MAX.x:
		MetSys.set_player_position(self.player.position)
