extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

var unshootScript

var stored_delta = 0

export(int) var speed = 100

onready var player = $YSort/Player
onready var bullet = $YSort/Bullet

func _ready():
  unshootScript = UnshootScript.new()

func get_input(delta):
  if not is_instance_valid(player):
    return
  
  stored_delta = delta
  
  if Input.is_action_just_pressed("ui_accept"):
    if is_instance_valid(bullet) and is_instance_valid(player):
      unshootScript.unshoot(get_world_2d().direct_space_state, player, bullet)
      bullet.queue_free()

func _process(delta):
  update()

func _physics_process(delta):
  get_input(delta)

func _draw():
  if is_instance_valid(bullet) and is_instance_valid(player):
    var from = bullet.transform.origin
    var to = player.transform.origin
    
    draw_line(from, to, Color.white)
