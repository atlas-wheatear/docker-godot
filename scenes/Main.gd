extends Node2D

const SERVER_ID = 1

var send: Button
var input: LineEdit
var player: AudioStreamPlayer
var history: TextEdit
var is_server: bool # don't use this, use built-in methods
var peer: NetworkedMultiplayerENet
var requester: HTTPRequest

func _ready():
	send = $Send
	input = $Input
	player = $OggPlayer
	history = $History
	peer = NetworkedMultiplayerENet.new()
	if "--server" in OS.get_cmdline_args():
		init_server()
	else:
		init_client()
	get_tree().network_peer = peer
	get_tree().connect("connected_to_server", self, "_connected_ok")

func _connected_ok() -> void:
	print("Connection succesfully made!")

func init_server() -> void:
	requester = $Requester
	var tts_host := OS.get_environment("TTS_HOST")
	var tts_port := OS.get_environment("TTS_PORT")
	requester.set_tts_host("http://" + tts_host + ":" + tts_port)
	var port := int(OS.get_environment("GODOT_PORT"))
	var max_players := int(OS.get_environment("MAX_PLAYERS"))
	peer.create_server(port, max_players)
	is_server = true

func init_client() -> void:
	# don't hardcode things :(
	var server_host := "192.168.69.2"
	var server_port := 7070
	peer.create_client(server_host, server_port)
	is_server = false

remote func generate_tts(text: String) -> void:
	if not is_server:
		return
	requester.request_tts(text)

remote func play_tts(uuid: String) -> void:
	if is_server:
		return
	player.play_tts(uuid)

func _on_Send_button_up():
	var text := input.get_text()
	history.add(text)
	rpc_id(SERVER_ID, "generate_tts", text)


func _on_Requester_request_completed(_result, response_code, _headers, body):
	if response_code != HTTPClient.RESPONSE_OK:
		return
	var response: Dictionary = parse_json(body.get_string_from_utf8())
	var uuid: String = response["uuid"]
	rpc("play_tts", uuid)
