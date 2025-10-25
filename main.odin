package main

import "core:log"

item :: struct {
	x, y, z: f32,
}

fillem :: proc(items: ^#soa[dynamic]item) {
	for i in 0 ..< 10 {
		append_soa(items, item{f32(i), f32(i), f32(i)})
	}
}

removeodd :: proc(items: ^#soa[dynamic]item) {
	#reverse for _, i in items {
		if (i % 2 != 0) {
			unordered_remove_soa(items, i)
		}
	}
}

// https://godbolt.org/z/9z1zdG7j6
scale :: proc(items: ^#soa[dynamic]item, factor: f32) {
	xs := items.x[:len(items)]
	for i in 0 ..< len(xs) {
		xs[i] *= factor
	}
	ys := items.y[:len(items)]
	for i in 0 ..< len(ys) {
		ys[i] *= factor
	}
	zs := items.z[:len(items)]
	for i in 0 ..< len(zs) {
		zs[i] *= factor
	}
}

main :: proc() {
	using log
	context.logger = create_console_logger(lowest = Level.Debug)

	fs: #soa[dynamic]item
	defer delete(fs)

	fillem(&fs)

	scale(&fs, 3.14)

	removeodd(&fs)

	for f in fs {
		info(f)
	}

	destroy_console_logger(context.logger)
}
