	--[[

		nanotweak
			tooltip

			Adds icon to tooltips
		
	]]--
	
	local _G, GetItemIcon = _G, GetItemIcon

	local frame = CreateFrame("Frame", "TooltipIconFrame", _G["ItemRefTooltip"])
	frame:SetPoint("TOPRIGHT", _G["ItemRefTooltip"], "TOPLEFT", -3, 0)
	frame:SetWidth(32)
	frame:SetHeight(32)

	frame:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeSize = 1,
	})
	frame:SetBackdropColor(.06, .06, .06, .7)
	frame:SetBackdropBorderColor(0, 0, 0)

	local texture = frame:CreateTexture("TooltipIcon", "TOOLTIP")
	texture:SetPoint("TOPLEFT", 1, -1)
	texture:SetPoint("BOTTOMRIGHT", -1, 1)

	hooksecurefunc("SetItemRef", function()
		--local frame = _G["TooltipIconFrame"]
		local _, link = _G["ItemRefTooltip"]:GetItem()
		local icon = link and GetItemIcon(link)

		if icon then
			_G["TooltipIcon"]:SetTexture(icon)
			_G["TooltipIcon"]:SetTexCoord(.08, .92, .08, .92)
			frame:Show()
		else
			frame:Hide()
		end
	end)
