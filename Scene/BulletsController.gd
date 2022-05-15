extends Node2D

onready var bulletSelector = $BulletSelector
onready var player = $"../Player"

var bullets = []
var bullet_index = -1

func _ready():
  #bullets = get_tree().get_nodes_in_group("bullet")
  bullet_index = -1
  update_bullets()
  #update_bullet_selector()

func update_bullets():
  bullets = []
  for i in get_tree().get_nodes_in_group("bullet"):
    if i.overlaps_body(player):
      bullets.append(i)
  update_index()
  update_bullet_selector()

func update_index():
  if bullets.size() > 0:
    if bullet_index < 0:
      bullet_index = 0
  else:
    bullet_index = -1

func get_current_bullet():
  if bullet_index < bullets.size() and bullet_index >= 0:
    return bullets[bullet_index]

func is_out_of_bullets():
  return get_tree().get_nodes_in_group("bullet").size() == 0

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
    bulletSelector.visible = true
    bulletSelector.transform = bullet.transform
  else:
    bulletSelector.visible = false

func move_right():
  move(1)

func move_left():
  move(-1)

func unshoot():
  var bullet = get_current_bullet()
  if bullet and is_instance_valid(bullet):
    bullet.queue_free()
    update_bullets()
