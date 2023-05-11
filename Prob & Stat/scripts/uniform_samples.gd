extends Control

@onready var vbox_container = $ScrollContainer/VBoxContainer
@onready var clt_msd_label = $VBoxContainer/CLTMSDLabel
@onready var sample_msd_label = $VBoxContainer/SampleMSDLabel
const ROW = preload("res://scenes/row.tscn")
var copy_string = ""

func _ready():
	var uni_variable_array = EventBus.get_uni_variables()
	display_clt(uni_variable_array)
	generate(uni_variable_array)

func display_clt(uni_variable_array):
	var clt_mean = ((uni_variable_array[2] - uni_variable_array[1]) / 2)
	var clt_sd = sqrt((pow(uni_variable_array[2] - uni_variable_array[1], 2)/12))/ sqrt(uni_variable_array[3])
	clt_msd_label.text = "x̄ ≈ N(" + str(clt_mean) + ", " + str(snapped(clt_sd, 0.01)) + ")"


func display_samples(generation_means, samples):
	var sample_mean = sumi_array(generation_means) / (samples)
	var sample_summation = 0
	for i in generation_means:
		sample_summation += pow((i - sample_mean), 2)
	var sample_sd = sqrt(sample_summation/(samples))
	sample_msd_label.text = "x̄ ≈ N(" + str(snapped(sample_mean, 0.01)) + ", " + str(snapped(sample_sd, 0.01)) + ")"


func generate(uni_variable_array):
	var samples = uni_variable_array[0]
	var lower_limit = uni_variable_array[1]
	var upper_limit = uni_variable_array[2]
	var observations = uni_variable_array[3]
	var generation_means = [ ]
	var row_count = 1
	for s in range(0, samples):
		var generations = [ ]
		var generation_mean
		var new_row
		for g in range(0, observations):
			var random = randi_range(lower_limit, upper_limit)
			generations.append(random)
			if g != (observations - 1):
				copy_string = copy_string + str(random) + "\t"
			else:
				copy_string = copy_string + str(random) + "\n"
		generation_mean = sumi_array(generations) / observations
		generation_means.append(generation_mean)
		new_row = ROW.instantiate()
		new_row.text = "#" + str(row_count) + ") " + " x̄ = " + str(generation_mean) + " " + str(generations)
		vbox_container.add_child(new_row)
		row_count += 1
	display_samples(generation_means, samples) 

func sumi_array(int_array):
	var sum = 0.0
	for element in int_array:
		sum += element
	return sum

func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/uniform_calc.tscn") 


func _on_copy_button_pressed():
	DisplayServer.clipboard_set(copy_string)
