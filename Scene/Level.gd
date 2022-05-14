extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

onready var player = $YSort/Player
#onready var enemy = $YSort/StaticEnemy
onready var viewport = get_viewport_rect()
onready var bullets = $YSort/Bullets
#onready var bullet = $YSort/Bullets/Bullet
onready var bullet_path = $BulletPath

var unshootScript
var bullets_array = []
var bullet_index

func _ready():
  bullet_index = 0
  unshootScript = UnshootScript.new()
  for c in bullets.get_children():
    bullets_array.append(c)
  bullet_path.current_bullet = bullets_array[bullet_index]

func enemy_movement_to(player_position, delta):
  pass
  #if is_instance_valid(enemy):
    #enemy.position += enemy.position.direction_to(player_position) * enemySpeed * delta

func get_input(delta):
  if not is_instance_valid(player):
    return
  
  if Input.is_action_just_pressed("select_right"):
    bullet_index += 1
    if bullet_index >= len(bullets_array):
      bullet_index = 0
    bullet_path.current_bullet = bullets_array[bullet_index]
    print(bullet_index)

  if Input.is_action_just_pressed("ui_accept"):
    if bullets_array and bullets_array[bullet_index]:
      var b = bullets_array[bullet_index]
      if is_instance_valid(b):
        if unshootScript.unshoot(get_world_2d().direct_space_state, b, player):
          b.queue_free()
          bullets_array.remove(bullet_index)
          bullet_index = bullets_array.size() - 1
          if bullet_index >= 0:
            bullet_path.current_bullet = bullets_array[bullet_index]
    #if is_instance_valid(bullet) and is_instance_valid(player):
      #if unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player):
        #bullet.queue_free()

func _process(delta):
  if not has_node("YSort/StaticEnemy"):
    print("WON")
    get_tree().change_scene("res://Scene/MainMenu.tscn")

func _physics_process(delta):
  get_input(delta)

func _on_Player_moved(delta):
  pass
  #enemy_movement_to(player.position, delta)

func _on_StaticEnemy_body_entered(body):
  if body.get_name() == "Player":
    body.queue_free()
    get_tree().change_scene("res://Scene/GameOver.tscn")
