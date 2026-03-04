
ITEM.name = "EMP Tool"
ITEM.description = "Electronic tool for manipulating electronics."
ITEM.price = 300
ITEM.model = "models/props_combine/breenlight.mdl"
ITEM.flag = V
ITEM.category = "Tools"
ITEM.functions.Open = {
	icon = "icon16/lightning.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

		local target = util.TraceLine(data).Entity

		if IsValid(target)
			and (target:GetClass() == "func_door") then

			client:SetAction("Overloading...", 2)
			target:EmitSound("ambient/energy/weld1.wav")
			itemTable.bBeingUsed = true

			client:DoStaredAction(target, function()
				if (IsValid(target)) then
					target:EmitSound("ambient/energy/zap9.wav")
					target:Fire("Unlock")
					target:Fire("Open")
					itemTable.bBeingUsed = false
				end

				client:Notify("You opened the door.")
			end, 2, function()
				-- Cancelled / interrupted
				client:SetAction()
				itemTable.bBeingUsed = false
				target:EmitSound("ambient/energy/newspark09.wav")
			end)
		else
			client:Notify("This can only be used on locked sliding doors.")
		end

		return false
	end,

	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity) and !itemTable.bBeingUsed
	end
}

ITEM.functions.Overload = {
	icon = "icon16/lightning.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local traceData = {}
			traceData.start = client:GetShootPos()
			traceData.endpos = traceData.start + client:GetAimVector() * 96
			traceData.filter = client

		local target = util.TraceLine(traceData).Entity

		if IsValid(target) and target:GetClass() == "ix_forcefield" then
			if target.ixEmpDisabled then
				client:Notify("This forcefield is already powered down.")
				return false
			end

			client:SetAction("Overloading forcefield...", 2)
			target:EmitSound("ambient/energy/weld1.wav")
			itemTable.bBeingUsed = true

			client:DoStaredAction(target, function()
				if not IsValid(target) then return end

				-- Save state
				target.ixEmpDisabled = true
				target.ixOldMode = target:GetMode()

				-- Disable field
				target:SetMode(1) -- MODE_ALLOW_ALL
				target:SetSkin(1)
				if IsValid(target:GetDummy()) then
					target:GetDummy():SetSkin(1)
				end

				target:EmitSound("ambient/energy/zap9.wav")
				client:Notify("Forcefield powered down.")

				-- Restore after delay
				timer.Simple(10, function()
					if IsValid(target) then
						target:SetMode(target.ixOldMode or 3)
						target:SetSkin(0)

						if IsValid(target:GetDummy()) then
							target:GetDummy():SetSkin(0)
						end

						target.ixEmpDisabled = nil
						target.ixOldMode = nil
						target:EmitSound("ambient/machines/combine_terminal_idle4.wav")
					end
				end)

				itemTable.bBeingUsed = false
			end, 2, function()
				-- Cancelled
				client:SetAction()
				itemTable.bBeingUsed = false

				if IsValid(target) then
					target:EmitSound("ambient/energy/newspark09.wav")
				end
			end)
		else
			client:Notify("This can only be used on Combine forcefields.")
		end

		return false
	end,

	OnCanRun = function(itemTable)
		return not IsValid(itemTable.entity) and not itemTable.bBeingUsed
	end
}


function ITEM:CanTransfer(inventory, newInventory)
	return !self.bBeingUsed
end
