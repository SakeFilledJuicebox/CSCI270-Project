extends Control

@onready var vbox_container = $ScrollContainer/VBoxContainer
@onready var clt_msd_label = $VBoxContainer2/CLTMSDLabel
@onready var sample_msd_label = $VBoxContainer2/SampleMSDLabel

var copy_string = ""
const ROW = preload("res://scenes/row.tscn")


func _ready():
	var gauss_variable_array = EventBus.get_gauss_variables()
	display_clt(gauss_variable_array)
	generate(gauss_variable_array)

func display_clt(gauss_variable_array):
	var clt_mean = gauss_variable_array[1]
	var clt_sd = gauss_variable_array[2] / sqrt(gauss_variable_array[3])
	var sig_figs = gauss_variable_array[4]
	clt_msd_label.text = "x̄ ≈ N(" + str(clt_mean).pad_decimals(sig_figs) + ", " + str(clt_sd).pad_decimals(sig_figs) + ")"


func display_samples(generation_means, samples, gauss_sd):
	var sample_mean = sumf_array(generation_means) / (samples)
	var sample_summation = 0
	for i in generation_means:
		sample_summation += pow((i - sample_mean), 2)
	var sample_sd = sqrt(sample_summation/(samples))
	sample_msd_label.text = "x̄ ≈ N(" + str(snapped(sample_mean, 0.01)) + ", " + str(snapped(sample_sd, 0.01)) + ")"


func generate(gauss_variable_array):
	var samples = gauss_variable_array[0]
	var gauss_mean = gauss_variable_array[1]
	var gauss_sd = gauss_variable_array[2]
	var observations = gauss_variable_array[3]
	var sig_figs = gauss_variable_array[4]
	var generation_means= [ ]
	var row_count = 1
	for s in range(0, samples):
		var generations = [ ]
		var str_generations = [ ]
		var generation_mean
		var new_row
		for g in range(0, observations):
			var random = randfn(gauss_mean, gauss_sd)
			var random_str = str(random).pad_decimals(sig_figs)
			generations.append(random)
			str_generations.append(random_str)
			if g != (observations - 1):
				copy_string = copy_string + str(random_str) + "\t"
			else:
				copy_string = copy_string + str(random_str) + "\n"
		generation_mean = sumf_array(generations) / observations
		generation_means.append(generation_mean)
		new_row = ROW.instantiate()
		new_row.text = "#" + str(row_count) + ") x̄ = " + str(generation_mean).pad_decimals(gauss_sd) + " " + str(str_generations)
		vbox_container.add_child(new_row)
		row_count += 1
	display_samples(generation_means, samples, gauss_sd)


func sumf_array(float_array):
	var sum = 0.0
	for element in float_array:
		sum += element
	return sum


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gaussian_calc.tscn")


func _on_copy_button_pressed():
	DisplayServer.clipboard_set(copy_string)
