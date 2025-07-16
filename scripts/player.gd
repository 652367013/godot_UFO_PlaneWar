extends CharacterBody2D
@export var speed:=300
#var viewport_width
#var viewport_height
var rocket_scene:PackedScene=preload("res://scenes/rocket.tscn")

signal damage

func _ready() -> void:
	velocity=Vector2(0,0)
	#viewport_width = get_viewport_rect().size.x
	#viewport_height = get_viewport_rect().size.y


func _physics_process(delta: float) -> void:
	#print(velocity)
	#print(global_position)
	##源代码
	#velocity.x=0
	#velocity.y=0
	#if Input.is_action_pressed("move_right"):velocity.x=speed
	#if Input.is_action_pressed("move_left"):velocity.x=-speed
	#if Input.is_action_pressed("move_up"):velocity.y=-speed
	#if Input.is_action_pressed("move_down"):velocity.y=speed
	# 优化后
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_slide()
	
	## 原代码 
	#if global_position.x < 0: global_position.x = 0
	#if global_position.x > viewport_width: global_position.x = viewport_width
	#if global_position.y < 0: global_position.y = 0
	#if global_position.y > viewport_height: global_position.y = viewport_height
	# 优化后
	#global_position.x = clamp(global_position.x, 0, viewport_width)
	#global_position.y = clamp(global_position.y, 0, viewport_height)
	#二次优化,但是会增加进程开销
	global_position=global_position.clamp(Vector2(0,0),get_viewport_rect().size)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):shoot()

	
func shoot()->void:
	var rocket_instance=rocket_scene.instantiate()
	rocket_instance.global_position=global_position
	rocket_instance.global_position.x+=80
	get_tree().current_scene.add_child(rocket_instance)

func get_damage()->void:
	damage.emit()
