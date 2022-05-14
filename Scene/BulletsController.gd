extends Node2D

onready var bulletSelector = $BulletSelector

var bullets = []
var bullet_index = 0

func _ready():
  bullets = get_tree().get_nodes_in_group("bullet")
  update_bullet_selector()

func get_current_bullet():
  if bullet_index < bullets.size() and bullet_index >= 0:
    return bullets[bullet_index]

func is_out_of_bullets():
  return bullets.size() == 0

func _input(event):
  if bullet_index >= bullets.size():
    return

  if event.is_action_pressed("select_right"):
    move_right()
  elif event.is_action_pressed("select_left"):
    move_left()

func move(inc):
    bullet_index += inc
    if bullet_index >= bullets.size():
      bullet_index = 0
    elif bullet_index < 0:
      bullet_index = bullets.size() - 1
      if bullet_index < 0:
        bullet_index = 0
    
    update_bullet_selector()
    

func update_bullet_selector():
  var bullet = get_current_bullet()
  if bullet:
    bulletSelector.transform = bullet.transform

func move_right():
  move(1)

func move_left():
  move(-1)

func unshoot():
  var bullet = get_current_bullet()
  if bullet and is_instance_valid(bullet):
    bullet.queue_free()
    bullets.remove(bullet_index)
    bullet_index = bullets.size() - 1
