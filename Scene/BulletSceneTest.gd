extends Node2D

onready var player = $Player
onready var bullet = $Bullet

const UnshootScript = preload("res://Scripts/Features/unshoot.gd")

var unshootScript

func _ready():
  unshootScript = UnshootScript.new()

func get_input(delta):

  if Input.is_action_just_pressed("ui_accept"):
    var space_state = get_world_2d().direct_space_state
    unshootScript.unshoot(space_state, bullet, player)

func _physics_process(delta):
  get_input(delta)
