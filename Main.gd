extends Node

export (Array, String, FILE) var scripts

const ScenePlayer := preload("res://ScenePlayer.tscn")

const SCENES := []

var _current_index := -1
var _scene_player: ScenePlayer

var lexer := SceneLexer.new()
var parser := SceneParser.new()
var transpiler := SceneTranspiler.new()

onready var gameNode: Node2D = get_node("Node2D")
var inGame: bool = false

func _ready() -> void:
	_connect_signals()
	
	if not scripts.empty():
		for script in scripts:
			var text := lexer.read_file_content(script)
			var tokens: Array = lexer.tokenize(text)

			var tree: SceneParser.SyntaxTree = parser.parse(tokens)

			var dialogue: SceneTranspiler.DialogueTree = transpiler.transpile(tree, 0)

			# Make sure the scene is transitioned properly at the end of the script
			if not dialogue.nodes[dialogue.index - 1] is SceneTranspiler.JumpCommandNode:
				(dialogue.nodes[dialogue.index - 1] as SceneTranspiler.BaseNode).next = -1

			SCENES.append(dialogue)

		_play_scene(0)


func _play_scene(index: int) -> void:
	_current_index = int(clamp(index, 0.0, SCENES.size() - 1))

	if _scene_player:
		_scene_player.queue_free()

	_scene_player = ScenePlayer.instance()
	add_child(_scene_player)
	_scene_player.load_scene(SCENES[_current_index])
	_scene_player.connect("scene_finished", self, "_on_ScenePlayer_scene_finished")
	_scene_player.connect("restart_requested", self, "_on_ScenePlayer_restart_requested")
	_scene_player.connect("open_game", self, "_open_game")
	_scene_player.run_scene(0)

func _connect_signals() -> void:
	#get_node("Node2D/WinButton").connect("button_pressed", self, "_on_game_end")
	get_node("Node2D/LoseButton").connect("button_pressed", self, "_on_game_end")
	get_node("Node2D").connect("game_finished", self, "game_finished")

func _on_ScenePlayer_scene_finished() -> void:
	# If the scene that ended is the last scene, we're done playing the game.
	if _current_index == SCENES.size() - 1:
		return
	_play_scene(_current_index + 1)


func _on_ScenePlayer_restart_requested() -> void:
	_play_scene(_current_index)

var _key = 0

func game_finished(result):
	if result:
		_on_game_end("true");
	else:
		_on_game_end("false");


func _on_game_end(code) -> void:
	Variables.add_variable("game_summary", code)
	_open_game("close", _key, 0)

func _open_game(mode, nextKey, win_score) -> void:
	if gameNode == null:
		return
	_key = nextKey
	
	if mode == "start":
		gameNode.start_game(win_score);
		_scene_player.hide_text_box();
	else:
		var score = gameNode.end_game();
		_scene_player.show_text_box();
		_scene_player.run_scene(_key)
