
ITEM.name = "Stimpak"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "A vial filled with medication."
ITEM.category = "Consumables"
ITEM.flag = "d"
ITEM.price = 20

ITEM.functions.Take = {
	icon = "icon16/heart.png",
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		-- client:SetHealth(math.min(client:Health() + 50, client:GetMaxHealth()))
		client:SetHealth(math.min((client:GetMaxHealth() * 1.5), client:GetMaxHealth()))
	end
}
