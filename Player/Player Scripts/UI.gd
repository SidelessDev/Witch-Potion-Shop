extends CanvasLayer

@onready var money_label = $Control/Money_Label
@onready var dialogue_label = $Control/ColorRect/Dialogue_Label
@onready var dialogue_background = $Control/ColorRect
@onready var recipes_section = $Control/Recipes_Background

@onready var player = get_node("/root/Shop/Player")

var recipes_is_visible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MoneyManager.player_money_changed.connect(_on_money_changed)
	_on_money_changed(MoneyManager.player_money)
	
func _on_money_changed(money: int):
	money_label.text = "MONEY: " + str(money)


func show_order_dialogue(potion_name: String):
	player.can_move = false
	dialogue_label.text = "HI! I WOULD LIKE A " + potion_name + " PLEASE."
	dialogue_background.visible = true
	dialogue_label.visible = true

func hide_order_dialogue():
	dialogue_background.visible = false
	dialogue_label.visible = false
	player.can_move = true
	
func show_recipes():
	recipes_section.visible = true
	recipes_is_visible = true
	
func hide_recipes():
	recipes_section.visible = false
	recipes_is_visible = false
