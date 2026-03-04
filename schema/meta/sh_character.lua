
local CHAR = ix.meta.character

function CHAR:IsCombine()
	local faction = self:GetFaction()
	return faction == FACTION_MPF or faction == FACTION_OTA or faction == FACTION_ADMIN
end

function CHAR:IsVortigaunt()
	local faction = self:GetFaction()
	return faction == FACTION_VORTIGAUNT or faction == FACTION_ENSLAVEDVORTIGAUNT
end
