const RAW := [{
	"gid": 1,
	"name": "The first test",
	"prompt": "Oh lord, stuff happened and now some more stuff happenend. What will you do?",
	"options": [{
		"text": "Let's just literally kill everyone",
		"id": "kill",
		"consequences": {
			"military": 20,
			"stability": -10,
		},
	}, {
		"text": "Figure it out yourselves",
		"character": "general",
		"consequences": {
			"military": -20,
			"stability": 10,
		},
	}, {
		"text": "...",
		"consequences": {
			"money": 5,
		},
	}],
}, {
	"gid": 2,
	"name": "The second test",
	"prompt": "Some more stuff happened",
	"options": [{
		"text": "Ignore it",
		"consequences": {
			"stability": -10,
			"money": 30,
		},
	}, {
		"text": "Deal with it",
		"consequences": {
			"diplomacy": 20,
		},
	}],
}, {
	"gid": 3,
	"name": "The third test",
	"prompt": "I don't even know anymore",
	"requirements": [{
		"gid": 1,
		"chosen_option_id": "kill",
	}],
	"options": [{
		"text": "Take the blame",
		"consequences": {
			"stability": -50,
		},
	}],
}]
