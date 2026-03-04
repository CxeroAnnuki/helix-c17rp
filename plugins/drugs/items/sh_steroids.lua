ITEM.name = "Steroids"
ITEM.description = "A synthetic hormone pill that increases your strength."
ITEM.model = Model("models/props_lab/jar01a.mdl")
ITEM.flag = "D"
ITEM.class = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 25

ITEM.functions.Take = {
	sound = "npc/barnacle/barnacle_gulp1.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		
		client:GetCharacter():AddBoost("adrenStr", "str", 20)
		client:GetCharacter():AddBoost("adrenEnd", "end", 20)
		hook.Run("SetupDrugTimer", client, client:GetCharacter(), 240)
	end
}