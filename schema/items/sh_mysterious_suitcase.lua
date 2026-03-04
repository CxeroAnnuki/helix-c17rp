
ITEM.name = "Mysterious Suitcase"
ITEM.model = Model("models/props_c17/suitcase_passenger_physics.mdl")
ITEM.description = "We've got places to do and things to be."
ITEM.noBusiness = true

ITEM.functions.DoorUnlock = {
	name = "Door: Unlock",
	icon = "icon16/door_open.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local traceData = {}
		traceData.start = client:GetShootPos()
		traceData.endpos = traceData.start + client:GetAimVector() * 96
		traceData.filter = client

		local target = util.TraceLine(traceData).Entity

		if (IsValid(target) and target:IsDoor()) then
			target:Fire("Unlock")
			target:Fire("Open")

			client:Notify("You unlocked the door.")
		else
			client:Notify("That is not a door.")
		end

		return false
	end,
}

ITEM.functions.DoorLock = {
	name = "Door: Lock",
	icon = "icon16/door.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local traceData = {}
		traceData.start = client:GetShootPos()
		traceData.endpos = traceData.start + client:GetAimVector() * 96
		traceData.filter = client

		local target = util.TraceLine(traceData).Entity

		if (IsValid(target) and target:IsDoor()) then
			target:Fire("Lock")
			target:Fire("Close")

			client:Notify("You locked the door.")
		else
			client:Notify("That is not a door.")
		end

		return false
	end,
}

ITEM.functions.PlayerSleep = {
	name = "Player: Sleep",
	icon = "icon16/status_away.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local traceData = {}
		traceData.start = client:GetShootPos()
		traceData.endpos = traceData.start + client:GetAimVector() * 96
		traceData.filter = client

		local target = util.TraceLine(traceData).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
			target:EmitSound("ambient/alarms/warningbell1.wav")
			target:SetRagdolled(true, 30)
		else
			client:Notify("This can only be used on a conscious player.")
		end

		return false
	end,
}

ITEM.functions.PlayerKill = {
	name = "Player: Kill",
	icon = "icon16/cross.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local traceData = {}
		traceData.start = client:GetShootPos()
		traceData.endpos = traceData.start + client:GetAimVector() * 96
		traceData.filter = client

		local target = util.TraceLine(traceData).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
			target:EmitSound("ambient/levels/citadel/portal_beam_shoot5.wav")
			target:Kill()
		else
			client:Notify("This can only be used on a conscious player.")
		end

		return false
	end,
}

ITEM.functions.PlayerHeal = {
	name = "Player: Heal",
	icon = "icon16/heart_add.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		local traceData = {}
		traceData.start = client:GetShootPos()
		traceData.endpos = traceData.start + client:GetAimVector() * 96
		traceData.filter = client

		local target = util.TraceLine(traceData).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
			target:EmitSound("npc/vort/health_charge.wav")
			client:SetHealth(client:GetMaxHealth())
		else
			client:Notify("This can only be used on a conscious player.")
		end

		return false
	end,
}

ITEM.functions.SelfHeal = {
	name = "Self: Heal",
	icon = "icon16/heart.png",
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(client:GetMaxHealth())

		return false
	end
}
