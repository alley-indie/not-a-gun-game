extends Node

var _params = null

onready var music_stream = $MusicStreamPlayer
onready var sound_stream = $AudioStreamPlayer
onready var second_sound_stream = $AudioStreamPlayer2

var music_playing = ""

func change_scene(next_scene, params=null):
  _params = params
  play("music")
  get_tree().change_scene(next_scene)

func get_param(name):
  if _params != null and _params.has(name):
    return _params[name]
  return null

func change_music(name):
  music_stream.stream = load(name)
  music_stream.playing = true
  music_stream.play()

func play(name):
  if name == music_playing:
    return
  music_playing = name
  change_music("res://assets/musics/" + name + ".wav")

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
