extends Area2D
var enemy_speed:=250
#这里信号连自己(enemy_1)的原因是信号来源时自己的子节点
@onready var enemy_1: Area2D = $"."


signal died

func _ready() -> void:
	enemy_speed=randi_range(200,300)
	enemy_1.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position.x-=enemy_speed*delta

#敌人与玩家相撞
func _on_body_entered(body: Node2D) -> void:
	die()
	body.get_damage()
#敌人死亡,发射信号
func die():
	died.emit()
	queue_free()
