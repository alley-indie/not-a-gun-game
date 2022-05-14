extends Node

func unshoot(space_state, unshooter, target):
  var colliders = [unshooter, target]
  
  var result = space_state.intersect_ray(
    unshooter.transform.origin, target.transform.origin, colliders,
    2147483647, true, true)
  
  while (result):
    colliders.append(result.collider)
    result = space_state.intersect_ray(
    unshooter.transform.origin, target.transform.origin, colliders,
    2147483647, true, true)
  
  colliders = filter_colliders(colliders, unshooter, target)
  if collides_with_walls(colliders, unshooter, target):
    return false
  
  for collider in colliders:
    collider.get_node("CollisionHandler").on_hit("bullet")
  
  return true

  #target.get_parent().get_parent().find_node("animate").emit_signal("bullet_ray", unshooter.position, target.position)
  #if result:
    #result.collider.emit_signal("hit", result.collider)

func filter_colliders(hits, unshooter, target):
  var colliders = []
  for collider in hits:
    if collider == unshooter:
      continue
    elif collider == target:
      continue
    colliders.append(collider)
  return colliders

func collides_with_walls(hits, unshooter, target):
  for collider in hits:
    if not collider.has_node("CollisionHandler"):
      return true
  return false
