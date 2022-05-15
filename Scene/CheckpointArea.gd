extends Area2D

export(int) var level = 1

export(Array, Array, String, MULTILINE) var dialogs = []
export(Array, Array, String) var conditions = []

var dialog_level_unfinished = [
  """Kill all enemies in this room before
you can continue
  """  
]

func _on_Area2D_area_entered(area):
  if area.get_name() == "Player":
    if dialogs[level]:
      var dialog_event = get_parent().get_node("DialogEvent")
      dialog_event.set_dialogs(dialogs[level])
      dialog_event.start()


func _on_Area2D_body_entered(body):
  #print(body.get_name())
  if body.get_name() == "Player":
    var is_level_finished = true
    for path in conditions[level - 1]:
      if is_instance_valid(get_parent().get_node(path)):
        is_level_finished = false
        break
    var dialog_event = get_parent().get_node("DialogEvent")
    if not is_level_finished:
      body.emit_signal("stop_moving_forward")
      dialog_event.set_dialogs(dialog_level_unfinished)
    if dialogs.size() > level - 1 and is_level_finished:
      body.emit_signal("allow_moving_forward")
      dialog_event.set_dialogs(dialogs[level - 1])
    var position = Vector2(get_parent().get_node("Camera2D").position.x - 160, dialog_event.rect_position.y)
    dialog_event.set_position(position)
    dialog_event.start()


func _on_Area2D_body_exited(body):
  body.emit_signal("allow_moving_forward")
