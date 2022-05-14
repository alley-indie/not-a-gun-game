extends Node

func unshoot(space_state, unshooter, target):
  var colliders = [unshooter, target]
  
  var result = space_state.intersect_ray(
    unshooter.transform.origin, target.transform.origin, colliders,
    2147483647, true, true)
  
  while (result):
    if not result.collider.has_node("CollisionHandler"):
      return false
    colliders.append(result.collider)
    result = space_state.intersect_ray(
      unshooter.transform.origin, target.transform.origin, colliders,
      2147483647, true, true)
  
  for collider in colliders:
    if not collider in [unshooter, target]:
      collider.get_node("CollisionHandler").on_hit("bullet")
  
  return true
