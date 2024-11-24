extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text : Label = $CenterContainer/Panel/Label

func update(slot : Inventory_Slot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		if slot.amt > 0:
			item_visual.visible = true
			item_visual.texture = slot.item.texture
			amount_text.visible = true
			amount_text.text = str(slot.amt)
		else :
			item_visual.visible = false
			amount_text.visible = false
			slot.item = null
