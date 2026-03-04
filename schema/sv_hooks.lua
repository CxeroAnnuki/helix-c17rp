
-- Here is where all of your serverside hooks should go.

-- Enables Flashlight use
function Schema:PlayerSwitchFlashlight(client, enabled)
	return true
end

-- entity data loading
function Schema:LoadData()
	self:LoadCombineLocks()
	self:LoadForceFields()
end

-- entity data saving
function Schema:SaveData()
	self:SaveCombineLocks()
	self:SaveForceFields()
end

-- Player cannot change classes while resticted (zip tied or whatever)
function Schema:CanPlayerJoinClass(client, class, info)
	if (client:IsRestricted()) then
		client:Notify("You cannot change classes when you are restrained!")

		return false
	end
end

-- Player cannot spawn objects while restricted?
function Schema:PlayerSpawnObject(client)
	if (client:IsRestricted()) then
		return false
	end
end

-- allows untying restricted players and for combine to lock/unlock combine doors
function Schema:PlayerUse(client, entity)
	if (IsValid(client.ixScanner)) then
		return false
	end

	if ((client:IsCombine() or client:Team() == FACTION_ADMIN) and entity:IsDoor() and IsValid(entity.ixLock) and client:KeyDown(IN_SPEED)) then
		entity.ixLock:Toggle(client)
		return false
	end

	if (!client:IsRestricted() and entity:IsPlayer() and entity:IsRestricted() and !entity:GetNetVar("untying")) then
		entity:SetAction("@beingUntied", 5)
		entity:SetNetVar("untying", true)

		client:SetAction("@unTying", 5)

		client:DoStaredAction(entity, function()
			entity:SetRestricted(false)
			entity:SetNetVar("untying")
		end, 5, function()
			if (IsValid(entity)) then
				entity:SetNetVar("untying")
				entity:SetAction()
			end

			if (IsValid(client)) then
				client:SetAction()
			end
		end)
	end
end

-- allow combine players to open combine doors
function Schema:PlayerUseDoor(client, door)
	if (client:IsCombine()) then
		if (!door:HasSpawnFlags(256) and !door:HasSpawnFlags(1024)) then
			door:Fire("open")
		end
	end
end

--Player cannot use sprays
function Schema:PlayerSpray(client)
	return true
end

-- prevents vorts from equipping weapons
hook.Add("CanPlayerEquipItem", "NoWeaponsForVorts", function(client, item)
	local char = client:GetCharacter()

	if (char and char:IsVortigaunt() and item.isWeapon) then
		client:Notify("Vortigaunts cannot use weapons.")
		return false
	end

	if (char and char:IsVortigaunt() and item.base == "base_houtfit") then
		client:Notify("Vortigaunts cannot wear armor.")
		return false
	end
end)