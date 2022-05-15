extends Node

var _params = null

onready var sound_stream = $AudioStreamPlayer
onready var second_sound_stream = $AudioStreamPlayer2

func change_scene(next_scene, params=null):
  _params = params
  get_tree().change_scene(next_scene)

func get_param(name):
  if _params != null and _params.has(name):
    return _params[name]
  return null

func play_sound(name):
  sound_stream.stream = load("res://assets/sounds/" + name + ".wav")
  sound_stream.play()

func play_second_sound(name):
  second_sound_stream.stream = load("res://assets/sounds/" + name + ".wav")
  second_sound_stream.play()

func play_button_sound():
  play_sound("coin")

func play_cant_attack_sound():
  play_sound("hurt")

func play_attack_sound():
  play_sound("zap")

func play_enemy_killed_sound():
  play_second_sound("lose")

func play_player_killed_sound():
  play_second_sound("lose2")
