	--[[

		nanotweak
			slash

		Add a few slash commands for convenience
		
	]]--

	local format = string.format
	local tonumber = tonumber
	local print = function(msg) DEFAULT_CHAT_FRAME:AddMessage("|cffa0f6aananotweak|r: "..msg) end

	SlashCmdList.RELOADUI = ReloadUI
	SLASH_RELOADUI1 = "/reloadui"
	SLASH_RELOADUI2 = "/rl"

	SlashCmdList.READYCHECK = DoReadyCheck
	SLASH_READYCHECK1 = "/rc"

	SlashCmdList.TICKET = ToggleHelpFrame
	SLASH_TICKET1 = "/gm"

	SlashCmdList.LEAVEGROUP = LeaveParty
	SLASH_LEAVEGROUP1 = "/lg"
	SLASH_LEAVEGROUP1 = "/lp"

	SlashCmdList.CLEAR = function() SELECTED_CHAT_FRAME:Clear() end
	SLASH_CLEAR1 = "/clear"
	SLASH_CLEAR2 = "/cls"

	SlashCmdList.TOGGLEHELM = function() ShowHelm(ShowingHelm() ~= 1) end
	SLASH_TOGGLEHELM1 = "/helm"

	SlashCmdList.TOGGLECLOAK = function() ShowCloak(ShowingCloak() ~= 1) end
	SLASH_TOGGLECLOAK1 = "/cloak"

	SlashCmdList.SHOWFPS = ToggleFramerate
	SLASH_SHOWFPS1 = "/fps"

	SlashCmdList.CLEARBARS = function() for i = 1, 120 do PickupAction(i) ClearCursor() end end
	SLASH_CLEARBARS1 = "/clearactionbars"
	SLASH_CLEARBARS1 = "/clearbars"

	SlashCmdList.CLEARQUESTS = function() for i = 1, GetNumQuestLogEntries() do SelectQuestLogEntry(i); SetAbandonQuest(); AbandonQuest() end end
	SLASH_CLEARQUESTS1 = "/clearquests"

	SlashCmdList.VOLUME = function(val)
		local new = tonumber(val)
		local old = tonumber(GetCVar("Sound_MasterVolume"))
		if new == old then 
			print(format("Volume is already set to |cffa0f6aa%s|r.", old))
		elseif new and 0 <= new and new <= 1 then
			SetCVar("Sound_MasterVolume", new)
			print(format("Volume is now set to |cffa0f6aa%.2f|r, was |cffa0f6aa%.2f|r.", new, old))
		else
			print(format("Volume is currently set to |cffa0f6aa%.2f|r.", old))
		end
	end
	SLASH_VOLUME1 = "/vol"
	SLASH_VOLUME2 = "/volume"

	SlashCmdList.MAXFPS = function(val)
		local new = tonumber(val)
		local old = tonumber(GetCVar("maxFPS"))
		if new == old then 
			print(format("Max FPS is already set to |cffa0f6aa%s|r.", old))
		elseif new and new >= 0 then
			SetCVar("maxFPS", new)
			print(format("Max FPS is now set to |cffa0f6aa%s|r, was |cffa0f6aa%s|r.", new, old))
		else
			print(format("Max FPS is currently set to |cffa0f6aa%s|r.", old))
		end
	end
	SLASH_MAXFPS1 = "/maxfps"
	SLASH_MAXFPS2 = "/fpsmax"

	SlashCmdList.CAMERA = function(val)
		local new = tonumber(val)
		local old = tonumber(GetCVar("cameraDistanceMax"))
		if new == old then 
			print(format("Camera distance is already set to |cffa0f6aa%s|r.", old))
		elseif new and 0 <= new and new <= 50 then
			SetCVar("cameraDistanceMax", new)
			print(format("Camera distance is now set to |cffa0f6aa%d|r, was |cffa0f6aa%d|r.", new, old))
		else
			print(format("Camera distance is currently set to |cffa0f6aa%d|r.", old))
		end
	end
	SLASH_CAMERA1 = "/camera"
	SLASH_CAMERA2 = "/cameradistance"