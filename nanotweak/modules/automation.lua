	--[[

		nanotweak
			automation

			Automatically:
				- vendor grey items
				- repair gear
				- queue for bg when talking to battlemaster
				- dismount at flightmaster
				- release spirit in BGs
				- open/close bags when at vendor, ah, etc.
				- accept invite from friends/guild

	]]--

---------------------------------------------------------------------------------------------
	
	-- config

	local selltrash = true
	local repair = true
	local guildrepair = false
	local release = true
	local flightmaster = true
	local joinqueue = true
	local openbags = true
	local closebags = true
	local friendinv = true
	local guildinv = true

---------------------------------------------------------------------------------------------
	
	local select, format = select, string.format
	local GetFriendInfo = GetFriendInfo
	local GetItemInfo, GetNumFriends, IsShiftKeyDown, ConfirmLootSlot, UseContainerItem
		= GetItemInfo, GetNumFriends, IsShiftKeyDown, ConfirmLootSlot, UseContainerItem
	local GetContainerNumSlots, GetContainerItemLink, GetNumGuildMembers, GetGuildRosterInfo
		= GetContainerNumSlots, GetContainerItemLink, GetNumGuildMembers, GetGuildRosterInfo

---------------------------------------------------------------------------------------------

	local myclass = select(2, UnitClass("player"))
	local f = CreateFrame("Frame")

	local print = function(msg) DEFAULT_CHAT_FRAME:AddMessage("|cffa0f6aananotweak|r: "..msg) end

---------------------------------------------------------------------------------------------

	function f:MERCHANT_SHOW()
		if IsShiftKeyDown() then return end

		if selltrash then
			for bag = 0, 4 do
				for slot = 0, GetContainerNumSlots(bag) do
					local link = GetContainerItemLink(bag, slot)
					if link and select(3, GetItemInfo(link)) == 0 then
						print(format("Selling: %s.", link))
						UseContainerItem(bag, slot)
					end
				end
			end
		end

		if repair and CanMerchantRepair() then
			local cost = GetRepairAllCost()
			if cost > 0 then
				if guildrepair and IsInGuild() then
					if GetGuildBankMoney() >= cost then
						local limit = GetGuildBankWithdrawMoney()
						if limit >= cost or limit == -1 then
							RepairAllItems(1)
						end
					end	
				end

				if GetMoney() > cost then
					RepairAllItems()
				end
			end
		end
	end

---------------------------------------------------------------------------------------------

	function f:BATTLEFIELDS_SHOW()
		if not IsShiftKeyDown() then 
			if IsPartyLeader() or IsRaidLeader() then
				JoinBattlefield(0, 1)
			else
				JoinBattlefield(0)
			end
			HideUIPanel(BattlefieldFrame)
		end
	end

---------------------------------------------------------------------------------------------

	function f:PLAYER_DEAD()
		if MiniMapBattlefieldFrame.status == "active" then
			RepopMe()
		end
	end

---------------------------------------------------------------------------------------------

	function f:TAXIMAP_OPENED()
		if IsMounted() then
			Dismount()
		elseif myclass == "DRUID" then
			for i = 1, GetNumShapeshiftForms() do
				local _, name, active = GetShapeshiftFormInfo(i)
				if active then
					CancelPlayerBuff(name)
					return
				end
			end
		elseif myclass == "SHAMAN" then
			CancelPlayerBuff("Ghost Wolf")
		end
	end

---------------------------------------------------------------------------------------------

	function f:PARTY_INVITE_REQUEST(name)
		if friendinv then
			for i = 1, GetNumFriends() do
				if name == GetFriendInfo(i) then
					AcceptGroup()
					StaticPopup_Hide("PARTY_INVITE")
					return
				end
			end
		end

		if guildinv then
			for i = 1, GetNumGuildMembers() do
				if name == GetGuildRosterInfo(i) then
					AcceptGroup()
					StaticPopup_Hide("PARTY_INVITE")
					return
				end
			end
		end
	end

---------------------------------------------------------------------------------------------

	f:SetScript("OnEvent", function(self, event, ...)
		if self[event] then self[event](self, ...) end
	end)

	if selltrash or repair then
		f:RegisterEvent("MERCHANT_SHOW")
	end

	if joinqueue then
		f:RegisterEvent("BATTLEFIELDS_SHOW")
	end

	if release then
		f:RegisterEvent("PLAYER_DEAD")
	end

	if flightmaster then
		f:RegisterEvent("TAXIMAP_OPENED")
	end

	if friendinv or guildinv then
		f:RegisterEvent("PARTY_INVITE_REQUEST")
	end

---------------------------------------------------------------------------------------------

	if openbags then

		local open = {
			"MAIL_SHOW",
			"TRADE_SHOW",
			"MERCHANT_SHOW",
			"BANKFRAME_OPENED",
			"TRADE_SKILL_SHOW",
			"AUCTION_HOUSE_SHOW",
			"GUILDBANKFRAME_OPENED"
		}

		local a = CreateFrame("Frame")

		a:SetScript("OnEvent", function() 
			if ElvUI or NanoUI then
				OpenBackpack()
			else
				OpenAllBags()
			end
		end)

		for i, v in pairs(open) do
			a:RegisterEvent(v)
		end

	end

	if closebags then

		local close = {
			"MAIL_CLOSED",
			"TRADE_CLOSED",
			"MERCHANT_CLOSED",
			"BANKFRAME_CLOSED",
			"TRADE_SKILL_CLOSE",
			"AUCTION_HOUSE_CLOSED",
			"GUILDBANKFRAME_CLOSED"
		}

		local b = CreateFrame("Frame")

		b:SetScript("OnEvent", function() CloseAllBags() end)

		for i, v in pairs(close) do
			b:RegisterEvent(v)
		end

	end

---------------------------------------------------------------------------------------------