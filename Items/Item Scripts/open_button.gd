extends StaticBody3D

func use_machine(machine: StaticBody3D):
	if CustomerManager.is_shop_busy:
		return
	else:
		CustomerManager.new_customer_enter()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
