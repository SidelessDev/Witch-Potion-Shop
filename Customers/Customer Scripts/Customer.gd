extends CharacterBody3D
class_name Customer

@export var customer_id: String = ""
@export var customer_model: PackedScene

enum CustomerState {
	IDLE,
	WALKING
}

var current_state: CustomerState = CustomerState.IDLE
