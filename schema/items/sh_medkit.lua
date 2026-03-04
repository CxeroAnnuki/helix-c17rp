
ITEM.name = "Medical Kit"
ITEM.model = Model("models/items/healthkit.mdl")
ITEM.description = "A white box filled with medical supplies."
ITEM.category = "Consumables"
ITEM.flag = "d"
ITEM.price = 35
ITEM.width = 2
ITEM.height = 2

ITEM.functions.Take = {
	icon = "icon16/heart.png",
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(client:GetMaxHealth())
	end
}
