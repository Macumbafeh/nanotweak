	--[[

		nanotweak
			misc
		
	]]--

	
	-- Replace the "type delete" box with the "are you sure you want to delete this item" box
	StaticPopupDialogs["DELETE_GOOD_ITEM"] = StaticPopupDialogs["DELETE_ITEM"]

	
	-- Worldmap tweaks
	WorldMapPlayer:EnableMouse(false)
	WorldMapZoomOutButton:Hide()
	WorldMapMagnifyingGlassButton:Hide()


	-- Increase number of maximum chat lines
	ChatFrame1:SetMaxLines(1024)