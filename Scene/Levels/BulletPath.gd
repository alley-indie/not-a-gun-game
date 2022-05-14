extends Node2D

onready var player = $"../YSort/Player"
#onready var bullet = $"../YSort/Bullets/Bullet"
onready var bullets = $"../YSort/BulletsController"

func _draw():
  var bullet = bullets.get_current_bullet()
  if bullet and is_instance_valid(bullet):
    var from = bullet.transform.origin
    var to = player.transform.origin
    
    draw_line(from, to, Color.white)
  #if is_instance_valid(bullet) and is_instance_valid(player):
    #var from = bullet.transform.origin
    #var to = player.transform.origin
    
    #draw_line(from, to, Color.white)

func _process(delta):
  update()
