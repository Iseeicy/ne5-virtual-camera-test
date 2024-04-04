extends ColorRect

signal over_interactable_changed(bool)
signal on_interactable
signal off_interactable
var over_interactable: bool = true

func _ready():
	set_over_interactable(false)

	var player = PlayerController.find(get_tree().root)
	if not player.is_node_ready(): await player.ready
	player.interactor.is_hovering_changed.connect(set_over_interactable.bind())

func set_over_interactable(is_over_interactable: bool):
	if is_over_interactable == over_interactable: return

	over_interactable = is_over_interactable
	color.a = 1.0 if over_interactable else 0.2
	
	over_interactable_changed.emit(over_interactable)
	if over_interactable:
		on_interactable.emit()
	else:
		off_interactable.emit()
