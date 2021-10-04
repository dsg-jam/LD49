const RAW := [{
	"gid": 2,
	"name": "Inflation",
	"description": "An inflation hit your economy",
	"consequences": {
		"money": -25,
	},
}, {
	"gid": 11,
	"name": "Earthquake event",
	"description": "As expected, the earthquake has shaken your country, actually only the northeast, but fortunately you warned the population in time and people could be brought to shelter!",
	"requirements": [{
		"gid": 10,
		"chosen_option_id": "yes",
	}],
	"consequences": {
		"stability": 15,
	}
}, {
	"gid": 12,
	"name": "Earthquake event, your bad",
	"description": "As expected, the earthquake has shaken your country, actually only the northeast. Unfortunately, you did not warn the population and people perished in the disaster.",
	"requirements": [{
		"gid": 10,
		"chosen_option_id": "no",
	}],
	"consequences": {
		"stability": -20,
		"diplomacy": -10,
	}
}, {
	"gid": 13,
	"name": "Climate strike",
	"description": "Strikes went on for two days because you ignored the climate demo.",
	"requirements": [{
		"gid": 9,
		"chosen_option_id": "idc",
	}],
	"consequences": {
		"stability": -20,
	}
}, {
	"gid": 14,
	"name": "Climate crisis",
	"description": "Since you expelled the protesters, many people have lost confidence in you (as if they ever had any). Well, now you have to see how you can fix it.",
	"requirements": [{
		"gid": 9,
		"chosen_option_id": "expel",
	}],
	"consequences": {
		"stability": -30,
		"military": -5,
	}
}, {
	"gid": 15,
	"name": "Climate policy",
	"description": "The planned climate policy has been implemented, the population seems to be calming down in this respect.",
	"requirements": [{
		"gid": 9,
		"chosen_option_id": "policy",
	}],
	"consequences": {
		"stability": 15,
		"money": -5,
		"diplomacy": -2,
	}
}, {
	"gid": 17,
	"name": "Money, money, money",
	"description": "An anonymous organization donates some money to your country, for public reasons.",
	"requirements": [{
		"min_stats": {
			"money": 10,
		},
	}],
	"consequences": {
		"money": 35,
	}
}, {
	"gid": 18,
	"name": "Payday",
	"description": "The investment in infrastructure has really paid off, enjoy your success.",
	"requirements": [{
		"gid": 5,
		"chosen_option_id": "dd",
	}],
	"consequences": {
		"stability": 4,
		"money": 10,
	}
}, {
	"gid": 19,
	"name": "Airport dilemma",
	"description": "Since you didn't want to build an airport, all passengers now travel to the blue country to catch a flight.",
	"requirements": [{
		"gid": 16,
		"chosen_option_id": "no",
	}],
	"consequences": {
		"money": -2,
		"diplomacy": 1,
	}
}, {
	"gid": 20,
	"name": "Airport success",
	"description": "Due to the construction of the airport and the great popularity of it, the airport became a large hub. Furthermore, the country became an interesting destination for many foreign tourists.",
	"requirements": [{
		"gid": 16,
		"chosen_option_id": "yes",
	}],
	"consequences": {
		"stability": 4,
		"money": 10,
		"diplomacy": 1,
	}
}]
