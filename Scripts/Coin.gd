extends Area3D

# get access to the 'AnimatedSprite3D' and 'CollisionShape3D'
@onready var AnimSprite = $AnimatedSprite3D
@onready var CollShape = $CollisionShape3D

# create a variable to set the coin type in the editor
@export var CoinType := "ONE"

# variables to set the value and animation of the coins
var CoinValue
var CoinAnim

func _ready():
	match CoinType:
		"ONE":
			CoinValue = 1; CoinAnim = "ONE"
			CollShape.shape.radius = 0.105
		
		"FIVE":
			CoinValue = 5; CoinAnim = "FIVE"
			CollShape.shape.radius = 0.115
		
		"TEN":
			CoinValue = 10; CoinAnim = "TEN"
			CollShape.shape.radius = 0.125
		
		"FIFTY":
			CoinValue = 50; CoinAnim = "FIFTY"
			CollShape.shape.radius = 0.150
		
		"HUNDRED":
			CoinValue = 100; CoinAnim = "HUNDRED"
			CollShape.shape.radius = 0.175
	
	AnimSprite.play()
