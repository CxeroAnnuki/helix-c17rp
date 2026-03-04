
-- The shared init file. You'll want to fill out the info for your schema and include any other files that you need.

-- Schema info
Schema.name = "City 17 Roleplay"
Schema.author = "Cxero"
Schema.description = "A grim roleplay set during the Combine occupation of Earth.."

-- Additional files that aren't auto-included should be included here. Note that ix.util.Include will take care of properly
-- using AddCSLuaFile, given that your files have the proper naming scheme.

-- You could technically put most of your schema code into a couple of files, but that makes your code a lot harder to manage -
-- especially once your project grows in size. The standard convention is to have your miscellaneous functions that don't belong
-- in a library reside in your cl/sh/sv_schema.lua files. Your gamemode hooks should reside in cl/sh/sv_hooks.lua. Logical
-- groupings of functions should be put into their own libraries in the libs/ folder. Everything in the libs/ folder is loaded
-- automatically.

-- Include netstream
ix.util.Include("libs/thirdparty/sh_netstream2.lua")

ix.util.Include("sh_configs.lua")
ix.util.Include("sh_commands.lua")

ix.util.Include("cl_schema.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_schema.lua")
ix.util.Include("sv_hooks.lua")

-- You'll need to manually include files in the meta/ folder, however.
ix.util.Include("meta/sh_player.lua")
ix.util.Include("meta/sh_character.lua")

ix.flag.Add("v", "Ability to biz vendor goods.")
ix.flag.Add("V", "Ability to biz black market goods.")
ix.flag.Add("d", "Ability to biz drugs.")
ix.flag.Add("D", "Ability to biz illegal drugs.")
ix.flag.Add("w", "Ability to biz weapons.")
ix.flag.Add("W", "Ability to biz advanced weapons.")
ix.flag.Add("g", "Ability to biz police uniforms.")
ix.flag.Add("G", "Ability to biz military uniforms.")
ix.flag.Add("r", "Ability to biz resistance uniforms.")

-- animation fixes
ix.anim.SetModelClass("models/elitepolice.mdl", "metrocop")

function Schema:ZeroNumber(number, length)
	local amount = math.max(0, length - string.len(number))
	return string.rep("0", amount)..tostring(number)
end

do
	local CLASS = {}
	CLASS.color = Color(75, 150, 50)
	CLASS.format = "%s radios in \"%s\""

	function CLASS:CanHear(speaker, listener)
		local character = listener:GetCharacter()
		local inventory = character:GetInventory()
		local bHasRadio = false

		for k, v in pairs(inventory:GetItemsByUniqueID("handheld_radio", true)) do
			if (v:GetData("enabled", false) and speaker:GetCharacter():GetData("frequency") == character:GetData("frequency")) then
				bHasRadio = true
				break
			end
		end

		return bHasRadio
	end

--	function CLASS:OnChatAdd(speaker, text)
--		text = speaker:IsCombine() and string.format("<:: %s ::>", text) or text
--		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
--	end

	ix.chat.Register("radio", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(255, 255, 175)
	CLASS.format = "%s radios in \"%s\""

	function CLASS:GetColor(speaker, text)
		if (LocalPlayer():GetEyeTrace().Entity == speaker) then
			return Color(175, 255, 175)
		end

		return self.color
	end

	function CLASS:CanHear(speaker, listener)
		if (ix.chat.classes.radio:CanHear(speaker, listener)) then
			return false
		end

		local chatRange = ix.config.Get("chatRange", 280)

		return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
	end

	function CLASS:OnChatAdd(speaker, text)
		text = speaker:IsPolice() and string.format("<:: %s ::>", text) or text
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("radio_eavesdrop", CLASS)
end

-- administrator broadcast stuff
do
	local CLASS = {}
	CLASS.color = Color(150, 125, 175)
	CLASS.format = "%s broadcasts \"%s\""

	function CLASS:CanSay(speaker, text)
		if (speaker:Team() != FACTION_ADMIN) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("broadcast", CLASS)
end

-- vortessense stuff
do
	local CLASS = {}
	CLASS.color = Color(175, 125, 100)
	CLASS.format = "%s says through Vortessense, \"%s\""

	function CLASS:CanHear(speaker, listener)
		return listener:IsVortigaunt()
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("vortessense", CLASS)
end
