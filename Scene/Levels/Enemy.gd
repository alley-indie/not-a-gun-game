extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal hit(enemy)

# Called when the node enters the scene tree for the first time.
func _ready():
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


#func _on_Enemy_hit(enemy):
    #enemy.find_node("AnimationPlayer").play("EnemyHit")

func _on_AnimationPlayer_animation_finished(anim_name):
  if anim_name == "EnemyHit":
    self.queue_free()


func _on_StaticEnemy_hit(enemy):
  enemy.find_node("AnimationPlayer").play("EnemyHit")
