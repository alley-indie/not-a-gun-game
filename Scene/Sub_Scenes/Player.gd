extends KinematicBody2D

export(int) var speed = 100

onready var viewport = get_viewport_rect()

var velocity = Vector2.ZERO

signal moved(delta)

func _physics_process(delta):
  var input_vector = Vector2.ZERO
  #print(get_parent().position)
  input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  input_vector = input_vector.normalized()
  
  if input_vector:
    #var old_position = position
    #position += velocity.normalized() * speed * delta
    #var new_position = position + velocity.normalized() * speed * delta
    #move_and_collide(input_vector)
    #velocity = velocity.move_toward(input_vector, delta)
    #velocity = move_and_collide(velocity)
    input_vector = move_and_slide(input_vector * speed)

    _adjust_position()

    emit_signal("moved", delta)
    #velocity = (velocity * speed)

func _adjust_position():
  if position.x < 0:
    position.x = 0
  if position.y < 0:
    position.y = 0
  elif position.y > viewport.size.y:
    position.y = viewport.size.y
