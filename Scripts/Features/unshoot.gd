extends Node

func unshoot(space_state, unshooter, target):
  var colliders = [unshooter, target]
  
  var result = space_state.intersect_ray(
    unshooter.transform.origin, target.transform.origin, colliders,
    2147483647, true, true)
  
  while (result):
    if not result.collider.is_in_group("bullet"):
      if not result.collider.has_node("CollisionHandler"):
        return false
    colliders.append(result.collider)
    result = space_state.intersect_ray(
      unshooter.transform.origin, target.transform.origin, colliders,
      2147483647, true, true)
  
  target.get_parent().get_parent().find_node("animate").emit_signal("bullet_ray", unshooter.position, target.position)
  for collider in colliders:
    if not collider in [unshooter, target] and not collider.is_in_group("bullet"):
      Global.play_enemy_killed_sound()
      collider.emit_signal("hit", collider)
      #collider.on_hit()
      collider.get_node("CollisionHandler").on_hit("bullet")
  
  #target.get_parent().get_parent().find_node("animate").emit_signal("bullet_ray", unshooter.position, target.position)
  #if result:
    #result.collider.emit_signal("hit", result.collider)

  return true
