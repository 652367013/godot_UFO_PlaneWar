extends RigidBody2D

@export var speed:=200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale=0.1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		apply_force(Vector2(speed,0))
	if Input.is_action_pressed("move_left"):
		apply_force(Vector2(-speed,0))
	if Input.is_action_pressed("move_up"):
		apply_force(Vector2(0,-speed))
	if Input.is_action_pressed("move_down"):
		apply_force(Vector2(0,speed))
