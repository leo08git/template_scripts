## Iterates through something, and calls the lambda every time it is iterated over. Returns the current iteration
func iterate_limiter(iterate_on: Variant, max_iterations_per_frame: int , lambda: Callable , use_physics_frame := false) -> void:
	var icount = 0
	for iteration in iterate_on:
		icount += 1
		lambda.call(iteration)
		if icount >= max_iterations_per_frame: await ((get_tree().physics_frame) if use_physics_frame else (get_tree().process_frame))
