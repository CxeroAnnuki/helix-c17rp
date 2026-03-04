
ITEM.name = "Lockpick"
ITEM.description = "A small one-time use pick made for opening locked doors."
ITEM.price = 20
ITEM.model = "models/gibs/metal_gib5.mdl"
ITEM.flag = "V"
ITEM.category = "Tools"
ITEM.functions.Use = {
	icon = "icon16/lock_open.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

		local target = util.TraceLine(data).Entity

--		if (IsValid(target) and target:IsDoor()) then
		if IsValid(target)
			and (target:GetClass() == "prop_door_rotating" or target:GetClass() == "func_door_rotating")
			and target:GetSaveTable().m_bLocked then

			client:SetAction("Lockpicking...", 5)
			target:EmitSound("weapons/357/357_reload1.wav")
			itemTable.bBeingUsed = true

			client:DoStaredAction(target, function()
				if (IsValid(target)) then
					target:EmitSound("weapons/357/357_spin1.wav")
					target:Fire("Unlock")
					target:Fire("Open")
					itemTable.bBeingUsed = false
				end

				client:Notify("You unlocked the door.")

				itemTable:Remove()
			end, 5, function()
				-- Cancelled / interrupted
				client:SetAction()
				itemTable.bBeingUsed = false
				target:EmitSound("weapons/357/357_reload4.wav")
			end)
		else
			client:Notify("This can only be used on locked rotating doors.")
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
