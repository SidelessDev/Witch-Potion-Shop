extends RefCounted
class_name Order

var potion_id: String
var price: int

enum Status { PENDING, ACCEPTED, DONE }

var status: Status = Status.PENDING

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
