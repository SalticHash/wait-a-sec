extends BoardElement2D


func _instantiate_node(packed_scene: PackedScene) -> void:
	var instance: Node = packed_scene.instantiate()
	get_parent().add_child(instance)
	instance.position = position
	instance.play("wall")


func _disappear() -> void:
	if not visible:
		return
	_instantiate_node(ScrGlobal.TRAIL_SCENE)
	super()
