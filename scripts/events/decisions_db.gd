const RAW_DECISIONS := [{
	"gid": 1,
	"name": "The first test",
	"prompt": "Oh lord, stuff happened and now some more stuff happenend. What will you do?",
	"options": [{
		"text": "Let's just literally kill everyone",
		"consequences": {
			"military": 20,
			"stability": -10
		}
	}, {
		"text": "Figure it out yourselves",
		"consequences": {
			"military": -20,
			"stability": 10
		}
	}, {
		"text": "...",
		"consequences": {
			"money": 5
		}
	}]
}]
