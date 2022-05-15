extends Control

export(bool) var autostart = false
export(Array, String, MULTILINE) var dialogs

onready var text = $Label
onready var animation = $Label/AnimationPlayer

var running = false
var index = -1

func _ready():
  set_running(false)
  if dialogs.size() > -1:
    index = 0

func set_running(value):
  running = value
  visible = running

func start():
  if not running and dialogs.size():
    set_running(true)
    text.text = dialogs[index]
    animation.play("show_text")

func next():
  if text.visible_characters > -1:
    animation.stop()
    text.visible_characters = -1
  else:
    index += 1
    if index >= dialogs.size():
      index = -1
      set_running(false)
    else:
      text.text = dialogs[index]
      animation.play("show_text")
