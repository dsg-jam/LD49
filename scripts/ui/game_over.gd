extends Control


var death_notes = {
	"military": "Your army was, let's just say, too weak!",
	"diplomacy": "Your neighboring countries were stronger than you, try again!",
	"money": "You may be full of pride, but unfortunately your banks are not...",
	"stability": "Your nation was too unstable, I'm sorry..."
}

onready var death_note = $VBoxContainer/DeathNote

func _ready():
	death_note.text = death_notes[Manager.cause_of_death]
