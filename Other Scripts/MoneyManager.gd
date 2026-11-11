extends Node

var player_money: int
signal player_money_changed(new_amount: int)

func add_money(amount: int):
	player_money += amount
	player_money_changed.emit(player_money)
