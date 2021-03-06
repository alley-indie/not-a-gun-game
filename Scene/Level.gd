extends Node2D

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

export(String) var next_level = "res://Scene/WinScene.tscn"

onready var player = $YSort/Player
onready var viewport = get_viewport_rect()
onready var bullets = $YSort/BulletsController
onready var dialog_event = $DialogEvent
onready var end_dialog_event = $EndDialogEvent

var unshootScript

func get_active_dialog():
  if dialog_event and dialog_event.running:
    return dialog_event
  elif end_dialog_event and end_dialog_event.running:
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
  elif event.is_action_pressed("ui_cancel"):
    Global.change_scene("res://Scene/GameOver.tscn", { "reason": "You Evaded", "level": get_name() })

func get_input(delta):
  if get_active_dialog():
    if Input.is_action_just_pressed("ui_accept"):
      get_active_dialog().next()
    return
    
  if not is_instance_valid(player):
    return

  player.move(delta)
  bullets.update_bullets()
  if Input.is_action_just_pressed("ui_accept"):
    unshoot()
    bullets.update_bullet_selector()

func unshoot():
  var bullet = bullets.get_current_bullet()
  if bullet and is_instance_valid(bullet):
    if unshootScript.unshoot(get_world_2d().direct_space_state, bullet, player):
      Global.play_attack_sound()
      bullets.unshoot()
      if bullets.is_out_of_bullets() and not is_enemies_dead():
        Global.change_scene("res://Scene/GameOver.tscn", { "reason": "Out of Bullets" })
      elif is_enemies_dead():
        var position = Vector2(get_node("Camera2D").position.x - 160, end_dialog_event.rect_position.y)
        end_dialog_event.set_position(position)
        end_dialog_event.start()
    else:
      Global.play_cant_attack_sound()

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
  bullets.update_bullet_selector()
  if get_tree().get_nodes_in_group("enemy").size() == 0 and not end_dialog_event.running:
    Global.change_scene(next_level)
  elif bullets.is_out_of_bullets() and not is_enemies_dead():
    game_over("Out of Bullets")

func _on_StaticEnemy_body_entered(body):
  if body.get_name() == "Player":
    body.queue_free()
    game_over("Killed by Enemy")

func game_over(reason):
  Global.play_player_killed_sound()
  Global.change_scene("res://Scene/GameOver.tscn", { "reason": reason, "level": get_name() })
