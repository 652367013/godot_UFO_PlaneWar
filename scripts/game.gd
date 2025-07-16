extends Node2D

@export var player_health=3
@export var player_score=0

@onready var death_zone: Area2D = $DeathZone
@onready var player: CharacterBody2D = $Player
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var hud: Control = $UI/Hud


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	death_zone.area_entered.connect(_on_death_zone_area_entered)
	player.damage.connect(_on_player_damage)
	enemy_spawner.enemy_emit.connect(_on_enemy_spawner_enemy_emit)
	hud.set_score_label(player_score)
#敌人进入左侧区域时自动删除
func _on_death_zone_area_entered(area:Area2D)->void:
	area.naturally_die()
#敌人和玩家碰撞时,玩家扣血,敌人消失
func _on_player_damage() -> void:
	print('game和player信号已连接')
	player_health-=1
	hud.set_health_label(player_health)
	if player_health==0:
		print('YOU LOSE')
		player.queue_free()

func _on_enemy_spawner_enemy_emit(enemy_instance: Variant) -> void:
	add_child(enemy_instance)
	enemy_instance.died.connect(_on_enemy_died)
	
func _on_enemy_died():
	player_score+=100
	hud.set_score_label(player_score)
