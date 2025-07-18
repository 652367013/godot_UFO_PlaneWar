extends Area2D
@export var enemy_speed:=250
#这里信号连自己(enemy_2)的原因是信号来源时自己的子节点
@onready var enemy_2: Area2D = $"."


signal died

func _ready() -> void:
	enemy_2.body_entered.connect(_on_body_entered)


#敌人与玩家相撞
func _on_body_entered(body: Node2D) -> void:
	die()
	body.get_damage()
#敌人死亡,发射信号	
func die():
	died.emit()
	queue_free()
