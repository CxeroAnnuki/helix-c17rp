
ITEM.name = "Poison"
ITEM.description = "A jug filled with a lethal substance."
ITEM.price = 60
ITEM.model = "models/props_junk/glassjug01.mdl"
ITEM.flag = "D"
ITEM.category = "Consumables"

ITEM.functions.Apply = {
	icon = "icon16/pill_add.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
			client:SetAction("Drugging...", 2)
			target:EmitSound("weapons/knife/knife_deploy1.wav")
			target:Notify("Someone is trying to drug you!")
			itemTable.bBeingUsed = true

			client:DoStaredAction(target, function()
				if (IsValid(target)) then
					target:EmitSound("ambient/machines/slicer3.wav")
					target:Kill()
				end

				itemTable.bBeingUsed = false
				itemTable:Remove()
			end, 2, function()
				client:SetAction()
				target:EmitSound("foley/alyx_sit_on_couch.wav")
				itemTable.bBeingUsed = false
			end)
		else
			client:Notify("This can only be used on a conscious player.")
		end

		return false
	end,

	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity) and !itemTable.bBeingUsed
	end
}

ITEM.functions.Take = {
	icon = "icon16/pill.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetAction("Taking poison...", 2)
		itemTable.bBeingUsed = true

		client:EmitSound("ambient/levels/canals/toxic_slime_sizzle3.wav")
		client:Freeze(true)

		timer.Simple(2, function()
			if (!IsValid(client)) then return end

			client:Freeze(false)

			client:EmitSound("ambient/voices/citizen_beaten3.wav")
			client:Kill()
			itemTable.bBeingUsed = false
			itemTable:Remove()
		end)
		
		return false
	end,

	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity) and !itemTable.bBeingUsed
	end
}

