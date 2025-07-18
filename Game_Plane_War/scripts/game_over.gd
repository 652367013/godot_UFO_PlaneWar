extends Control
@onready var button: Button = $Panel/Button
@onready var score: Label = $Panel/Score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.button_down.connect(_on_button_button_down)
	
#当按钮下后,重新加载游戏场景
func _on_button_button_down() -> void:
	#TODO:完善功能
	#print("按钮已按下")
	get_tree().reload_current_scene()

func set_score(new_score):
	score.text="SCORE: "+str(new_score)
