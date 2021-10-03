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
	"name": "military at the blue boarder",
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
}]
