extends Node
# Get global vaariables
onready var vars = get_node("/root/Variables")
var remTouched = false

# MAJU 
func _on_A_Button_pressed():
	vars.maju = true

func _on_A_Button_released():
	vars.maju = false


# MUNDUR 
func _on_B_Button_pressed():
	vars.mundur = true

func _on_B_Button_released():
	vars.mundur = false


# KIRI
func _on_LeftButton_pressed():
	vars.kiri = true

func _on_LeftButton_released():
	vars.kiri = false


# KANAN
func _on_RightButton_pressed():
	vars.kanan = true

func _on_RightButton_released():
	vars.kanan = false

# REM
func _on_X_Button_pressed():
	vars.rem = true


func _on_X_Button_released():
	vars.rem = false
