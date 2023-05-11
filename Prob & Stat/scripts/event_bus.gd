extends Node

var stored_uni_variables = []
var stored_gauss_variables =[]

func store_uni_variables(uni_variable_array):
	stored_uni_variables = uni_variable_array

func store_gauss_variables(gauss_variable_array):
	stored_gauss_variables = gauss_variable_array

func get_uni_variables():
	return stored_uni_variables

func get_gauss_variables():
	return stored_gauss_variables
