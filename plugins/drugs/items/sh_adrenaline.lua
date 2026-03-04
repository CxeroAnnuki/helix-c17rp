ITEM.name = "Adrenaline"
ITEM.description = "A hormone that, when injected, will give you a rush of stamina while increasing your strength."
ITEM.model = Model("models/props_c17/trappropeller_lever.mdl")
ITEM.flag = "D"
ITEM.class = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 25

ITEM.functions.Take = {
	sound = "ambient/machines/slicer3.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:RestoreStamina(100)
		
		client:GetCharacter():AddBoost("adrenStm", "agi", 20)
		client:GetCharacter():AddBoost("adrenStr", "str", 20)
		hook.Run("SetupDrugTimer", client, client:GetCharacter(), 120)
	end
}