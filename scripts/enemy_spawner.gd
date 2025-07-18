extends Node2D
@onready var timer: Timer = $Timer
@onready var spawn_pos: Node2D = $SpawnPos
#信号,用于发射敌人的实例
signal enemy_emit(enemy_instance)
#使用enemy_scene保存敌人的场景
var enemy_scene: PackedScene = preload("res://scenes/enemy_1.tscn")
var available_spawn_positions: Array = []
var current_spawn_count: int = 0

func _ready():
	randomize()
	reset_spawn_positions()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	#设定同时出现的敌人数量
	set_spawn_count()
	timer.wait_time = randf_range(1.0, 2.0) 
	#生成器点位重置
	if available_spawn_positions.size() < current_spawn_count:
		reset_spawn_positions()
	
	for i in range(current_spawn_count):
		if available_spawn_positions.size() == 0:
			break
		var random_index = randi() % available_spawn_positions.size()
		var spawn_position = available_spawn_positions[random_index]
		#移除使用的位置,防止生成的敌人的点位重复
		available_spawn_positions.remove_at(random_index)  # 修正：使用remove_at()
		#实例化敌人,发射信号
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.global_position = spawn_position
		enemy_emit.emit(enemy_instance)
#重置敌人生成器的列表
func reset_spawn_positions():
	available_spawn_positions = []
	for child in spawn_pos.get_children():
		available_spawn_positions.append(child.global_position)
	available_spawn_positions.shuffle()
	print("available_spawn_positions:",available_spawn_positions)
#设定生成的敌人数量,70%生成1个,20%生成2个,10%生成3个
func set_spawn_count():
	var random_value = randf() * 100
	if random_value < 70:
		current_spawn_count = 1
	elif random_value < 90:
		current_spawn_count = 2
	else:
		current_spawn_count = 3
