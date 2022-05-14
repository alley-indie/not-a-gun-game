extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

onready var player = $YSort/Player
#onready var enemy = $YSort/StaticEnemy
onready var viewport = get_viewport_rect()
onready var bullets = $YSort/BulletsController

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
    unshoot()

func unshoot():
  var bullet = bullets.get_current_bullet()
  if bullet and is_instance_valid(bullet):
    if unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player):
      bullets.unshoot()

func _process(delta):
  if not has_node("YSort/StaticEnemy"):
    print("WON")
    get_tree().change_scene("res://Scene/MainMenu.tscn")

func _physics_process(delta):
  get_input(delta)

func _on_Player_moved(delta):
  get_tree().call_group("movers", "enemy_movement_to", player.position, delta)

func _on_StaticEnemy_body_entered(body):
  if body.get_name() == "Player":
    body.queue_free()
    get_tree().change_scene("res://Scene/GameOver.tscn")
