local E, L, V, P, G = unpack(select(2, ...)) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins")

--Lua functions
local _G = _G
local type = type
local unpack = unpack
--WoW API / Variables

S:AddCallback("Skin_Misc", function()
	if not E.private.skins.blizzard.enable or not E.private.skins.blizzard.misc then return end

	-- ESC/Menu Buttons
	GameMenuFrame:StripTextures()
	GameMenuFrame:CreateBackdrop("Transparent")

	GameMenuFrameHeader:Point("TOP", 0, 7)

	local menuButtons = {
		GameMenuButtonOptions,
		GameMenuButtonSoundOptions,
		GameMenuButtonUIOptions,
		GameMenuButtonPromoCode,
	--	GameMenuButtonMacOptions,
		GameMenuButtonKeybindings,
		GameMenuButtonMacros,
	--	GameMenuButtonRatings,
		GameMenuButtonLogout,
		GameMenuButtonQuit,
		GameMenuButtonContinue,

		ElvUI_MenuButton
	}

	for i = 1, #menuButtons do
		local button = menuButtons[i]
		if button then
			S:HandleButton(menuButtons[i])
		end
	end

	-- Static Popups
	for i = 1, 4 do
		local staticPopup = _G["StaticPopup"..i]
		local itemFrame = _G["StaticPopup"..i.."ItemFrame"]
		local itemFrameBox = _G["StaticPopup"..i.."EditBox"]
		local itemFrameTexture = _G["StaticPopup"..i.."ItemFrameIconTexture"]
		local itemFrameNormal = _G["StaticPopup"..i.."ItemFrameNormalTexture"]
		local itemFrameName = _G["StaticPopup"..i.."ItemFrameNameFrame"]
		local closeButton = _G["StaticPopup"..i.."CloseButton"]
		local wideBox = _G["StaticPopup"..i.."WideEditBox"]

		staticPopup:SetTemplate("Transparent")

		S:HandleEditBox(itemFrameBox)
		itemFrameBox.backdrop:Point("TOPLEFT", -2, -4)
		itemFrameBox.backdrop:Point("BOTTOMRIGHT", 2, 4)

		S:HandleEditBox(_G["StaticPopup"..i.."MoneyInputFrameGold"])
		S:HandleEditBox(_G["StaticPopup"..i.."MoneyInputFrameSilver"])
		S:HandleEditBox(_G["StaticPopup"..i.."MoneyInputFrameCopper"])

		for j = 1, itemFrameBox:GetNumRegions() do
			local region = select(j, itemFrameBox:GetRegions())
			if region and region:GetObjectType() == "Texture" then
				if region:GetTexture() == "Interface\\ChatFrame\\UI-ChatInputBorder-Left" or region:GetTexture() == "Interface\\ChatFrame\\UI-ChatInputBorder-Right" then
					region:Kill()
				end
			end
		end

		closeButton:StripTextures()
		S:HandleCloseButton(closeButton, staticPopup)

		itemFrame:GetNormalTexture():Kill()
		itemFrame:SetTemplate()
		itemFrame:StyleButton()

		hooksecurefunc("StaticPopup_Show", function(which, _, _, data)
			local info = StaticPopupDialogs[which]
			if not info then return nil end

			if info.hasItemFrame then
				if data and type(data) == "table" then
					if data.color then
						itemFrame:SetBackdropBorderColor(unpack(data.color))
					else
						itemFrame:SetBackdropBorderColor(1, 1, 1, 1)
					end
				end
			end
		end)

		itemFrameTexture:SetTexCoord(unpack(E.TexCoords))
		itemFrameTexture:SetInside()

		itemFrameNormal:SetAlpha(0)
		itemFrameName:Kill()

		for ddd = 6,14 do
			select(ddd,wideBox:GetRegions()):SetAlpha(0)
		end
		S:HandleEditBox(wideBox)
		wideBox:Height(22)

		for j = 1, 3 do
			S:HandleButton(_G["StaticPopup"..i.."Button"..j])
		end
	end

	-- Other Frames
	TicketStatusFrameButton:SetTemplate("Transparent")
	AutoCompleteBox:SetTemplate("Transparent")
	ConsolidatedBuffsTooltip:SetTemplate("Transparent")

	-- Basic Script Errors
	BasicScriptErrors:SetScale(E.global.general.UIScale)
	BasicScriptErrors:SetTemplate("Transparent")
	S:HandleButton(BasicScriptErrorsButton)

	-- BNToast Frame
	BNToastFrame:SetTemplate("Transparent")

	BNToastFrameCloseButton:Size(32)
	S:HandleCloseButton(BNToastFrameCloseButton, BNToastFrame)

	-- Ready Check Frame
	ReadyCheckFrame:EnableMouse(true)
	ReadyCheckFrame:SetTemplate("Transparent")

	S:HandleButton(ReadyCheckFrameYesButton)
	ReadyCheckFrameYesButton:SetParent(ReadyCheckFrame)
	ReadyCheckFrameYesButton:ClearAllPoints()
	ReadyCheckFrameYesButton:Point("TOPRIGHT", ReadyCheckFrame, "CENTER", -3, -5)

	S:HandleButton(ReadyCheckFrameNoButton)
	ReadyCheckFrameNoButton:SetParent(ReadyCheckFrame)
	ReadyCheckFrameNoButton:ClearAllPoints()
	ReadyCheckFrameNoButton:Point("TOPLEFT", ReadyCheckFrame, "CENTER", 4, -5)

	ReadyCheckFrameText:SetParent(ReadyCheckFrame)
	ReadyCheckFrameText:Point("TOP", 0, -15)
	ReadyCheckFrameText:SetTextColor(1, 1, 1)

	ReadyCheckListenerFrame:SetAlpha(0)

	-- Coin PickUp Frame
	CoinPickupFrame:StripTextures()
	CoinPickupFrame:SetTemplate("Transparent")

	S:HandleButton(CoinPickupOkayButton)
	S:HandleButton(CoinPickupCancelButton)

	-- Zone Text Frame
	ZoneTextFrame:ClearAllPoints()
	ZoneTextFrame:Point("TOP", 0, -128)

	-- Stack Split Frame
	StackSplitFrame:SetTemplate("Transparent")
	StackSplitFrame:GetRegions():Hide()
	StackSplitFrame:SetFrameStrata("DIALOG")

	StackSplitFrame.bg1 = CreateFrame("Frame", nil, StackSplitFrame)
	StackSplitFrame.bg1:SetFrameLevel(StackSplitFrame.bg1:GetFrameLevel() - 1)
	StackSplitFrame.bg1:SetTemplate("Transparent")
	StackSplitFrame.bg1:Point("TOPLEFT", 10, -15)
	StackSplitFrame.bg1:Point("BOTTOMRIGHT", -10, 55)

	S:HandleButton(StackSplitOkayButton)
	S:HandleButton(StackSplitCancelButton)

	-- Opacity Frame
	OpacityFrame:StripTextures()
	OpacityFrame:SetTemplate("Transparent")

	S:HandleSliderFrame(OpacityFrameSlider)

	-- Channel Pullout Frame
	ChannelPullout:SetTemplate("Transparent")

	ChannelPulloutBackground:Kill()

	S:HandleTab(ChannelPulloutTab)
	ChannelPulloutTab:Size(107, 26)
	ChannelPulloutTabText:Point("LEFT", ChannelPulloutTabLeft, "RIGHT", 0, 4)

	S:HandleCloseButton(ChannelPulloutCloseButton, ChannelPullout)
	ChannelPulloutCloseButton:Size(32)

	-- Dropdown Menu
	local checkBoxSkin = E.private.skins.dropdownCheckBoxSkin
	local menuLevel = 0
	local maxButtons = 0

	local function dropDownButtonShow(self)
		if self.notCheckable then
			self.check.backdrop:Hide()
		else
			self.check.backdrop:Show()
		end
	end

	local function skinDropdownMenu()
		local updateButtons = maxButtons < UIDROPDOWNMENU_MAXBUTTONS

		if updateButtons or menuLevel < UIDROPDOWNMENU_MAXLEVELS then
			for i = 1, UIDROPDOWNMENU_MAXLEVELS do
				local frame = _G["DropDownList"..i]

				if not frame.isSkinned then
					_G["DropDownList"..i.."Backdrop"]:SetTemplate("Transparent")
					_G["DropDownList"..i.."MenuBackdrop"]:SetTemplate("Transparent")

					frame.isSkinned = true
				end

				if updateButtons then
					for j = 1, UIDROPDOWNMENU_MAXBUTTONS do
						local button = _G["DropDownList"..i.."Button"..j]

						if not button.isSkinned then
							S:HandleButtonHighlight(_G["DropDownList"..i.."Button"..j.."Highlight"])

							if checkBoxSkin then
								local check = _G["DropDownList"..i.."Button"..j.."Check"]
								check:Size(12)
								check:Point("LEFT", 1, 0)
								check:CreateBackdrop()
								check:SetTexture(E.media.normTex)
								check:SetVertexColor(1, 0.82, 0, 0.8)

								button.check = check
								hooksecurefunc(button, "Show", dropDownButtonShow)
							end

							S:HandleColorSwatch(_G["DropDownList"..i.."Button"..j.."ColorSwatch"], 14)

							button.isSkinned = true
						end
					end
				end
			end

			menuLevel = UIDROPDOWNMENU_MAXLEVELS
			maxButtons = UIDROPDOWNMENU_MAXBUTTONS
		end
	end

	skinDropdownMenu()
	hooksecurefunc("UIDropDownMenu_InitializeHelper", skinDropdownMenu)

	-- Chat Menu
	local chatMenus = {
		"ChatMenu",
		"EmoteMenu",
		"LanguageMenu",
		"VoiceMacroMenu",
	}

	ChatMenu:ClearAllPoints()
	ChatMenu:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 30)
	ChatMenu.ClearAllPoints = E.noop
	ChatMenu.SetPoint = E.noop

	local chatMenuOnShow = function(self)
		self:SetBackdropBorderColor(unpack(E.media.bordercolor))
		self:SetBackdropColor(unpack(E.media.backdropfadecolor))
	end

	for i = 1, #chatMenus do
		local frame = _G[chatMenus[i]]
		frame:SetTemplate("Transparent")
		frame:HookScript("OnShow", chatMenuOnShow)

		for j = 1, 32 do
			_G[chatMenus[i].."Button"..j]:StyleButton()
		end
	end

	-- Localization specific frames
	local locale = GetLocale()
	if locale == "koKR" then
		S:HandleButton(GameMenuButtonRatings)

		-- RatingMenuFrame
		RatingMenuFrame:SetTemplate("Transparent")
		RatingMenuFrameHeader:SetTexture()
		S:HandleButton(RatingMenuButtonOkay)

		RatingMenuButtonOkay:Point("BOTTOMRIGHT", -8, 8)
	elseif locale == "ruRU" then
		-- Declension Frame
		DeclensionFrame:SetTemplate("Transparent")

		S:HandleNextPrevButton(DeclensionFrameSetPrev, "left")
		S:HandleNextPrevButton(DeclensionFrameSetNext, "right")
		S:HandleButton(DeclensionFrameOkayButton)
		S:HandleButton(DeclensionFrameCancelButton)

		DeclensionFrameSet:Point("BOTTOM", 0, 40)
		DeclensionFrameOkayButton:Point("RIGHT", DeclensionFrame, "BOTTOM", -3, 19)
		DeclensionFrameCancelButton:Point("LEFT", DeclensionFrame, "BOTTOM", 3, 19)

		hooksecurefunc("DeclensionFrame_Update", function()
			for i = 1, RUSSIAN_DECLENSION_PATTERNS do
				_G["DeclensionFrameDeclension"..i.."Edit"]:SetTemplate("Default")
			end
		end)
	end
end)

-- Скиннер кнопок NavBar`a с ретейл версии ElvUI.
local function SkinNavBarButtons(self)
	if (self:GetParent():GetName() == "EncounterJournal" and not E.private.skins.blizzard.encounterjournal) or (self:GetParent():GetName() == "WorldMapFrame" and not E.private.skins.blizzard.worldmap) or (self:GetParent():GetName() == "HelpFrameKnowledgebase" and not E.private.skins.blizzard.help) then
		return
	end

	local navButton = self.navList[#self.navList]
	if navButton and not navButton.isSkinned then
		S:HandleButton(navButton, true)
		navButton:GetFontString():SetTextColor(1, 1, 1)
		if navButton.MenuArrowButton then
			navButton.MenuArrowButton:StripTextures()
			if navButton.MenuArrowButton.Art then
				navButton.MenuArrowButton.Art:Size(18)
				navButton.MenuArrowButton.Art:SetTexture(E.Media.Textures.ArrowUp)
				navButton.MenuArrowButton.Art:SetTexCoord(0, 1, 0, 1)
				navButton.MenuArrowButton.Art:SetRotation(3.14)
			end
		end

		navButton.xoffset = 1

		navButton.isSkinned = true
	end
end

local function LoadSkin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.misc ~= true then return end

	local BlizzardMenuButtons = {
		"Help",
		"Store",
		"PromoCodes",
		"AudioOptions",
		"WhatsNew"
	}

	for i = 1, #BlizzardMenuButtons do
		local ElvuiMenuButtons = _G["GameMenuButton"..BlizzardMenuButtons[i]]
		if ElvuiMenuButtons then
			S:HandleButton(ElvuiMenuButtons)
		end
	end

	-- Static Popups
	for i = 1, 4 do
		local staticPopup = _G["StaticPopup"..i]
		staticPopup.bar:StripTextures()
		staticPopup.bar:CreateBackdrop("Transparent")


		staticPopup.bar:Point("TOP", staticPopup, "BOTTOM", 0, -4)
		staticPopup.bar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(staticPopup.bar)
	end

	if InterfaceOptionsCombatPanelTargetOfTarget:GetAlpha() == 0 then
		InterfaceOptionsCombatPanelTOTDropDown:ClearAllPoints()
		InterfaceOptionsCombatPanelTOTDropDown:SetPoint("TOPRIGHT", InterfaceOptionsCombatPanelSubText, "BOTTOMRIGHT", 0, -2)
	end

	hooksecurefunc("NavBar_AddButton", SkinNavBarButtons)

	-- GhostFrame
	GhostFrame:StripTextures(nil, true)
	S:HandleButton(GhostFrame)
	GhostFrame:SetTemplate("Transparent")
	GhostFrameContentsFrameIcon:CreateBackdrop()
	GhostFrameContentsFrameIcon:SetTexCoord(unpack(E.TexCoords))

	local GhostFrameHolder = CreateFrame("Frame", "GhostFrameHolder", E.UIParent)
	GhostFrameHolder:Size(130, 46)
	GhostFrameHolder:Point("TOP", E.UIParent, "TOP", 0, -70)

	E:CreateMover(GhostFrameHolder, "GhostFrameMover", L["Ghost Frame"])
	GhostFrameMover:SetFrameStrata("FULLSCREEN")
	GhostFrameHolder:SetAllPoints(GhostFrameMover)

	hooksecurefunc(GhostFrame, "SetPoint", function(self, _, parent)
		if parent ~= GhostFrameHolder then
			self:ClearAllPoints()
			self:SetPoint("CENTER", GhostFrameHolder, "CENTER")
		end
	end)
end

S:AddCallback("Sirus_Misc", LoadSkin)