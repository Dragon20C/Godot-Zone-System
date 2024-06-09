extends Node


var num_players = 16
var bus = "master"

enum audio {
	switch_sfx
}

var audio_sfx : Dictionary = {
	audio.switch_sfx : preload("res://Source/Assets/Sounds/Misc/Switch SFX.wav")
}

enum audio_pack {
	hurt,
	zombie_attack
}

var audio_pack_sfx : Dictionary = {
	audio_pack.hurt : [],
	audio_pack.zombie_attack : []
}

var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready():
	generate_audioplayer()

func generate_audioplayer() -> void:
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)

		available.append(p)

		p.volume_db = 1
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func _on_stream_finished(stream):
	available.append(stream)

func rand_play(_audio_pack : audio_pack) -> void:
	var selected_audio : AudioStreamWAV = audio_pack_sfx[_audio_pack].pick_random()
	queue.append(selected_audio)

func play(_audio : audio) -> void:
	queue.append(audio_sfx[_audio])


func _process(_delta):
	if not queue.is_empty() and not available.is_empty():
		var sound_package : AudioStreamWAV = queue.pop_front()
		available[0].stream = sound_package
		available[0].play()
		available[0].pitch_scale = randf_range(0.9, 1.1)

		available.pop_front()
