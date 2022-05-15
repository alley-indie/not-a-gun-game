extends Node

func _input(event):
  if event.is_action_pressed("ui_accept"):
    finish_intro()

func finish_intro():
  Global.change_scene("res://Scene/Level.tscn")
