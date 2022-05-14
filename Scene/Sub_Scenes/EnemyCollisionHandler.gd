extends Node2D

func on_hit(collider):
  if (collider == "bullet"):
    get_parent().queue_free()
