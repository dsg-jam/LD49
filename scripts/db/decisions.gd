const RAW := [{
	"gid": 0,
	"name": "Introduction",
	"prompt": "You are the ruler of this unstable country. Your task is to lead the country through this difficult time. Make one of these decisions. But be careful, decisions can influence your stats [see the right figure]... /n Today, your minister of inner affairs made you aware, that more and more people are losing their job. Those who are now suffering are threatening to revolt against you. What will you do?",
	"options": [{
		"text": "Invest in infrastructure",
		"id": "infrastructure",
		"consequences": {
			"stability": 1,
			"money": -10,
		},
	}, {
		"text": "Start a propaganda agency",
		"consequences": {
			"money": -5,
			"stability": 5,
		},
	}, {
		"text": "Ignore for now",
		"consequences": {
			"stability": -5,
		},
	}],
}, {
	"gid": 1,
	"name": "military at the blue border",
	"prompt": "Your best Diplomat comes to you and explains, that the leader of the country in the east (blue) has made you an ultimatum to pay back your long-lasting dept. He threatens to set sanctions on all trades concerning military equipment in place.",
	"options": [{
		"text": "Start paying back some of your dept.",
		"consequences": {
			"diplomacy": 5,
			"money": -30,
		},
	}, {
		"text": "Increase military personnel on the boarder to the blue country.",
		"consequences": {
			"diplomacy": -20,
			"money": -5,
			"stability": -5,
			"military": 5,
		},
	}, {
		"text": "Ignore it.",
		"consequences": {
			"military": -15,
		},
	}],
}, {
	"gid": 3,
	"name": "A bird war",
	"prompt": "A bird told me that one of the neighboring countries may be planning a war against you. What are you going to do about it?",
	"options": [{
		"text": "Upgrade your army",
		"character": "general",
		"consequences": {
			"diplomacy": -15,
			"money": -30,
			"military": 20,
		},
	}, {
		"text": "Ignore this bird",
		"id": "ignore_bird",
		"consequences": {
			"stability": -15,
			"military": -25,
		},
	}],
}, {
	"gid": 4,
	"name": "Strategy leadership summit",
	"prompt": "Organize a big fancy event and invite all the neighboring leaders with their diplomats.",
	"options": [{
		"text": "of course",
		"id": "accept",
		"consequences": {
			"money": -5,
		},
	}, {
		"text": "Ignore",
		"consequences": {},
	}],
}, {
	"gid": 5,
	"name": "The big gains",
	"prompt": "Your investments in the infrastructure are starting to pay of.",
	"requirements": [{
		"gid": 0,
		"chosen_option_id": "infrastructure",
	}],
	"options": [{
		"text": "take it",
		"consequences": {
			"money": 5,
			"stability": 5,
		},
	}, {
		"text": "double down",
		"consequences": {
			"money": -5,
			"stability": 6,
		},
	}],
}, {
	"gid": 6,
	"name": "The bird was right",
	"prompt": "The war that THE bird predicted has hit you hard. You have lost many soldiers. And to make you feel even worse, the people have lost faith in you as well... Now, what do you want to do?",
	"requirements": [{
		"gid": 3,
		"chosen_option_id": "ignore_bird",
	}],
	"options": [{
		"text": "Rebuild your army",
		"consequences": {
			"military": 20,
			"money": -35,
		},
	}],
}, {
	"gid": 7,
	"name": "trade that agreement",
	"prompt": "Country in the South (red) proposes to make a trade agreement.",
	"options": [{
		"text": "Sign it now!",
		"consequences": {
			"stability": 5,
			"diplomacy": 5,
			"money": 1,
		},
	}, {
		"text": "renegotiate",
		"consequences": {
			"stability": -3,
			"diplomacy": -5,
			"money": -1,
		},
	}, {
		"text": "never!",
		"consequences": {
			"diplomacy": -5,
		},
	}],
}, {
	"gid": 8,
	"name": "Diplomatic achievements",
	"prompt": "Today is your strategic summit, and you meet with all your neighboring countries",
	"requirements": [{
		"gid": 4,
		"chosen_option_id": "accept",
		"min_stats": {
			"diplomacy": 60,
		},
	}],
	"options": [{
		"text": "Create a military alliance with a neighbor",
		"character": "general",
		"consequences": {
			"stability": -5,
			"diplomacy": -10,
			"military": 30,
		},
	}, {
		"text": "Open embassy in neighboring countries",
		"character": "diplomat",
		"consequences": {
			"diplomacy": 30,
			"money": -5,
		},
	}],
}]
