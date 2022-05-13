extends Node2D

var velocity = Vector2.ZERO
var enemyVelocity = Vector2.ZERO

export(int) var speed = 100
export(int) var enemySpeed = 50

onready var player = $YSort/Player
onready var enemy = $YSort/Enemy
onready var viewport = get_viewport_rect()

func enemy_movement_to(player_position, delta):
  enemy.position += enemy.position.direction_to(player_position) * enemySpeed * delta

func get_input(delta):
  if not player:
    return
  velocity = Vector2()
  
  if Input.is_action_pressed("ui_right"):
    velocity.x += 1
  if Input.is_action_pressed("ui_left"):
    velocity.x -= 1
  if Input.is_action_pressed("ui_down") and player.position.y < viewport.size.y:
    velocity.y += 1
  if Input.is_action_pressed("ui_up")  and player.position.y > 0:
    velocity.y -= 1
  velocity = velocity.normalized() * speed * delta
  player.position += velocity
  if velocity.x or velocity.y:
    enemy_movement_to(player.position, delta)
    

func _physics_process(delta):
  get_input(delta)


func _on_PlayerArea_area_entered(area):
  print('HIT')
  player.hide()
  player.queue_free()
  player = null
  
