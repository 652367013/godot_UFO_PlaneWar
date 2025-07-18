extends Node2D
@onready var enemy_timer_1: Timer = $EnemyTimer1
@onready var enemy_timer_2: Timer = $EnemyTimer2
@onready var spawn_pos: Node2D = $SpawnPos
#信号,用于发射敌人1的实例
signal enemy_1_emit(enemy_instance)
#信号,用于发射敌人2的实例
signal enemy_2_emit(enemy_instance)

#使用enemy_scene保存敌人的场景
var enemy_1_scene: PackedScene = preload("res://Game_Plane_War/scenes/enemy_1.tscn")
var enemy_2_scene:PackedScene=preload("res://Game_Plane_War/scenes/enemy_2_path.tscn")
var available_spawn_positions: Array = []
var current_spawn_count: int = 0
#初始化随机种子,重置敌人生成点位,连接信号
func _ready():
	randomize()
	reset_spawn_positions()
	enemy_timer_1.timeout.connect(_on_enemy_timer_1_timeout)
	enemy_timer_2.timeout.connect(_on_enemy_timer_2_timeout)
#计时器1信号触发
func _on_enemy_timer_1_timeout():
	#设定同时出现的敌人数量
	set_spawn_count()
	enemy_timer_1.wait_time = randf_range(1.0, 2.0) 
	#生成器点位重置
	if available_spawn_positions.size() < current_spawn_count:
		reset_spawn_positions()
	#生成敌人
	for i in range(current_spawn_count):
		if available_spawn_positions.size() == 0:
			break
		var random_index = randi() % available_spawn_positions.size()
		var spawn_position = available_spawn_positions[random_index]
		#移除使用的位置,防止生成的敌人的点位重复
		available_spawn_positions.remove_at(random_index)  
		#实例化敌人,发射信号
		var enemy_1_instance = enemy_1_scene.instantiate()
		enemy_1_instance.global_position = spawn_position
		enemy_1_emit.emit(enemy_1_instance)
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

#计时器2信号触发
func _on_enemy_timer_2_timeout() -> void:
	enemy_timer_2.wait_time = randf_range(2.0, 5.0)
	spawn_enemy_2()
#生成第二种敌人
func spawn_enemy_2():
	var enemy_2_instance=enemy_2_scene.instantiate()
	enemy_2_emit.emit(enemy_2_instance)
