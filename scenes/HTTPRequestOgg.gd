extends HTTPRequest


var tts_host: String


func _ready():
	pass

func set_tts_host(host: String) -> void:
	tts_host = host

func request_tts(text: String) -> void:
	if not tts_host:
		return
	var body := JSON.print({ 'text': text })
	var headers := [ "Content-Type: application/json" ]
	var method :=  HTTPClient.METHOD_POST
	var error := request(tts_host, headers, true, method, body)
	if error != OK:
		print(error)
