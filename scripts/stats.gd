var name: String
var value: int


func _init(name: String, value: int = 100):
	self.name = name
	self.value = value


func change_value(amount: int):
	self.value += amount
	if self.value > 100:
		self.value = 100
	elif self.value < 0:
		self.value = 0
