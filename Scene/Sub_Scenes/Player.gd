extends KinematicBody2D

export(int) var speed = 100

onready var viewport = get_viewport_rect()

var velocity = Vector2.ZERO
var allowed_moving_forward = true
signal moved(delta)
signal stop_moving_forward
signal allow_moving_forward

func move(delta):
  if allowed_moving_forward or Input.get_action_strength("ui_right") < Input.get_action_strength("ui_left"):
    velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  else:
    velocity.x = 0
  velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  velocity = velocity.normalized()
  
  if velocity:
    velocity = move_and_slide(velocity * speed)
    _adjust_position()
    emit_signal("moved", delta)

func stop_moving_forward():
  allowed_moving_forward = false

func allow_moving_forward():
  allowed_moving_forward = true

func _adjust_position():
  if position.x < 0:
    position.x = 0
  if position.y < 0:
    position.y = 0
  elif position.y > viewport.size.y:
    position.y = viewport.size.y
  
