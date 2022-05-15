extends Control

func _on_StartButton_pressed():
  Global.play_button_sound()
  Global.change_scene("res://Scene/Levels/LevelOne.tscn")

func _on_QuitButton_pressed():
  Global.play_button_sound()
  get_tree().quit()

func _on_CreditsButton_pressed():
  Global.play_button_sound()
  Global.change_scene("res://Scene/Credits.tscn")
