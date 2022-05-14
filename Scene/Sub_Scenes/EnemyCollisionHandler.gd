extends Node2D

func on_hit(collider):
  if (collider == "bullet"):
    print("HIT")
    print(get_parent().find_node("AnimationPlayer"))
    get_parent().find_node("AnimationPlayer").play("EnemyHit")
    #get_parent().queue_free()
