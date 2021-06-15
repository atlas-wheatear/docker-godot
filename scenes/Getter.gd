extends HTTPRequest

var URL : String


func _ready():
	pass

func set_socket(socket: String) -> void:
	URL = socket + "/dl"

func get_tts(uuid: String) -> void:
	var body := JSON.print({"uuid": uuid})
	var headers := [ "Content-Type: application/json" ]
	var error := request(URL, headers, true, HTTPClient.METHOD_GET, body)
	if error != OK:
		print(error)
