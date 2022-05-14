extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

onready var player = $YSort/Player
onready var viewport = get_viewport_rect()
onready var bullets = $YSort/BulletsController
onready var dialog_event = $DialogEvent

var unshootScript

func _ready():
  unshootScript = UnshootScript.new()
  $Camera2D/Control.visible = dialog_event.is_active
  $Camera2D/Control/Label.text = dialog_event.dialog
  $Camera2D/Control/Label/AnimationPlayer.play("show_text")

func _input(event):
  if dialog_event.is_active:
    return
  if event.is_action_pressed("select_right"):
    bullets.move_right()
  elif event.is_action_pressed("select_left"):
    bullets.move_left()

func get_input(delta):
  if dialog_event.is_active:
    if Input.is_action_just_pressed("ui_accept"):
      if $Camera2D/Control/Label.visible_characters > -1:
        $Camera2D/Control/Label/AnimationPlayer.stop()
        $Camera2D/Control/Label.visible_characters = -1
      else:
        dialog_event.is_active = false
        $Camera2D/Control.visible = dialog_event.is_active
    return
    
  if not is_instance_valid(player):
    return

  player.move(delta)
  if Input.is_action_just_pressed("ui_accept"):
    unshoot()
    bullets.update_bullet_selector()

func unshoot():
  var bullet = bullets.get_current_bullet()
  if bullet and is_instance_valid(bullet):
    if unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player):
      bullets.unshoot()
      if bullets.is_out_of_bullets() and not is_enemies_dead():
        Global.change_scene("res://Scene/GameOver.tscn", { "reason": "Out of Bullets" })

func is_enemies_dead():
  for e in get_tree().get_nodes_in_group("enemy"):
    if e.is_alive:
      return false
  return true

func _physics_process(delta):
  get_input(delta)

func _on_Player_moved(delta):
  get_tree().call_group("movers", "enemy_movement_to", player.position, delta)

func _process(delta):
  if get_tree().get_nodes_in_group("enemy").size() == 0:
    get_tree().change_scene("res://Scene/WinScene.tscn")

func _on_StaticEnemy_body_entered(body):
  if body.get_name() == "Player":
    body.queue_free()
    Global.change_scene("res://Scene/GameOver.tscn", { "reason": "Killed by Enemy" })
