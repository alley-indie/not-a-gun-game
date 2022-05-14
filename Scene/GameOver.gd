extends Control

onready var gameover_label = $VBoxContainer/Label

var reason = ""

func _ready():
  reason = Global.get_param("reason")
  gameover_label.text = str("Game Over\n", reason)

func _on_Button_pressed():
  Global.change_scene("res://Scene/MainMenu.tscn")
