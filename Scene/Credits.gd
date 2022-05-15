extends Control

func _on_Button_pressed():
  Global.play_button_sound()
  get_tree().change_scene("res://Scene/MainMenu.tscn")
