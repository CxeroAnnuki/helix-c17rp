
ITEM.name = "Battering Ram"
ITEM.description = "A pneumatic combine battering ram for breaching doors. (Strength 15 Required)"
ITEM.price = 60
ITEM.model = "models/props_combine/combine_emitter01.mdl"
ITEM.width = 3
ITEM.height = 1
ITEM.flag = "V"
ITEM.category = "Tools"
ITEM.functions.Use = {
	icon = "icon16/door_open.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		local requiredStrength = 15
		local strength = character:GetAttribute("str", 0)

		if (strength < requiredStrength) then
			client:Notify("You are not strong enough to use this.")
			return false
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 128
			data.filter = client

		local target = util.TraceLine(data).Entity

		if IsValid(target)
			and (target:GetClass() == "prop_door_rotating" or target:GetClass() == "func_door_rotating")
			and target:GetSaveTable().m_bLocked then

			client:SetAction("Breaching...", 2)
			target:EmitSound("buttons/lever7.wav")
			itemTable.bBeingUsed = true

			client:DoStaredAction(target, function()
				if (IsValid(target)) then
					target:EmitSound("physics/wood/wood_crate_break4.wav")
					target:Fire("Unlock")
					target:Fire("Open")
					itemTable.bBeingUsed = false
				end

				client:Notify("You unlocked the door.")
			end, 2, function()
				-- Cancelled / interrupted
				client:SetAction()
				itemTable.bBeingUsed = false
				target:EmitSound("buttons/lever8.wav")
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
