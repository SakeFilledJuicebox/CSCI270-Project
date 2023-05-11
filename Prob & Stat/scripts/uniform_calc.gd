extends Control

@onready var samples_line_edit = $VBoxContainer/SamplesLineEdit
@onready var lower_line_edit = $VBoxContainer/LimitContainer/LowerLineEdit
@onready var upper_line_edit = $VBoxContainer/LimitContainer/UpperLineEdit
@onready var obs_line_edit = $VBoxContainer/ObservationsLineEdit

var uni_variable_array = [0, 0, 0, 0]

func _ready():
	if EventBus.stored_uni_variables != [ ]:
		samples_line_edit.text = str(EventBus.stored_uni_variables[0])
		lower_line_edit.text = str(EventBus.stored_uni_variables[1])
		upper_line_edit.text = str(EventBus.stored_uni_variables[2])
		obs_line_edit.text = str(EventBus.stored_uni_variables[3])
		_on_line_edit_text_changed("")


func _on_line_edit_text_changed(_new_text):
	uni_variable_array = [int(samples_line_edit.text)
	, int(lower_line_edit.text)
	, int(upper_line_edit.text)
	, int(obs_line_edit.text)]


func _on_generate_button_pressed():
	if uni_variable_array[0] > 0 and uni_variable_array[3] > 0:
		EventBus.store_uni_variables(uni_variable_array) 
		get_tree().change_scene_to_file("res://scenes/uniform_samples.tscn")


func _on_gaussian_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gaussian_calc.tscn")


func _on_exit_button_pressed():
	get_tree().quit() 
