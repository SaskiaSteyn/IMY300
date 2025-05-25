extends GutTest

class TestProgressBarValue:
	extends GutTest

	var Progress_Bar = load('res://scripts/progress_bar.gd')
	var _progress_bar = null

	func before_each():
		_progress_bar = Progress_Bar.new()
		
	func after_each():
		_progress_bar.queue_free()

	func test_something():
		_progress_bar._change_energy(50.0)
		assert_eq(_progress_bar.value, 50.0)
