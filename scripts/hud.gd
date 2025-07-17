extends Control
@onready var score: Label = $score
@onready var health: Label = $TextureRect/health



func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
func set_score_label(new_score):
	score.text="score: "+str(new_score)
func set_health_label(new_health):
	health.text=str(new_health)
