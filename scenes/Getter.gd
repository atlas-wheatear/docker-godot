extends HTTPRequest

# don't hardcode things :(
const URL = "http://192.168.69.2:5050/dl"


func _ready():
	pass

func get_tts(uuid: String) -> void:
	var body := JSON.print({"uuid": uuid})
	var headers := [ "Content-Type: application/json" ]
	var error := request(URL, headers, true, HTTPClient.METHOD_GET, body)
	if error != OK:
		print(error)
