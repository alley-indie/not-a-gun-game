extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal bullet_ray(source, target)

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _interpolate_by_distance(a: Vector2, b: Vector2, distance: float) -> Vector2:
  var a_to_b_angle := (b - a).normalized()
  return a + a_to_b_angle * distance

func _on_animate_bullet_ray(source, target):
  var anim: Animation = self.get_animation("Trace")
  var track_id: int = anim.find_track("Ray:points")
  var time = 0.0
  for i in range(target.distance_to(source)):
    time += (1/target.distance_to(source)) * 0.2
    anim.track_insert_key(track_id, time, [source, _interpolate_by_distance(source, target, i)])
  for i in range(target.distance_to(source)):
    time += (1/target.distance_to(source)) * 0.2
    anim.track_insert_key(track_id, time, [target, _interpolate_by_distance(source, target, i)])
  self.play("Trace")


func _on_animate_animation_finished(anim_name):
  if anim_name == "Trace":
    (self.get_parent().find_node("Ray") as Line2D).clear_points()
