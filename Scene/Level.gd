extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

var unshootScript
var velocity = Vector2.ZERO
var enemyVelocity = Vector2.ZERO
var bullet_velocity = Vector2.ZERO

export(int) var speed = 100
export(int) var enemySpeed = 50

onready var player = $YSort/Player
onready var enemy = $YSort/Enemy
onready var viewport = get_viewport_rect()
onready var bullet = $YSort/Bullet

func _ready():
  unshootScript = UnshootScript.new()
  print(viewport)

func enemy_movement_to(player_position, delta):
  if is_instance_valid(enemy):
    enemy.position += enemy.position.direction_to(player_position) * enemySpeed * delta

func get_input(delta):
  if not is_instance_valid(player):
    return
  
  if Input.is_action_just_pressed("ui_accept"):
    if is_instance_valid(bullet) and is_instance_valid(player):
      unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player)
      bullet.queue_free()

func _physics_process(delta):
  get_input(delta)

func _on_Player_moved(delta):
  enemy_movement_to(player.position, delta)
