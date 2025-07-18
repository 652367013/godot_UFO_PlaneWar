extends Button
@onready var ufo: Button = $"."


#初始化按钮的信号
func _ready() -> void:
	ufo.button_down.connect(_on_button_down)

#当UFO按钮被按下后,进入UFO游戏场景
func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://Game_UFO/level_1.tscn") 
