extends Node2D

var velocity = Vector2.ZERO
export(int) var speed = 100

onready var player = $Player

func get_input(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed * delta
	player.position += velocity

func _physics_process(delta):
	get_input(delta)
