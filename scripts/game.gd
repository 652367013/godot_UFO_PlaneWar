extends Node2D

@export var player_health=3
@export var player_score=0

@onready var death_zone: Area2D = $DeathZone
@onready var player: CharacterBody2D = $Player
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var hud: Control = $UI/Hud
@onready var ui: CanvasLayer = $UI
@onready var enemy_hit_sound: AudioStreamPlayer = $EnemyHitSound
@onready var player_hurt_sound: AudioStreamPlayer = $PlayerHurtSound


var game_over:PackedScene=preload("res://scenes/game_over.tscn")

#初始化信号,设置计分板原始状态
func _ready() -> void:
	death_zone.area_entered.connect(_on_death_zone_area_entered)
	player.damage.connect(_on_player_damage)
	enemy_spawner.enemy_emit.connect(_on_enemy_spawner_enemy_emit)
	hud.set_score_label(player_score)
#敌人进入左侧区域时自动删除
func _on_death_zone_area_entered(area:Area2D)->void:
	area.queue_free()
#敌人和玩家碰撞时,玩家扣血,敌人消失
func _on_player_damage() -> void:
	player_hurt_sound.play()
	player_health-=1
	hud.set_health_label(player_health)
	#玩家生命值归零,玩家死亡
	if player_health==0:
		#玩家死亡,移除玩家
		player.queue_free()
		#停顿1s
		await get_tree().create_timer(1).timeout
		#玩家死亡,游戏结束,生成gameover场景
		var game_over_instance=game_over.instantiate()
		ui.add_child(game_over_instance)
		game_over_instance.set_score(player_score)
		#玩家死亡后,移除敌人生成器,停止生成敌人
		enemy_spawner.queue_free()
		
		
#接受敌人生成器发射的信号,敌人的实例发射死亡信号
func _on_enemy_spawner_enemy_emit(enemy_instance: Variant) -> void:
	add_child(enemy_instance)
	enemy_instance.died.connect(_on_enemy_died)
#敌人死亡时,得分增加
func _on_enemy_died():
	enemy_hit_sound.play()
	player_score+=100
	hud.set_score_label(player_score)
