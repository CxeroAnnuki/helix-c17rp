
FACTION.name = "Citizen"
FACTION.description = "A regular human citizen enslaved by the Universal Union."
FACTION.color = Color(150, 125, 100, 255)
FACTION.pay = 1
FACTION.isDefault = true
FACTION.models = {
	"models/humans/group01/female_01.mdl",
	"models/humans/group01/female_02.mdl",
	"models/humans/group01/female_03.mdl",
	"models/humans/group01/female_04.mdl",
	"models/humans/group01/female_06.mdl",
	"models/humans/group01/female_07.mdl",
	"models/humans/group01/male_01.mdl",
	"models/humans/group01/male_02.mdl",
	"models/humans/group01/male_03.mdl",
	"models/humans/group01/male_04.mdl",
	"models/humans/group01/male_05.mdl",
	"models/humans/group01/male_06.mdl",
	"models/humans/group01/male_07.mdl",
	"models/humans/group01/male_08.mdl",
	"models/humans/group01/male_09.mdl"
}

//function FACTION:OnCharacterCreated(client, character)
//	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
//	local inventory = character:GetInventory()
//
//	character:SetData("cid", id)
//
//	inventory:Add("suitcase", 1)
//	inventory:Add("cid", 1, {
//		name = character:GetName(),
//		id = id
//	})
//end

FACTION_CITIZEN = FACTION.index
