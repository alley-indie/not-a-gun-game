extends Control

func _on_StartButton_pressed():
  Global.change_scene("res://Scene/Level.tscn")
  Global.play_button_sound()

func _on_QuitButton_pressed():
  Global.play_button_sound()
  get_tree().quit()
