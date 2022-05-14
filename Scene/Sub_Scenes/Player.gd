extends KinematicBody2D

export(int) var speed = 100

onready var viewport = get_viewport_rect()

var velocity = Vector2.ZERO

signal moved(delta)

func _physics_process(delta):
  velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  velocity = velocity.normalized()
  
  if velocity:
    velocity = move_and_slide(velocity * speed)
    _adjust_position()
    emit_signal("moved", delta)

func _adjust_position():
  if position.x < 0:
    position.x = 0
  if position.y < 0:
    position.y = 0
  elif position.y > viewport.size.y:
    position.y = viewport.size.y
