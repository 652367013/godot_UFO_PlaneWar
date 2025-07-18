extends Area2D
@export var rocket_speed:=600
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var rocket: Area2D = $"."



func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	rocket.area_entered.connect(_on_area_entered)
#炮弹发射后向右移动
func _physics_process(delta: float) -> void:
	global_position.x+=rocket_speed*delta
#炮弹离开屏幕可见范围时,自动消失
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
#炮弹与敌人相撞后
func _on_area_entered(area:Area2D)->void:
	print("炮弹和敌人相撞")
	queue_free()
	area.die()
