extends Node2D

onready var player = $"../YSort/Player"
#onready var bullet = $"../YSort/Bullets/Bullet"

var current_bullet

func _draw():
  if is_instance_valid(current_bullet) and is_instance_valid(player):
    var from = current_bullet.transform.origin
    var to = player.transform.origin
    
    draw_line(from, to, Color.white)
  #if is_instance_valid(bullet) and is_instance_valid(player):
    #var from = bullet.transform.origin
    #var to = player.transform.origin
    
    #draw_line(from, to, Color.white)

func _process(delta):
  update()
