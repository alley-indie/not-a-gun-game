extends Node2D

onready var player = $"../YSort/Player"
onready var bullet = $"../YSort/Bullet"

func _draw():
  if is_instance_valid(bullet) and is_instance_valid(player):
    var from = bullet.transform.origin
    var to = player.transform.origin
    
    draw_line(from, to, Color.white, 2)

func _process(delta):
  update()
