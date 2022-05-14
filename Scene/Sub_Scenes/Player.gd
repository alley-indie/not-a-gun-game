extends Area2D

export(int) var speed = 100

var velocity = Vector2.ZERO

signal moved

func _physics_process(delta):
  velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  
  position += velocity.normalized() * speed * delta
  _adjust_position()
  
  if velocity:
    emit_signal("moved")

func _adjust_position():
  if position.x < 0:
    position.x = 0
  if position.y < 0:
    position.y = 0

func _on_Player_area_entered(area):
  queue_free()