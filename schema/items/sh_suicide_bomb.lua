
ITEM.name = "Suicide Bomb"
ITEM.description = "A lethal explosive."
ITEM.price = 100
ITEM.model = "models/dav0r/tnt/tnt.mdl"
ITEM.flag = "W"
ITEM.category = "Weapons"

ITEM.functions.Detonate = {
	icon = "icon16/bomb.png",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetAction("Detonating...", 2)
		itemTable.bBeingUsed = true

		-- Freeze the player while injecting
		client:Freeze(true)

		client:EmitSound("weapons/slam/mine_mode.wav")

		timer.Simple(2, function()
			if (!IsValid(client)) then return end

			client:Freeze(false)

			local explodePos = client:GetPos()
			local explosion = EffectData()
			explosion:SetOrigin(explodePos)
			util.Effect("Explosion", explosion, true, true)

			-- Blast damage: 150 radius, 200 damage
			util.BlastDamage(client, client, explodePos, 200, 150)

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

