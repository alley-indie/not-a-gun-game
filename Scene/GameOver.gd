extends Control

onready var gameover_label = $VBoxContainer/Label

var reason = ""
#var level = "res://Scene/Levels/LevelOne.tscn"
var level = "LevelOne"

func _ready():
  reason = Global.get_param("reason")
  level = Global.get_param("level")
  gameover_label.text = str("Game Over\n", reason)

func _on_Button_pressed():
  Global.change_scene("res://Scene/MainMenu.tscn")


func _on_RetryButton_pressed():
  Global.change_scene("res://Scene/Levels/" + level + ".tscn")
