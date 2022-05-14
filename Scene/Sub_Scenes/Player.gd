extends Area2D

var velocity = Vector2.ZERO
export(int) var speed = 100

func _physics_process(delta):
  velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  
  position += velocity.normalized() * speed * delta
