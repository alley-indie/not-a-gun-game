extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _on_Area2D_area_entered(area):
  var new_scene = ResourceLoader.load("res://Scene/Levels/LevelThree.tscn")
  var current_scene = new_scene.instance()
  current_scene.position.x += 320
  get_tree().get_root().add_child(current_scene)
