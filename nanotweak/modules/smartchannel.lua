	--[[
		
		nanotweak
			smartchannel
				
			Automatically select bg/raid/party chat by typing /i
	]]--


	local lower = string.lower
	local match = string.match
	local IsInInstance = IsInInstance

	local function SetChannel(...)
		ChatFrameEditBox:Hide()

		local inInstance, instanceType = IsInInstance()

		if inInstance and instanceType == "pvp" then
			ChatFrameEditBox:SetAttribute("chatType", "BATTLEGROUND")
		elseif inInstance and instanceType == "arena" then
			ChatFrameEditBox:SetAttribute("chatType", "PARTY")
		elseif GetNumRaidMembers() > 0 then
			ChatFrameEditBox:SetAttribute("chatType", "RAID")
		elseif GetNumPartyMembers() > 0 then
			ChatFrameEditBox:SetAttribute("chatType", "PARTY")
		else
			ChatFrameEditBox:SetAttribute("chatType", "SAY")
		end

		ChatFrame_OpenChat("") 
	end

	hooksecurefunc("ChatEdit_OnSpacePressed", function()
		local text = lower(ChatFrameEditBox:GetText())
		if match(text, "^\/i $") then
			SetChannel()
		end
	end)