extends Node

@onready var player = get_tree().get_first_node_in_group("player")

var current_order: Order
var available_potions = RecipeManager.potions

func create_order():
	var random_index = randi_range(0, available_potions.size() -1)
	
	var selected_potion = available_potions.keys()[random_index]
	
	var new_order = Order.new()
	new_order.potion_id = selected_potion
	new_order.price = RecipeManager.potions[selected_potion]["value"]
	
	current_order = new_order
	print(selected_potion)
	print(current_order.price)

func accept_order():
	if current_order == null:
		return
	if current_order.status != Order.Status.PENDING:
		return
		
	current_order.status = Order.Status.ACCEPTED
	print("ACCEPTÉ")

func check_order(prepared_potion_id: String):
	if prepared_potion_id == current_order.potion_id:
		complete_order()

func complete_order():
	player.held_item.queue_free()
	player.held_item = null
	MoneyManager.add_money(current_order.price)
	print(MoneyManager.player_money)
