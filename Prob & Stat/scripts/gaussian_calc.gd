extends Control

@onready var samples_line_edit = $VBoxContainer/SamplesLineEdit
@onready var mean_line_edit = $VBoxContainer/GaussianContainer/MeanLineEdit
@onready var sd_line_edit = $VBoxContainer/GaussianContainer/SDLineEdit
@onready var obs_line_edit = $VBoxContainer/ObservationsLineEdit
@onready var sg_line_edit = $VBoxContainer/GaussianContainer/SigLineEdit

var gauss_variable_array = [0, 0, 0, 0, 0]

func _ready():
	if EventBus.stored_gauss_variables != [ ]:
		samples_line_edit.text = str(EventBus.stored_gauss_variables[0])
		mean_line_edit.text = str(EventBus.stored_gauss_variables[1])
		sd_line_edit.text = str(EventBus.stored_gauss_variables[2])
		obs_line_edit.text = str(EventBus.stored_gauss_variables[3])
		sg_line_edit.text = str(EventBus.stored_gauss_variables[4])
		_on_line_edit_text_changed("")


func _on_line_edit_text_changed(_new_text):
	gauss_variable_array = [int(samples_line_edit.text)
	, int(mean_line_edit.text)
	, int(sd_line_edit.text)
	, int(obs_line_edit.text)
	, int(sg_line_edit.text)]


func _on_generate_button_pressed():
	if gauss_variable_array[0] > 0 and gauss_variable_array[3] > 0 and gauss_variable_array[4] >= 0:
		EventBus.store_gauss_variables(gauss_variable_array)
		get_tree().change_scene_to_file("res://scenes/gaussian_samples.tscn")


func _on_uniform_button_pressed():
	get_tree().change_scene_to_file("res://scenes/uniform_calc.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
