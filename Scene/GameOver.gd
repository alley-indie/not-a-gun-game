extends Control

onready var gameover_label = $Label

var reason = ""
#var level = "res://Scene/Levels/LevelOne.tscn"
#var level = "LevelOne"
var level = "res://Scene/Level.tscn"

func _ready():
  reason = Global.get_param("reason")
  if not reason:
    reason = ""
  #level = Global.get_param("level")
  gameover_label.text = str("Game Over\n", reason)

func _on_Button_pressed():
  Global.play_button_sound()
  Global.change_scene("res://Scene/MainMenu.tscn")

func _on_RetryButton_pressed():
  Global.play_button_sound()
  #Global.change_scene("res://Scene/Levels/" + level + ".tscn")
  Global.change_scene(level)
