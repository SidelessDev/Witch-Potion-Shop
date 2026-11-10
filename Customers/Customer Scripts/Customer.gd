extends CharacterBody3D
class_name Customer

@export var customer_id: String = ""

func _ready() -> void:
	OrderManager.create_order()
	print("COMMANDE CRÉÉ")
