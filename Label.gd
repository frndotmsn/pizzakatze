extends Label

func _ready():
	neuePizzabeschreibung()

# Called when the node enters the scene tree for the first time.
func neuePizzabeschreibung():
	#rund
	#Tomensauce Pesto
	#Käse
	#Teig
	#Basilikum Salami Ananas Oliven Schinken Parmesan Rucola
	var belag = gibBelag(randi_range(0, 6))
	var sose = gibSose(randi_range(0, 1))
	var textFormat = "Belag: %s,  Sose: %s"
	text = textFormat % [belag, sose]
	pass # Replace with function body.

# Gibt ein Belag zur belagNummer
func gibBelag(belagNummer):
	if belagNummer == 0:
		return "Basilikum"
	elif  belagNummer == 1:
		return "Salami"
	elif belagNummer == 2:
		return "Ananas"
	elif belagNummer == 3:
		return "Oliven"
	elif belagNummer == 4:
		return "Schinken"
	elif belagNummer == 5:
		return  "Parmesan"
	elif belagNummer == 6:
		return "Rucola"
	else:
		return "Scheiß Pizza"

# Gibt die Sose zur Sosennummer
func gibSose(sosenNummer):
	if sosenNummer == 0:
		return "Pesto"
	elif sosenNummer == 1:
		return "Tomatensose"
	else:
		return "Scheiß Pizza"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
