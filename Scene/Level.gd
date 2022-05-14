extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

var unshootScript
var velocity = Vector2.ZERO
var enemyVelocity = Vector2.ZERO
var bullet_velocity = Vector2.ZERO
var stored_delta = 0

export(int) var speed = 100
export(int) var enemySpeed = 50

onready var player = $YSort/Player
onready var enemy = $YSort/Enemy
onready var viewport = get_viewport_rect()
onready var bullet = $Bullet

func _ready():
  unshootScript = UnshootScript.new()

func enemy_movement_to(player_position, delta):
  enemy.position += enemy.position.direction_to(player_position) * enemySpeed * delta

func get_input(delta):
  if not is_instance_valid(player):
    return
  
  stored_delta = delta
  
  if Input.is_action_just_pressed("ui_accept"):
    unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player)
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

func _on_PlayerArea_area_entered(area):
  print('HIT')
  player.queue_free()

func _on_Player_moved():
  enemy_movement_to(player.position, stored_delta)
