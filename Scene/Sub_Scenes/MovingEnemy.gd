extends "res://Scene/Levels/Enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var speed = 80
# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


func enemy_movement_to(player_position, delta):
  if is_instance_valid(self) and position.distance_to(player_position) < 300:
    var old_position = position
    var move = position.direction_to(player_position) * speed * delta
    position += move
    if get_overlapping_bodies():
      position = old_position
      position.x += move.x
      if get_overlapping_bodies():
        position = old_position
        position.y += move.y
        if get_overlapping_bodies():
          position = position - position.direction_to(player_position) * speed * delta
    #if coll
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
