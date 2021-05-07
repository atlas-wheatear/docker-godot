extends TextEdit

var history := ""

func _ready():
	pass

func add(text):
	history += "\n" + text
	set_text(history)
