extends Node2D

signal game_finished

var _player: AudioStreamPlayer

onready var _grid = get_node("grid");
onready var _scoreLabel = get_node("ScoreNode/ScoreLabel");
onready var _stepLabel = get_node("StepNode/StepLabel");
onready var _charismaLabel = get_node("ColorNode/YellowLabel");
onready var _artifact = get_node("ArtifactPanel/ArtifactNode");
onready var _bar = get_node("BottomPanel/ScrolInput")

var _score = 0;
var _win_score = 0;
var _step: int = 0;
var _charisma: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("GameMusicPlayer")
	_connect_signals()
	update_artifact_visible()

func _connect_signals():
	_grid.connect("destroyed", self, "add_score")
	_grid.connect("step", self, "add_step")
	_artifact.connect("button_pressed", self, "_button_pressed");

func add_score(count, color):
	_score += count;
	_scoreLabel.text = "Счет: " + String(_score);
	
	if (color == "Charisma"):
		_charisma += count;
		update_artifact_visible()

func update_artifact_visible() -> void:
	_charismaLabel.text = "Харизма: " + String(_charisma);	
	_bar.count = _charisma
	_bar.update_bar(_charisma)
	
	if (_charisma >= 5):
		_artifact.visible = true
	else:
		_artifact.visible = false

func add_step(count):
	_step += count;
	_stepLabel.text = "Осталось ходов: " + String(_win_score - _step);
	if (_step >= _win_score):
		yield(get_node("grid/refill_timer"), "timeout")
		emit_signal("game_finished", true);

func start_game(win_score: int) -> void:
	_score = 0;
	_step = 0;
	_charisma = 0;
	_win_score = win_score;
	_scoreLabel.text = "Счет: " + String(_score);
	_stepLabel.text = "Осталось ходов: " + String(_win_score - _step);
	visible = true;
	_switch_music(true)

func end_game() -> int:
	visible = false;
	_switch_music(false)
	return _score;

func _button_pressed(code: String) -> void:
	print(code);
	if (code != "artifact"):
		return
	
	if (_charisma >= 5):
		add_score(-5, "Charisma")
		_grid.destroy_row(0);
		update_artifact_visible()

func _switch_music(play: bool) -> void:
	if _player == null:
		return
	if !play:
		_player.stop()
	else:
		_player.stream = load("res://Sounds/three_in_a_row.mp3")
		_player.play()
	
