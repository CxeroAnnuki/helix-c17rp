local playerMeta = FindMetaTable("Player")

function playerMeta:IsCombine()
	local faction = self:Team()
	return faction == FACTION_MPF or faction == FACTION_OTA or faction == FACTION_ADMIN
end

function playerMeta:IsVortigaunt()
	local faction = self:Team()
	return faction == FACTION_VORTIGAUNT or faction == FACTION_ENSLAVEDVORTIGAUNT
end