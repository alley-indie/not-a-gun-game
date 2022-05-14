extends Node

func unshoot(space_state, unshooter, target):
  var result = space_state.intersect_ray(unshooter.transform.origin, target.transform.origin)
  if result:
    result.collider.emit_signal("hit", result.collider)
