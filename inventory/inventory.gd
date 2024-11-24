extends Resource

class_name Inv

signal update

@export var slots : Array[Inventory_Slot]

func insert(item : InvItem):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amt += 1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		empty_slots[0].item = item
		empty_slots[0].amt = 1
	update.emit()
 
func substract(item : InvItem, n):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	if !itemslots.is_empty():
		if itemslots[0].amt > 0:
			itemslots[0].amt -= n
			if itemslots[0].amt < 0:
				itemslots[0].amt = 0
	update.emit()
	
func exists(item : InvItem):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	if !itemslots.is_empty():
		return itemslots[0].amt > 0
