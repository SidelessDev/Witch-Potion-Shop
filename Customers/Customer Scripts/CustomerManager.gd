extends Node

var is_shop_busy = false
var current_customer

@onready var CustomerSpawn: Marker3D = get_tree().get_first_node_in_group("Spawner")

var customers = {
	"customer1": {
		"scene": preload("res://Customers/Alien/alien.tscn")
	},
	"customer2": {
		"scene": preload("res://Customers/Alien2/alien2.tscn")
	},
	"customer3": {
		"scene": preload("res://Customers/Alpaking/alpaking.tscn")
	},
	"customer4": {
		"scene": preload("res://Customers/Alpaking Evolved/alpaking_evolved.tscn")
	},
	"customer5": {
		"scene": preload("res://Customers/Armabee/armabee.tscn")
	},
	"customer6": {
		"scene": preload("res://Customers/Armabee Evolved/armabee_evolved.tscn")
	},
	"customer7": {
		"scene": preload("res://Customers/Birb/birb.tscn")
	},
	"customer8": {
		"scene": preload("res://Customers/Blue Demon/blue_demon.tscn")
	},
	"customer9": {
		"scene": preload("res://Customers/Bunny/bunny.tscn")
	}
}


func new_customer_enter():
	is_shop_busy = true
	var random_index = randi_range(0, customers.size() -1)
	var selected_customer = customers.keys()[random_index]
	#var selected_customer = "customer1"
	
	var new_customer = Customer.new()
	new_customer.customer_id = selected_customer
	new_customer.customer_model = customers[selected_customer]["scene"]
	spawn_customer(new_customer.customer_model)
	OrderManager.create_order()

func spawn_customer(customer_model: PackedScene):
	current_customer = customer_model.instantiate()
	var collision = current_customer.get_node("CollisionShape3D")
	CustomerSpawn.add_child(current_customer)
	
	current_customer.transform = Transform3D.IDENTITY
	
func customer_leave():
	current_customer.queue_free()
	await get_tree().create_timer(3.0).timeout
	new_customer_enter()
