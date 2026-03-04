ITEM.name = "Painkillers"
ITEM.description = "A drug to dull the pain, increasing your endurance."
ITEM.model = Model("models/thrusters/jetpack.mdl")
ITEM.flag = "D"
ITEM.class = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 25

ITEM.functions.Take = {
	sound = "npc/barnacle/barnacle_gulp1.wav",
	OnRun = function(itemTable)
		local client = itemTable.player
		
		client:GetCharacter():AddBoost("painEnd", "end", 20)
		hook.Run("SetupDrugTimer", client, client:GetCharacter(), 240)
	end
}