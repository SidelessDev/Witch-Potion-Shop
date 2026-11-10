extends Node

var ingredients = [
	{
		"id" = "fly",
		"name" = "Fly"
	},
	{
		"id" = "frog",
		"name" = "Frog"
	},
	{
		"id" = "grass_ingredient",
		"name" = "Grass"
	},
	{
		"id" = "octopus",
		"name" = "Octopus"
	},
	{
		"id" = "steak",
		"name" = "Raw Meat"
	},
	{
		"id" = "tentacle",
		"name" = "Tentacle"
	},
	{
		"id" = "wheat",
		"name" = "Wheat"
	},
	{
		"id" = "skull",
		"name" = "Human Skull"
	},
	{
		"id" = "cattail",
		"name" = "Cattail"
	},
	{
		"id" = "crystal",
		"name" = "Crystal"
	},
	{
		"id" = "carrot",
		"name" = "Carrot"
	},
	{
		"id" = "turnip",
		"name" = "Turnip"
	}
]


var potions = {
	"potion_red": {
		"name": "Red Potion",
		"value": 15,
		"required_ingredients": [
			"steak",
			"fly",
			"frog"
		],
		"scene": preload("res://Items/potion_red.tscn")
	},
	"potion_green": {
		"name": "Green Potion",
		"value": 15,
		"required_ingredients": [
			"grass_ingredient",
			"octopus",
			"frog"
		],
		"scene": preload("res://Items/potion_green.tscn")
	},
	"potion_violet": {
		"name": "Violet Potion",
		"value": 15,
		"required_ingredients": [
			"tentacle",
			"carrot",
			"crystal"
		],
		"scene": preload("res://Items/potion_violet.tscn")
	},
	"potion_yellow": {
		"name": "Yellow Potion",
		"value": 15,
		"required_ingredients": [
			"wheat",
			"skull",
			"grass_ingredient"
		],
		"scene": preload("res://Items/potion_yellow.tscn")
	}
}
