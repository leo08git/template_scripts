## Iterates through something, and calls the lambda every time it is iterated over. Returns the current iteration
func iterate_limiter(iterate_on: Variant, max_iterations_per_frame: int , lambda: Callable , use_physics_frame := false) -> void:
	var icount = 0
	for iteration in iterate_on:
		icount += 1
		lambda.call(iteration)
		if icount >= max_iterations_per_frame: await ((get_tree().physics_frame) if use_physics_frame else (get_tree().process_frame))

## Draw line uga uga
func draw_line(from: Vector2 , to: Vector2 , _for: float , width: float = 5.0 , color: Color = Color.WHITE):
	var line = Line2D.new()
	get_tree().current_scene.add_child(line)
	line.points = [line.to_local(from) , line.to_local(to)]
	line.width = width
	line.default_color = color
	await get_tree().create_timer(_for).timeout
	line.queue_free()

## Returns all the planes on a meshinstance3D
func _get_mesh_planes(mesh: MeshInstance3D) -> Array[Plane]:
	var array: Array[Plane] = []

	var face_id = -1
	var face_array = []
	const face_triangle_limit = 3

	for face in mesh.mesh.get_faces():
		face_id += 1
		if face_id != face_triangle_limit:
			face_array.append(face)
		else:
			array.append(Plane(face_array[0] , face_array[1] , face_array[2]))
			face_array.clear(); face_id = -1

	return array