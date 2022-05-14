extends Area2D

onready var collisionShape = $CollisionShape2D

var time_to_live = 3 # Magic number

func change_shape(a, b):
  collisionShape.shape.set_a(a)
  collisionShape.shape.set_b(b)

func _process(delta):
  time_to_live -= 1
  if time_to_live <= 0:
    queue_free()

#func _on_CollisionLine_area_entered(area):
  #print(area)
  #if area.has_node("CollisionHandler"):
    #area.get_node("CollisionHandler").on_hit("bullet")


func _on_CollisionLine_body_entered(body):
  print("TILE COLLISION")
