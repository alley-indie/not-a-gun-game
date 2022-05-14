extends Node

func unshoot(space_state, unshooter, target):
  var result = space_state.intersect_ray(
    unshooter.transform.origin, target.transform.origin, [unshooter, target])
  target.get_parent().get_parent().find_node("animate").emit_signal("bullet_ray", unshooter.position, target.position)
  if result:
    result.collider.emit_signal("hit", result.collider)
