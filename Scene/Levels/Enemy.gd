extends Area2D

signal hit(enemy)

export(Vector2) var oscilation = Vector2.ZERO
export(int) var oscilation_time = 4
export(Texture) var texture;

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

var is_alive = true

func max_vector_value(vector):
  if vector.x > vector.y:
    return vector.x
  return vector.y

func _ready():
  sprite.texture = texture
  if oscilation:
    var animation = Animation.new()
    animationPlayer.add_animation("oscilate", animation)
    
    animation.add_track(Animation.TYPE_VALUE)
    #animation.length = max_vector_value(oscilation) / 16 * 4
    animation.length = oscilation_time
    var track_path = String(self.get_path()) + ":position"
    animation.track_set_path(0, track_path)
    
    animation.track_insert_key(0, 0, position)
    animation.track_insert_key(0, oscilation_time / 2.0, position + oscilation)
    animation.track_insert_key(0, oscilation_time, position)
    #animation.track_insert_key(0, 3, position - oscilation)
    #animation.track_insert_key(0, 4, position)
    animation.loop = true
    animationPlayer.play("oscilate")

func _on_AnimationPlayer_animation_finished(anim_name):
  if anim_name == "EnemyHit":
    self.queue_free()

func _on_StaticEnemy_hit(enemy):
  is_alive = false
  enemy.find_node("AnimationPlayer").play("EnemyHit")
