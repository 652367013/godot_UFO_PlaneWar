extends Node2D
@onready var timer: Timer = $Timer
@onready var spawn_pos: Node2D = $SpawnPos
signal enemy_emit(enemy_instance)

#timer.autostart=true
var enemy_scene:PackedScene=preload("res://scenes/enemy_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout():
	spawn_enemy()
	
func spawn_enemy():
	var spawn_pos_array=spawn_pos.get_children()
	var random_pos=spawn_pos_array.pick_random()
	var enemy_instance=enemy_scene.instantiate()
	enemy_instance.global_position=random_pos.global_position
	enemy_emit.emit(enemy_instance)
	#add_child(enemy_instance)
