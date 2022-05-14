extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

onready var player = $YSort/Player
onready var viewport = get_viewport_rect()
onready var bullets = $YSort/BulletsController
onready var dialog_event = $DialogEvent
onready var end_dialog_event = $EndDialogEvent

var unshootScript

func get_active_dialog():
  if dialog_event.running:
    return dialog_event
  elif end_dialog_event.running:
    return end_dialog_event

func _ready():
  unshootScript = UnshootScript.new()
  if dialog_event.autostart:
    dialog_event.start()

func _input(event):
  if get_active_dialog():
    return
  if event.is_action_pressed("select_right"):
    bullets.move_right()
  elif event.is_action_pressed("select_left"):
    bullets.move_left()

func get_input(delta):
  if get_active_dialog():
    if Input.is_action_just_pressed("ui_accept"):
      get_active_dialog().next()
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
      elif is_enemies_dead():
        end_dialog_event.start()

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
  if get_tree().get_nodes_in_group("enemy").size() == 0 and not end_dialog_event.running:
    get_tree().change_scene("res://Scene/WinScene.tscn")

func _on_StaticEnemy_body_entered(body):
  if body.get_name() == "Player":
    body.queue_free()
    Global.change_scene("res://Scene/GameOver.tscn", { "reason": "Killed by Enemy" })
