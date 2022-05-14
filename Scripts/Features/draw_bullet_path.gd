extends Node

func draw(canvas_item, from, to):
  print(canvas_item)
  canvas_item.draw_line(from.transform.origin, to.transform.origin, Color.white)
