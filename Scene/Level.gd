extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")


#var velocity = Vector2.ZERO
#var enemyVelocity = Vector2.ZERO
#var bullet_velocity = Vector2.ZERO

#export(int) var speed = 100
#export(int) var enemySpeed = 50

var CollisionLine = preload("res://Scene/Sub_Scenes/CollisionLine.tscn")

onready var player = $YSort/Player
onready var enemy = $YSort/StaticEnemy
onready var viewport = get_viewport_rect()
onready var bullet = $YSort/Bullet

var unshootScript


func _ready():
  unshootScript = UnshootScript.new()

func enemy_movement_to(player_position, delta):
  pass
  #if is_instance_valid(enemy):
    #enemy.position += enemy.position.direction_to(player_position) * enemySpeed * delta

func get_input(delta):
  if not is_instance_valid(player):
    return
  
  if Input.is_action_just_pressed("ui_accept"):
    if is_instance_valid(bullet) and is_instance_valid(player):
      unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player)
      #bullet.queue_free()

func _physics_process(delta):
  get_input(delta)

func _on_Player_moved(delta):
  pass
  #enemy_movement_to(player.position, delta)
