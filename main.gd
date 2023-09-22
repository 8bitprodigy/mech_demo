extends Node

@export_node_path("Panel") var _connect_menu : NodePath
@onready var connect_menu = get_node(_connect_menu)
@export_node_path("LineEdit") var _address_entry : NodePath
@onready var address_entry =  get_node(_address_entry)
@export_node_path("OptionButton") var _network_option : NodePath
@onready var network_option = get_node(_network_option)
@export_node_path("Node") var _spawn_path : NodePath
@onready var spawn_path = get_node(_spawn_path)
@export_node_path("MultiplayerSpawner") var _multiplayer_spawner : NodePath
@onready var multiplayer_spawner = get_node(_multiplayer_spawner)

var window : Window = Window.new()

func _ready():
	MultiplayerManager.spawn_path = spawn_path.get_path()
	MultiplayerManager.multiplayer_spawner = multiplayer_spawner
	prints("Spwan Path: ", MultiplayerManager.spawn_path)
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(_event):
	pass


func _on_btn_host_pressed():
	connect_menu.hide()
	MultiplayerManager.host(network_option.selected)
	#get_window().connect("focus_entered", func():
	#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#	)


func _on_btn_connect_pressed():
	connect_menu.hide()
	MultiplayerManager.join(network_option.selected,address_entry.text)
	#get_window().connect("focus_entered", func():
	#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#	)
