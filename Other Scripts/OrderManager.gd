extends Node

@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_ui = get_node("/root/Shop/Player/Player_UI")

var current_order: Order
var available_potions = RecipeManager.potions

func create_order():
	var random_index = randi_range(0, available_potions.size() -1)
	
	var selected_potion = available_potions.keys()[random_index]
	
	var new_order = Order.new()
	new_order.potion_id = selected_potion
	new_order.price = RecipeManager.potions[selected_potion]["value"]
	new_order.name = RecipeManager.potions[selected_potion]["name"]
	
	current_order = new_order

func accept_order():
	if current_order == null:
		return
	if current_order.status != Order.Status.PENDING:
		return
	
	current_order.status = Order.Status.ACCEPTED
	player_ui.show_order_dialogue(current_order.name)

func check_order(prepared_potion_id: String):
	if prepared_potion_id == current_order.potion_id:
		complete_order()

func complete_order():
	player.held_item.queue_free()
	player.held_item = null
	MoneyManager.add_money(current_order.price)
	CustomerManager.customer_leave()
