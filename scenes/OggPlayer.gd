extends AudioStreamPlayer

var getter: HTTPRequest

func _ready():
	getter = $Getter

func set_socket(host: String, port: int) -> void:
	var socket := "http://" + host + ":" + str(port)
	getter.set_socket(socket)

func play_tts(uuid: String) -> void:
	getter.get_tts(uuid)

func _on_Getter_request_completed(_result, response_code, _headers, body):
	if response_code != HTTPClient.RESPONSE_OK:
		return
	var the_stream := AudioStreamOGGVorbis.new()
	the_stream.data = body
	self.stream = the_stream
	play()
