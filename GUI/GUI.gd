extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func reduceStamina(reduced_amount):
	$Control/Stamina.value -= reduced_amount

func regenStamina(regen_amount):
	$Control/Stamina.value += regen_amount
