extends Node2D

signal game_finished;

onready var _grid = get_node("grid");
onready var _scoreLabel = get_node("ScoreNode/ScoreLabel");

var _score = 0;
var _win_score = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	_connect_signals();

func _connect_signals():
	_grid.connect("destroyed", self, "add_score")

func add_score(count):
	_score += count;
	_scoreLabel.text = String(_score) + " / " + String(_win_score);
	if (_score >= _win_score):
		emit_signal("game_finished", true);

func start_game(win_score: int):
	_score = 0;
	_win_score = win_score;
	_scoreLabel.text = String(_score) + " / " + String(_win_score);
	visible = true;

func end_game() -> int:
	visible = false;
	return _score;
