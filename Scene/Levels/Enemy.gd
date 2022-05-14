extends Area2D

signal hit(enemy)

var is_alive = true

func _on_AnimationPlayer_animation_finished(anim_name):
  if anim_name == "EnemyHit":
    self.queue_free()

func _on_StaticEnemy_hit(enemy):
  is_alive = false
  enemy.find_node("AnimationPlayer").play("EnemyHit")
