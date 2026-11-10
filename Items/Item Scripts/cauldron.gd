extends StaticBody3D

@onready var player = $"../Player"

var cauldron_ingredients: Array[String] = []
var prepared_potion_id: String

func use_machine(machine: StaticBody3D):
	if player.held_item == null:
		return
	# Verify if item is an ingredient
	if player.held_item is Ingredient:
		var ingredient = player.held_item
		add_ingredient(ingredient)
	else:
		print("Vous ne pouvez rien faire avec cela")

func add_ingredient(ingredient):
	if cauldron_ingredients.size() >= 3:
		return
	
	cauldron_ingredients.append(ingredient.ingredient_id)
	ingredient.queue_free()
	
	if cauldron_ingredients.size() == 3:
		check_recipe()

func check_recipe():
	var deposited_ing = cauldron_ingredients.duplicate()
	deposited_ing.sort()
	
	for potion_id in RecipeManager.potions:
		var required_ing = RecipeManager.potions[potion_id]["required_ingredients"].duplicate()
		required_ing.sort()
		
		if deposited_ing == required_ing:
			var potion_scene = RecipeManager.potions[potion_id]["scene"]
			player.get_brewed_potion(potion_scene)
			cauldron_ingredients.clear()
			prepared_potion_id = potion_id
			return prepared_potion_id
	
	var poison_potion_scene = preload("res://Items/potion_poison.tscn")
	player.get_brewed_potion(poison_potion_scene)
	cauldron_ingredients.clear()
	var prepared_potion_id = "poison_potion"
	return prepared_potion_id
