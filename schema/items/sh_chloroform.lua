
ITEM.name = "Chloroform"
ITEM.description = "Used to put people to sleep."
ITEM.price = 60
ITEM.model = "models/props_junk/garbage_plasticbottle002a.mdl"
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
			target:EmitSound("ambient/levels/canals/toxic_slime_sizzle3.wav")
			target:Notify("Someone is trying to drug you!")
			itemTable.bBeingUsed = true

			client:DoStaredAction(target, function()
				if (IsValid(target)) then
					target:EmitSound("ambient/voices/citizen_beaten3.wav")
					target:SetRagdolled(true, 30)
					target:Notify("You have been drugged!")
					itemTable.bBeingUsed = false
				end

				-- client:Notify("You unlocked the door.")

				itemTable:Remove()
			end, 2, function()
				-- Cancelled / interrupted
				client:SetAction()
				target:EmitSound("ambient/levels/canals/drip4.wav")
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

function ITEM:CanTransfer(inventory, newInventory)
	return !self.bBeingUsed
end
