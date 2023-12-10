--[[	*****************************************************************
	BankItems v2.56
	2021-January-10

	Author: Xinhuan @ US Blackrock Alliance
	*****************************************************************
	Description:
		Type /bi or /bankitems to see what is currently in your
		bank.  You must visit your bank once to initialize.

		An addon that remembers the contents of your bank, bags,
		mail and equipped and display them anywhere in the world.
		Also able to remember/display the banks of any character
		on the same account on any server, as well as searching
		and exporting lists of bag/bank items out.

	Download:
		BankItems	- http://ui.worldofwar.net/ui.php?id=1699

	Plugins:
		These plugins allow clicking on the panel/plugin icon to
		open BankItems, giving a summarised view of inventory
		slots and money of each character on the same realm, and
		deleting data with the menu quickly.

		Titan Panel	- http://ui.worldofwar.net/ui.php?id=3848
		FuBar		- http://ui.worldofwar.net/ui.php?id=3849

	Commands:
		/bi : open BankItems
		/bi all : open BankItems and all bags
		/bi allbank: open BankItems and all bank bags only
		/bi clear : clear currently selected player's info
		/bi clearall : clear all players' info
		/bi showbuttun : show the minimap button
		/bi hidebutton : hide the minimap button
		/bi search itemname : search for items
		/bis itemname : search for items

		Most options are found in the GUI options panel.

	Credits:
		Original concept from Merphle
		Last maintained by JASlaughter, then Galmok@Stormrage-EU.
		Additional modifications for Classic by Hawksy on Elune
	*****************************************************************

Xinhuan's Note:
	This addon replaces the Blizzard function updateContainerFrameAnchors() in ContainerFrame.lua
	if the option is set to open the BankItems bags along with the Blizzard default bags. This may
	break any addon(s) that hook this function, but see no real reason why anyone would ever hook
	that function in the first place.
]]

--------------------
-- Patch Notes:

-- Updated to handle larger than 16 slot bags by Galmok@Stormrage-EU: Version 11000
-- Removed double variable definitions (first defined in ContainerFrame.lua): Version 11001
-- Updated to be patch 1.11 compatible (bag texture fix) by Galmok@Stormrage-EU: Version 11100


-- 2 December 2006, by Xinhuan @ Blackrock US Alliance: Version 20000
-- Updated to be TBC v2.0.2 compliant.
-- BankItems expanded to include the 4 extra bank slots and 1 bank bag slot in the expansion.
-- BankItems bags will now use the right side of the screen like normal bags and stack with them.
-- Removed the "resetpos" option since all frames are now not movable.
-- Updated link parsing format to TBC itemlinks.
-- Fixed the dropdown menu bug.


-- 6 December 2006, by Xinhuan @ Blackrock US Alliance: Version 20001
-- Updated to be Live Servers v2.0.1.6180 compliant.
-- Added function to upgrade saved data to TBC itemlink format.


-- 10 January 2007, by Xinhuan @ Blackrock US Alliance: Version 20300
-- For use with Live Servers v2.0.3.6299. TOC update to 20003.
-- NEW: BankItems will now also remember the contents of your 5 inventory bags.
-- NEW: BankItems Will now remember purchased and unused bank bag slots (grey/red background).
-- NEW: Added optional draggable minimap button.
-- NEW: Added "/bi showbutton" and "/bi hidebutton" to show and hide the minimap button.
-- NEW: The BankItems main window is now movable (and cannot be dragged offscreen).
-- NEW: You can now set the scale and transparency of BankItems. The default scale is now 80%.
-- NEW: Added GUI options panel which contain most of the available options.
-- UPDATED: When hovering over the bag portrait of an open BankItems bagframe, the tooltip will now show the bag link.
-- CHANGED/FIXED: Changed the way BankItems bags show. They will no longer open up together with the normal bags because doing so taints the default UI and causes the petbar not to show/hide in combat. They will now open next to the BankItems main bank frame instead.
-- FIXED: Fixed extra spaces that can appear on "/bi list".
-- FIXED: Removed invisible "unclickable" space below the BankItems main bank frame.
-- FIXED: Fixed error due to ContainerIDToInventoryID(bagID) API change. Inputs outside the range of 1-11 (4 bag and 7 bank) are no longer valid input.
-- NEW: FuBar and Titan Panel plugins for BankItems are now available.
--
-- Because up to 12 possible bags can be displayed, users are adviced to change the scale in the GUI options.


-- 17 January 2007, by Xinhuan @ Blackrock US Alliance: Version 20500
-- For use with Live Servers v2.0.5.6320. TOC remains at 20003 (don't ask me why).
-- FIXED: Fixed a rare possible error with item link parsing.
-- CHANGED: BankItems normal inventory bags will now have normal bag textures to match the default UI. This makes it easier to tell which ones are bank bags and which aren't.


-- 26 January 2007, by Xinhuan @ Blackrock US Alliance: Version 20600
-- For use with Live Servers v2.0.6.6337. TOC remains at 20003.
-- NEW: Added an extra keybind and slash command option (/bi allbank) to only open bank bags as opposed to all bags.
-- NEW: Added in Auctioneer tooltip support for BankItems (thanks Knaledge).
-- NEW: Readded in the option to open the BankItem bags along with the default bags in the bottom right corner as per in v20300, because tainting issues are fixed.


-- 5 February 2007, by Xinhuan @ Blackrock US Alliance: Version 20601
-- For use with Live Servers v2.0.6.6337. TOC remains at 20003.
-- NEW: Added an option to make the BankItems main frame behave like Blizzard frames (will push frames to the right). However, this only works at 100% frame scaling.
-- NEW: Added a little hook to support Saeris Lootlink tooltips.
-- NEW: Added an option to change the default behavior of "/bi" without having to add the "all" or "allbank" options.
-- NEW: You can now export a list of items in your bags/bank by copying text from an export window.
-- FIXED: BankItems will now work with OneBank, Bagnon and other bag/bank type addons.


-- 5 February 2007, by Xinhuan @ Blackrock US Alliance: Version 20602
-- FIXED: Fixed the errors that occur on hitting the Options Button due to a mistake.


-- 17 April 2007, by Xinhuan @ Blackrock US Alliance: Version 20603
-- For use with Live Servers v2.0.12.6546. TOC remains at 20003.
-- NEW: BankItems will now remember the 20 items that are equipped on each character.
-- NEW: Added HealPoints tooltip support.
-- CHANGED: The user dropdown list is now sorted alphabetically by name then by realm (for characters of the same name on multiple realms).
-- FIXED: Saeris LootLink, Auctioneer and other Auctioneer related addons will now show information with the correct stack sizes instead of 1 item.


-- 31 May 2007, by Xinhuan @ Blackrock US Alliance: Version 21000
-- For use with Live Servers v2.1.0.6729. TOC update to 20100.
-- NEW: Added some extra options for item groupings and no-preformatting for exporting bank content.


-- 21 June 2007, by Xinhuan @ Blackrock US Alliance: Version 21001
-- For use with Live Servers v2.1.2.6803.
-- UPDATED: BankItems will now generate minimal garbage to be collected (memory efficiency). It used to generate as much as 50kb of garbage on _every_ inventory change.
-- NEW: BankItems will now remember where your character last logged out and display it in the BankItems frame title.


-- 17 August 2007, by Xinhuan @ Blackrock US Alliance: Version 21002
-- For use with Live Servers v2.1.3.6898.
-- FIXED: Opening and closing BankItems with keybindings will no longer cause Blizzard frames to behave oddly.
-- NEW: BankItems will now remember your items and cumulative gold in the mailbox when you visit it.
-- NEW: You may now search for items by name using "/bi search itemname".


-- 24 August 2007, by Xinhuan @ Blackrock US Alliance: Version 22000
-- For use with Live Servers v2.1.3.6898 and PTR Servers v0.2.0.7125.
-- UPDATED: Rewrote BankItems fully using the latest available APIs and layout functions. The original addon was written 2 years ago.
-- UPDATED: Improved load time, speed, efficiency, garbage generation, event handling. Lowered memory usage, removed redundant code.
-- UPDATED: Rewrote event handling code so that BankItems will no longer record your whole inventory multiple times on bag/equipped changes. This means when you change equipment sets using closetgnome/itemrack/etc, it will only record changes once and not as much as 38 times.
-- UPDATED: When something in your bags change, BankItems will now only record the affected bag(s) once instead of your whole inventory.
-- UPDATED: BankItems no longer uses XML files. BankItems.xml is still included as a zero-byte file to overwrite the old 49KB file and can be deleted.
-- REMOVED: Removed '/bi list' because it is useless and text exporting is already available.
-- FIXED: Occasional inverted toggle for 'Show Bag Prefix' option.
-- FIXED: Clicking on bags/items in BankItems no longer inserts a link when typing a message if the Shift key isn't held down.
-- FIXED: BankItems will no longer stop recording bags at the first empty bag slot it found (if for some reason you skipped bag slots).
-- FIXED: Bankitems will now store items when you leave/close the mailbox instead of opening to avoid a possible WoW client hang.
-- FIXED: Hopefully fixed the Auctioneer/EnhTooltip tooltip display bugs.
-- CHANGED: Mailbag display has been changed to a single bag with next/prev buttons to allow unlimited mail to be shown.
-- NEW: Added a number in brackets indicating the total number of each item found when using 'Group similar items' mode while using /bi search itemname.
-- NEW: Items and money that are sent to known alts on your account are saved in the BankItems recipient's mailbag directly.


-- 1st October 2007, by Xinhuan @ Blackrock US Alliance: Version 22001
-- For use with Live Servers v2.2.0.7272. TOC update to 20200.
-- CHANGED: Pressing Esc will now close the export/search results window.
-- CHANGED: Made the search results more readable and more detailed.
-- CHANGED: Changed options so that you can now choose which bags (bank, inventory, equipped, mail) to open on /bi.
-- NEW: Added /bis as a shortcut for /bi search.
-- NEW: Added button to bring up the search results window.
-- NEW: Added checkbox to only search the current realm instead of all realms.
-- REMOVED: Removed EnhTooltip and Stubby from OptionalDeps. They are no longer required to load before BankItems.
-- FIXED: Attempted to fix line 1555 concatenate local 'recipient' nil error.
-- FIXED: Fixed Export and Search only counting the first 18 slots of the mail bag.


-- 16th November 2007, by Xinhuan @ Blackrock US Alliance: Version 23000
-- For use with Live Servers v2.3.0.7561. TOC update to 20300.
-- FIXED: Removed the "Behavior" character from appearing on the dropdown list when "Show All Realms" is selected.
-- UPDATED: Updated BankItems to work with multiple attachments mail in 2.3.
-- UPDATED: Split off localization into its own file. Removed the empty XML file.


-- 2019-October-11 Hawksy @ Elune: BankItems Classic Version 2.5
-- Many modifications to get BankItems working in Classic, the most significant being not showing mail items in a bag
--		Mail items are still findable via Search and Export (and now in tooltips)
-- 		An alternative might have been to show mail in a bag, but not show equipped items in a bag
-- Added tooltip display code from Retail version, modified to work in Classic
-- 		Known anomalies:
-- 			No auction support, no expired mail support, no returned or deleted mail support, no money support
--			Player A can see something they mailed to player B, but player B can't see that it is incoming -- even though players A and B can see each other's non-mail amounts
-- 2019-December-29 Version 2.55 fixed an issue where moving something to or from the bank gave double-counting.
-- 2021-Jan-10 Version 2.56 updated for 1.13.6

--]]

BankItems_Save			= {}		-- table, SavedVariable, can't be local

---@class bankPlayer
---@field location any
---@field money any
---@field NumBankSlots any
local bankPlayer					= nil		-- table reference

local bankPlayerName			= ""		-- string, name of the player associated with bankPlayer

---@class selfPlayer
---@field location any
---@field money any
---@field NumBankSlots any
local selfPlayer					= nil		-- table reference
local selfPlayerName			= ""		-- string, name of the player associated with selfPlayer
local selfPlayerRealm			= ""		-- string
local isBankOpen					= false		-- boolean, whether the real bank is open
local BankItems_Quantity	= 1		-- integer, used for hooking EnhTooltip data
local bagsToUpdate				= {}		-- table, stores data about bags to update on next OnUpdate
local mailItem						= {}		-- table, stores data about the item to be mailed
local sortedKeys					= {}		-- table, for sorted player dropdown menu
local info								= {}		-- table, for dropdown menu generation
local BankItemsCFrames		= {}		-- table, own bag position tracking
BankItemsCFrames.bags			= {}
BankItemsCFrames.bagsShown	= 0

BankItems_Cache        = {} -- table, contains a cache of items of every character on the same realm except the player
BankItems_SelfCache    = {} -- table, contains a cache of only the player's items
BankItems_TooltipCache = {} -- table, contains a cache of tooltip lines that have been added

-- Some constants
local BANKITEMS_BOTTOM_SCREEN_LIMIT	= 80				-- Pixels from bottom not to overlap BankItem bags
local BANKITEMS_UCFA = updateContainerFrameAnchors	-- Remember Blizzard's UCFA for NON-SAFE replacement
local BAGNUMBERS = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100}	-- List of bag numbers used internally by BankItems (11 and 101 removed for Classic)
local BAGNUMBERSPLUSMAIL = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100, 101}	-- List of bag numbers used internally by BankItems (11 removed for Classic)
-- 0 through 4 are the player's bags, to be shown in reverse order, preceded by 100, the player's equipment
-- 5 through 10 are the bank bags, left to right
-- 101 is never visible, contains the mail information
local BANKITEMS_UIPANELWINDOWS_TABLE = {area = "left", pushable = 11, whileDead = 1}	-- UI Panel layout to be used

---Converts WoW INVSLOT_xxx constants into WoW inventory slot names
local BANKITEMS_INVSLOT = {
	[INVSLOT_AMMO] 		= "AmmoSlot",
	[INVSLOT_HEAD] 		= "HeadSlot",
	[INVSLOT_NECK] 		= "NeckSlot",
	[INVSLOT_SHOULDER]	= "ShoulderSlot",
	[INVSLOT_BODY]			= "ShirtSlot",
	[INVSLOT_CHEST]		= "ChestSlot",
	[INVSLOT_WAIST]		= "WaistSlot",
	[INVSLOT_LEGS]			= "LegsSlot",
	[INVSLOT_FEET]			= "FeetSlot",
	[INVSLOT_WRIST]		= "WristSlot",
	[INVSLOT_HAND]			= "HandsSlot",
	[INVSLOT_FINGER1]		= "Finger0Slot",
	[INVSLOT_FINGER2]		= "Finger1Slot",
	[INVSLOT_TRINKET1]	= "Trinket0Slot",
	[INVSLOT_TRINKET2]	= "Trinket1Slot",
	[INVSLOT_BACK]			= "BackSlot",
	[INVSLOT_MAINHAND]	= "MainHandSlot",
	[INVSLOT_OFFHAND]		= "SecondaryHandSlot",
	[INVSLOT_RANGED]		= "RangedSlot",
	[INVSLOT_TABARD]		= "TabardSlot"
}

-- Localize some globals
local pairs, ipairs = pairs, ipairs
local gsub, strfind, strlower, strmatch, strsplit = gsub, strfind, strlower, strmatch, strsplit
local GetContainerItemLink, GetContainerItemInfo = C_Container.GetContainerItemLink, C_Container.GetContainerItemInfo
local GetInboxHeaderInfo, GetInboxItem, GetInboxItemLink = GetInboxHeaderInfo, GetInboxItem, GetInboxItemLink

-- Redeclare some constants here so the type system knows about them.
-- They were removed in 9.0.1 (Shadowlands)
-- https://warcraft.wiki.gg/wiki/Patch_9.0.1/API_changes
-- TODO: Figure out how to change WoWAPI to classic mode
local KEYRING_CONTAINER				= KEYRING_CONTAINER or -2
local NUM_CONTAINER_COLUMNS		= NUM_CONTAINER_COLUMNS or 4
local MAX_BG_TEXTURES				= MAX_BG_TEXTURES or 2
local ROWS_IN_BG_TEXTURE			= ROWS_IN_BG_TEXTURE or 6
local BG_TEXTURE_HEIGHT				= BG_TEXTURE_HEIGHT or 512
local CONTAINER_WIDTH				= CONTAINER_WIDTH or 192
local CONTAINER_SCALE				= CONTAINER_SCALE or 0.750
local VISIBLE_CONTAINER_SPACING	= VISIBLE_CONTAINER_SPACING or 3
local CONTAINER_SPACING				= CONTAINER_SPACING or 0


-- Localize some frame references
local BankItems_Frame
local BankItems_OptionsFrame
local BankItems_ExportFrame
local BankItems_UpdateFrame
local ItemButtonAr = {}
local BagButtonAr = {}
local BagContainerAr = {}

-- For hooking tooltip support
-- LinkWrangler is supported by LinkWrangler callback methods
local TooltipList = {
	"GameTooltip",
	"ItemRefTooltip",
	"ShoppingTooltip",
	"ComparisonTooltip",           -- EquipCompare support
	"EQCompareTooltip",            -- EQCompare support
	"tekKompareTooltip",           -- tekKompare support
	"IRR_",
	"LinksTooltip",                -- Links support
	"AtlasLootTooltip",            -- AtlasLoot support
	"ItemMagicTooltip",            -- ItemMagic support
	"SniffTooltip",                -- Sniff support
	"LH_",                         -- LinkHeaven support
	"MirrorTooltip",               -- Mirror support
	"LootLink_ResultsTooltip",     -- Saeris' LootLink support
	"TooltipExchange_TooltipShow", -- TooltipExchange support
}

-------------------------------------------------
-- OnFoo scripts of the various widgets

function BankItems_Button_OnEnter(self)
	if (bankPlayer[self:GetID()]) then
		BankItems_Quantity = bankPlayer[self:GetID()].count or 1
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink(bankPlayer[self:GetID()].link)
		BankItems_AddEnhTooltip(bankPlayer[self:GetID()].link, BankItems_Quantity)
		if ( IsControlKeyDown() ) then
			ShowInspectCursor()
		end
	end
end

function BankItems_Button_OnClick(self, button)
	if (bankPlayer[self:GetID()]) then
		if ( IsControlKeyDown() ) then
			DressUpItemLink(bankPlayer[self:GetID()].link)
		elseif ( button and button == "LeftButton" and IsShiftKeyDown() and ChatEdit_GetActiveWindow():IsVisible() ) then
			ChatEdit_GetActiveWindow():Insert(bankPlayer[self:GetID()].link)
		end
	end
end

function BankItems_Bag_OnEnter(self)
	local id = self:GetID()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	if (id == 0) then
		GameTooltip:SetText(BACKPACK_TOOLTIP)
	elseif (id == 100) then
		GameTooltip:SetText(BANKITEMS_EQUIPPED_ITEMS_TEXT)
--	elseif (id == 101) then
--		GameTooltip:SetText(BANKITEMS_MAILBOX_ITEMS_TEXT)
	elseif (bankPlayer["Bag"..id]) then
		GameTooltip:SetHyperlink(bankPlayer["Bag"..id].link)
		BankItems_AddEnhTooltip(bankPlayer["Bag"..id].link, 1)
	end
end

function BankItems_Bag_OnClick(self, button)
	local bagID = self:GetID()
	local theBag = bankPlayer["Bag"..bagID]

	if (not theBag) then
		if (bagID == 100) then
			BankItems_Chat(BANKITEMS_DATA_NOT_FOUND_TEXT)
--		elseif (bagID == 101) then
--			BankItems_Chat(BANKITEMS_MAILDATA_NOT_FOUND_TEXT)
		end
		return
	end

	if (button and button == "LeftButton" and IsShiftKeyDown() and ChatEdit_GetActiveWindow():IsVisible() and bagID and bagID > 0 and bagID <= 10) then
		ChatEdit_GetActiveWindow():Insert(theBag.link)
		return
	end

	if (theBag.size == 0) then
		-- It should never be 0, so this code should never occur
		BankItems_Chat(BANKITEMS_BAG_NOT_INIT_TEXT)
		return
	end

	-- Rest of this code is copied from ContainerFrame.lua, modified slightly for size/links
	local bagFrame = BagContainerAr[bagID]

	if ( bagFrame:IsVisible() ) then
		bagFrame:Hide()
		return
	end

	-- Generate the frame
	local bagName = bagFrame:GetName()
	local bgTextureTop = _G[bagName.."BackgroundTop"]
	local bgTextureMiddle = _G[bagName.."BackgroundMiddle1"]
	local bgTextureBottom = _G[bagName.."BackgroundBottom"]
	local columns = NUM_CONTAINER_COLUMNS
	local size = theBag.size
	local rows = ceil(size / columns)

	-- Set whether or not its a bank bag
	local bagTextureSuffix = ""
	if ( bagID > NUM_BAG_FRAMES ) then
		bagTextureSuffix = "-Bank"
	elseif ( bagID == KEYRING_CONTAINER ) then
		bagTextureSuffix = "-Keyring"
	end

	-- Set textures
	bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix)
	for i=1, MAX_BG_TEXTURES do
		_G[bagName.."BackgroundMiddle"..i]:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix)
		_G[bagName.."BackgroundMiddle"..i]:Hide()
	end
	bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix)

	local bgTextureCount, height
	local rowHeight = 41
	-- Subtract one, since the top texture contains one row already
	local remainingRows = rows-1

	-- See if the bag needs the texture with two slots at the top
	local isPlusTwoBag
	if ( mod(size,columns) == 2 ) then
		isPlusTwoBag = 1
	end

	-- Bag background display stuff
	if ( isPlusTwoBag ) then
		bgTextureTop:SetTexCoord(0, 1, 0.189453125, 0.330078125)
		bgTextureTop:SetHeight(72)
	else
		if ( rows == 1 ) then
			-- If only one row chop off the bottom of the texture
			bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.16796875)
			bgTextureTop:SetHeight(86)
		else
			bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.18359375)
			bgTextureTop:SetHeight(94)
		end
	end
	-- Calculate the number of background textures we're going to need
	bgTextureCount = ceil(remainingRows/ROWS_IN_BG_TEXTURE)

	local middleBgHeight = 0
	-- If one row only special case
	if ( rows == 1 ) then
		bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "TOP", 0, 0)
		bgTextureBottom:Show()
		-- Hide middle bg textures
		for i=1, MAX_BG_TEXTURES do
			_G[bagName.."BackgroundMiddle"..i]:Hide()
		end
	else
		-- Try to cycle all the middle bg textures
		local firstRowPixelOffset = 9
		local firstRowTexCoordOffset = 0.353515625
		for i=1, bgTextureCount do
			bgTextureMiddle = _G[bagName.."BackgroundMiddle"..i]
			if ( remainingRows > ROWS_IN_BG_TEXTURE ) then
				-- If more rows left to draw than can fit in a texture then draw the max possible
				height = ( ROWS_IN_BG_TEXTURE*rowHeight ) + firstRowTexCoordOffset
				bgTextureMiddle:SetHeight(height)
				bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, ( height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset) )
				bgTextureMiddle:Show()
				remainingRows = remainingRows - ROWS_IN_BG_TEXTURE
				middleBgHeight = middleBgHeight + height
			else
				-- If not its a huge bag
				bgTextureMiddle:Show()
				height = remainingRows*rowHeight-firstRowPixelOffset
				bgTextureMiddle:SetHeight(height)
				bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, ( height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset) )
				middleBgHeight = middleBgHeight + height
			end
		end
		-- Position bottom texture
		bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "BOTTOM", 0, 0)
		bgTextureBottom:Show()
	end
	-- Set the frame height
	bagFrame:SetHeight(bgTextureTop:GetHeight()+bgTextureBottom:GetHeight()+middleBgHeight)

	if (bagID == 0) then
		_G[bagName.."Name"]:SetText(BACKPACK_TOOLTIP)
	elseif (bagID == 100) then
		_G[bagName.."Name"]:SetText(BANKITEMS_EQUIPPED_ITEMS_TEXT)
--	elseif (bagID == 101) then
--		_G[bagName.."Name"]:SetText(BANKITEMS_MAILBOX_ITEMS_TEXT)
	else
		_G[bagName.."Name"]:SetText(BankItems_ParseLink(theBag.link))
	end
	_G[bagName.."Portrait"]:SetTexture(theBag.icon)
	bagFrame:SetWidth(CONTAINER_WIDTH)

	for bagItem = 1, size do
		local idx = size - (bagItem - 1)
		local button = _G[bagName.."Item"..bagItem]
		if ( bagItem == 1 ) then
			button:SetPoint("BOTTOMRIGHT", bagName, "BOTTOMRIGHT", -12, 9)
		else
			if ( mod((bagItem-1), columns) == 0 ) then
				button:SetPoint("BOTTOMRIGHT", bagName.."Item"..(bagItem - columns), "TOPRIGHT", 0, 4)
			else
				button:SetPoint("BOTTOMRIGHT", bagName.."Item"..(bagItem - 1), "BOTTOMLEFT", -5, 0)
			end
		end
		button:Show()
	end
	for bagItem = size + 1, 36 do
		_G[bagName.."Item"..bagItem]:Hide()
	end

	BankItems_PopulateBag(bagID)
	bagFrame:ClearAllPoints()
	if (BankItems_Save.BagParent == 1) then
		BankItemsCFrames.bags[BankItemsCFrames.bagsShown + 1] = bagFrame:GetName()
		BankItemsUpdateCFrameAnchors()
	elseif (BankItems_Save.BagParent == 2) then
		ContainerFrame1.bags[ContainerFrame1.bagsShown + 1] = bagFrame:GetName()
		updateContainerFrameAnchors()
	end
	bagFrame:Show()
	PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
end

function BankItems_Bag_OnShow(self)
	BagButtonAr[self:GetID()].HighlightTexture:Show()
	if (BankItems_Save.BagParent == 1) then
		BankItemsCFrames.bagsShown = BankItemsCFrames.bagsShown + 1
	elseif (BankItems_Save.BagParent == 2) then
		ContainerFrame1.bagsShown = ContainerFrame1.bagsShown + 1
	end
end

function BankItems_Bag_OnHide(self)
	BagButtonAr[self:GetID()].HighlightTexture:Hide()
	if (BankItems_Save.BagParent == 1) then
		BankItemsCFrames.bagsShown = BankItemsCFrames.bagsShown - 1
		tDeleteItem(BankItemsCFrames.bags, self:GetName())	-- defined in UIParent.lua
		BankItemsUpdateCFrameAnchors()
	elseif (BankItems_Save.BagParent == 2) then
		ContainerFrame1.bagsShown = ContainerFrame1.bagsShown - 1
		tDeleteItem(ContainerFrame1.bags, self:GetName())	-- defined in UIParent.lua
		updateContainerFrameAnchors()
	end
	PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
end

function BankItems_BagItem_OnEnter(self)
	local bagID = self:GetParent():GetID()
	local itemID = bankPlayer["Bag"..bagID].size - ( self:GetID() - 1 )
	if (bagID == 100 and itemID == 20) then		-- Treat slot 20 as slot 0 (ammo slot)
		itemID = 0
--	elseif (bagID == 101) then
--		itemID = itemID + (mailPage - 1) * 18
	end
	local item = bankPlayer["Bag"..bagID][itemID]
	if (item) then
		BankItems_Quantity = item.count or 1
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if (type(item.link) == "number") then
			GameTooltip:SetText(BANKITEMS_MAILBOX_MONEY_TEXT)
			SetTooltipMoney(GameTooltip, item.link)
			SetMoneyFrameColor("GameTooltipMoneyFrame", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		elseif (type(item.link) == "nil" and bagID == 100) then
			GameTooltip:SetText((gsub(BANKITEMS_INVSLOT[itemID], "Slot", " Slot")))
		else
			GameTooltip:SetHyperlink(item.link)
			BankItems_AddEnhTooltip(item.link, BankItems_Quantity)
		end
		if (IsControlKeyDown()) then
			ShowInspectCursor()
		end
		GameTooltip:Show()
	end
end

function BankItems_BagItem_OnClick(self, button)
	local bagID = self:GetParent():GetID()
	local itemID = bankPlayer["Bag"..bagID].size - ( self:GetID() - 1 )
	if (bagID == 100 and itemID == 20) then		-- Treat slot 20 as slot 0 (ammo slot)
		itemID = 0
--	elseif (bagID == 101) then
--		itemID = itemID + (mailPage - 1) * 18
	end
	local item = bankPlayer["Bag"..bagID][itemID]
	if (item) then
		if ( IsControlKeyDown() ) then
			if (type(item.link) ~= "number") then
				DressUpItemLink(item.link)
			end
		elseif ( button and button == "LeftButton" and IsShiftKeyDown() and ChatEdit_GetActiveWindow():IsVisible() ) then
			if (type(item.link) == "number") then
				ChatEdit_GetActiveWindow():Insert(BankItem_ParseMoney(item.link))
			else
				ChatEdit_GetActiveWindow():Insert(item.link)
			end
		end
	end
end

function BankItems_BagPortrait_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	local bagNum = self:GetParent():GetID()
	if ( bagNum == 0 ) then
		GameTooltip:SetText(BACKPACK_TOOLTIP)
	elseif ( bagNum == 100 ) then
		GameTooltip:SetText(BANKITEMS_EQUIPPED_ITEMS_TEXT)
--	elseif ( bagNum == 101 ) then
--		GameTooltip:SetText(BANKITEMS_MAILBOX_ITEMS_TEXT)
	elseif ( bagNum == KEYRING_CONTAINER ) then
		GameTooltip:SetText(KEYRING)
	elseif ( bankPlayer["Bag"..bagNum].link ) then
		GameTooltip:SetHyperlink(bankPlayer["Bag"..bagNum].link)
		BankItems_AddEnhTooltip(bankPlayer["Bag"..bagNum].link, 1)
	end
end

function BankItems_AddEnhTooltip(link, quantity)
	if (C_AddOns.IsAddOnLoaded("EnhTooltip") and _G["EnhTooltip"]) then
		local name = strmatch(link, "|h%[(.-)%]|h|r")
		_G["EnhTooltip"].TooltipCall(GameTooltip, name, link, nil, quantity, nil, false, link)
	end
end

function BankItems_Button_OnLeave(self)
	ResetCursor()
	GameTooltip:Hide()
end

function BankItems_Frame_OnShow(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
	BankItems_PopulateFrame()
end

function BankItems_Frame_OnHide(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
	for _, i in ipairs(BAGNUMBERS) do
		BagContainerAr[i]:Hide()
	end
end

function BankItems_Frame_OnDragStart(self)
	self:StartMoving()
	if (BankItems_Save.BagParent == 1) then
		self:SetScript("OnUpdate", BankItemsUpdateCFrameAnchors)
	elseif (BankItems_Save.BagParent == 2) then
		self:SetScript("OnUpdate", updateContainerFrameAnchors)
	end
end

function BankItems_Frame_OnDragStop(self)
	self:StopMovingOrSizing()
	self:SetScript("OnUpdate", nil)
	BankItems_Save.pospoint, _, BankItems_Save.posrelpoint, BankItems_Save.posoffsetx, BankItems_Save.posoffsety = BankItems_Frame:GetPoint()
end

function BankItems_Frame_OnEvent(self, event, ...)
	local arg1 = ...


	if event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" then
		-- Delay updating to the next frame as multiple UNIT_INVENTORY_CHANGED events can occur in 1 frame
		-- This is the reason why BankItemsFu delays updates by 2 frames.
		bagsToUpdate.inv = true
		BankItems_UpdateFrame:SetScript("OnUpdate", BankItems_UpdateFrame_OnUpdate)

	elseif event == "BAG_UPDATE" then
		-- Delay updating to the next frame as multiple BAG_UPDATE events can occur in 1 frame
		-- This is the reason why BankItemsFu delays updates by 2 frames.
		bagsToUpdate[tonumber(arg1)] = true
		BankItems_UpdateFrame:SetScript("OnUpdate", BankItems_UpdateFrame_OnUpdate)

	elseif event == "PLAYER_MONEY" then
		BankItems_SaveMoney()

	elseif strfind(event, "ZONE_CHANGED") then
		BankItems_SaveZone()

	elseif event == "PLAYER_ENTERING_WORLD" then
		BankItems_SaveInvItems()
		BankItems_SaveMoney()
		BankItems_SaveZone()
		BankItems_Generate_SelfItemCache()

	elseif event == "PLAYERBANKSLOTS_CHANGED" or event == "PLAYERBANKBAGSLOTS_CHANGED" then --fires even when bank is closed

		--"PLAYERBANKSLOTS_CHANGED" will fire when one of the main bank slots changes, an equipped bank bag is changed, or the combination of items in an equipped bank bag changes (permutation doesn't matter)
		if not isBankOpen then
			--[[If multiple items are removed at once (e.g. crafting) the first frame should
			have an event for each item removed. The first event for each item will give the
			first bank slot	the item was removed from and the total count will already be fully
			updated for the item when the event fires even if events for additional bank slots
			for that item haven't fired yet. The additional bank slot events for each item
			could be delayed a few seconds from the first event set.--]]
			if arg1 and bankSlotsToUpdate then
				bankSlotsToUpdate[#bankSlotsToUpdate + 1] = tonumber(arg1)
				BankItems_UpdateFrame:SetScript("OnUpdate", BankItems_UpdateFrame_OnUpdate)
			end
		elseif arg1 and arg1 <= NUM_BANKGENERIC_SLOTS then
			bagsToUpdate.bank = true
			BankItems_UpdateFrame:SetScript("OnUpdate", BankItems_UpdateFrame_OnUpdate)
		end

	elseif event == "BANKFRAME_OPENED" then
		isBankOpen = true
		BankItems_SaveItems()
		BankItems_Generate_SelfItemCache()

	elseif event == "BANKFRAME_CLOSED" then
		-- Hawksy: trying the following two lines (didn't seem to help)
		BankItems_SaveItems()
		BankItems_Generate_SelfItemCache()
		isBankOpen = false

	elseif event == "MAIL_SHOW" then
		BankItems_Frame:RegisterEvent("MAIL_CLOSED")
		self:RegisterEvent("MAIL_INBOX_UPDATE")

	elseif event == "MAIL_INBOX_UPDATE" then
		BankItems_SaveMailbox()
		BankItems_Generate_SelfItemCache()

	elseif event == "MAIL_CLOSED" then
		BankItems_SaveMailbox()
		BankItems_Generate_SelfItemCache()
		self:UnregisterEvent(event)	-- Because it can fire more than once if you walk away from mailbox
		self:UnregisterEvent("MAIL_INBOX_UPDATE")

	elseif event == "MAIL_SEND_SUCCESS" then
		BankItems_Frame_MailSendSuccess()
		BankItems_Generate_ItemCache()
		self:UnregisterEvent(event)

	elseif event == "ADDON_LOADED" and arg1 == "BankItems" then
		BankItems_Initialize()
		BankItems_Generate_ItemCache()
		self:UnregisterEvent(event)

	elseif event == "VARIABLES_LOADED" then
		-- This overrides layout-cache.txt and also ensures all non-LoD addons have already loaded
		BankItems_Initialize()

	end
end

function BankItems_UpdateFrame_OnUpdate(self, elapsed)
	if bagsToUpdate.elap then
		bagsToUpdate.elap = bagsToUpdate.elap - elapsed
	end
	for i = 0, 10 do
		if (bagsToUpdate[i]) then
			BankItems_SaveInvItems(i)
			bagsToUpdate[i] = nil
		end
	end
	if bagsToUpdate.bank then
		-- Hawksy: adding this bit (from retail) seems to fix the bank contents bug -- monitor it
		BankItems_SaveItems(true)
		bagsToUpdate.bank = nil
	end
	if (bagsToUpdate.inv) then
		BankItems_SaveInvItems("inv")
		bagsToUpdate.inv = nil
	end

	BankItems_Generate_SelfItemCache()
	self:SetScript("OnUpdate", nil)
end


----------------------------------
-- Create frames

do
	local temp

	-- Create the main BankItems frame
	BankItems_Frame = CreateFrame("Frame", "BankItems_Frame", UIParent)
	BankItems_Frame:Hide()
	BankItems_Frame:SetWidth(403)
	BankItems_Frame:SetHeight(430)
	BankItems_Frame:SetPoint("TOPLEFT", 50, -104)
	BankItems_Frame:EnableMouse(true)
	BankItems_Frame:SetToplevel(true)
	BankItems_Frame:SetMovable(true)
	BankItems_Frame:SetClampedToScreen(true)

	-- Portrait
	temp = BankItems_Frame:CreateTexture("BankItems_Portrait", "BACKGROUND")
	temp:SetWidth(60)
	temp:SetHeight(60)
	temp:SetPoint("TOPLEFT", 7, -6)

	-- Frame texture
	temp = BankItems_Frame:CreateTexture(nil, "ARTWORK")
	temp:SetWidth(512)
	temp:SetHeight(512)
	temp:SetPoint("TOPLEFT")
	temp:SetTexture("Interface\\BankFrame\\UI-BankFrame")

	-- Overlay frame texture for inventory/equipped/mail bags
	temp = BankItems_Frame:CreateTexture(nil, "OVERLAY")
	temp:SetTexture("Interface\\BankFrame\\UI-BankFrame")
	do
		local left, right, top, bottom
		left = 37
		right = 374
		top = 197
		bottom = 248
		temp:SetWidth(right - left)
		temp:SetHeight(bottom - top)
		temp:SetPoint("TOPLEFT", left, -310)
		temp:SetTexCoord(left/512, right/512, top/512, bottom/512)
	end

	-- Title text
	temp = BankItems_Frame:CreateFontString("BankItems_TitleText", "ARTWORK", "GameFontHighlight")
	temp:SetPoint("CENTER", 0, 192)
	temp:SetJustifyH("CENTER")
	-- Version text
	temp = BankItems_Frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	temp:SetWidth(280)
	temp:SetPoint("TOPLEFT", 80, -38)
	temp:SetJustifyH("LEFT")
	temp:SetText(BANKITEMS_VERSIONTEXT)
	-- Item slots text
	temp = BankItems_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	temp:SetPoint("CENTER", -18, 155)
	temp:SetText(ITEMSLOTTEXT)
	-- Bag slots text
	temp = BankItems_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	temp:SetPoint("CENTER", -18, -43)
	temp:SetText(BAGSLOTTEXT)

	-- Close Button (inherits OnClick script to HideUIPanel(this:GetParent()))
	temp = CreateFrame("Button", "BankItems_CloseButton", BankItems_Frame, "UIPanelCloseButton")
	temp:SetPoint("TOPRIGHT", -50, -8)

	-- Options Button
	temp = CreateFrame("Button", "BankItems_OptionsButton", BankItems_Frame, "GameMenuButtonTemplate")
	temp:SetWidth(85)
	temp:SetHeight(25)
	temp:SetPoint("TOPRIGHT", -70, -40)
	temp:SetText(BANKITEMS_OPTION_TEXT)
	temp:SetScript("OnClick", function()
		if (BankItems_OptionsFrame:IsVisible()) then
			BankItems_OptionsFrame:Hide()
		else
			BankItems_OptionsFrame:Show()
		end
	end)

	-- had problems with ItemButtonTemplate, ItemButton isn't in classic, now seems to work anyway

	-- Create the 28 (classic 24) main bank buttons
	for i = 1, 24 do
		ItemButtonAr[i] = CreateFrame("Button", "BankItems_Item"..i, BankItems_Frame, "ItemButtonTemplate")
		ItemButtonAr[i]:SetID(i)
		if (i == 1) then
			ItemButtonAr[i]:SetPoint("TOPLEFT", 40, -73)
		elseif (mod(i, 6) == 1) then
			ItemButtonAr[i]:SetPoint("TOPLEFT", ItemButtonAr[i-6], "BOTTOMLEFT", 0, -7)
		else
			ItemButtonAr[i]:SetPoint("TOPLEFT", ItemButtonAr[i-1], "TOPRIGHT", 12, 0)
		end
		ItemButtonAr[i].count = _G["BankItems_Item"..i.."Count"]
		ItemButtonAr[i].texture = _G["BankItems_Item"..i.."IconTexture"]
	end

	-- Create the 14 (classic 12) bag buttons
	for _, i in ipairs(BAGNUMBERS) do
		BagButtonAr[i] = CreateFrame("Button", "BankItems_Bag"..i, BankItems_Frame, "ItemButtonTemplate")
		BagButtonAr[i]:SetID(i)
		BagButtonAr[i].isBag = 1
		BagButtonAr[i].HighlightTexture = BagButtonAr[i]:CreateTexture(nil, "OVERLAY")
		BagButtonAr[i].HighlightTexture:Hide()
		BagButtonAr[i].HighlightTexture:SetAllPoints(BagButtonAr[i])
		BagButtonAr[i].HighlightTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
		BagButtonAr[i].HighlightTexture:SetBlendMode("ADD")
		BagButtonAr[i].count = _G["BankItems_Bag"..i.."Count"]
		BagButtonAr[i].texture = _G["BankItems_Bag"..i.."IconTexture"]
	end
	BagButtonAr[5]:SetPoint("TOPLEFT", ItemButtonAr[19], "BOTTOMLEFT", 0, -33) -- top row, bank bags
	BagButtonAr[6]:SetPoint("TOPLEFT", BagButtonAr[5], "TOPRIGHT", 12, 0)
	BagButtonAr[7]:SetPoint("TOPLEFT", BagButtonAr[6], "TOPRIGHT", 12, 0)
	BagButtonAr[8]:SetPoint("TOPLEFT", BagButtonAr[7], "TOPRIGHT", 12, 0)
	BagButtonAr[9]:SetPoint("TOPLEFT", BagButtonAr[8], "TOPRIGHT", 12, 0)
	BagButtonAr[10]:SetPoint("TOPLEFT", BagButtonAr[9], "TOPRIGHT", 12, 0)
	BagButtonAr[100]:SetPoint("TOPLEFT", BagButtonAr[5], "BOTTOMLEFT", 0, -6) -- bottom row, player bags
	BagButtonAr[4]:SetPoint("TOPLEFT", BagButtonAr[100], "TOPRIGHT", 12, 0)
	BagButtonAr[3]:SetPoint("TOPLEFT", BagButtonAr[4], "TOPRIGHT", 12, 0)
	BagButtonAr[2]:SetPoint("TOPLEFT", BagButtonAr[3], "TOPRIGHT", 12, 0)
	BagButtonAr[1]:SetPoint("TOPLEFT", BagButtonAr[2], "TOPRIGHT", 12, 0)
	BagButtonAr[0]:SetPoint("TOPLEFT", BagButtonAr[1], "TOPRIGHT", 12, 0)

	-- Create the Money frame
	---@class MoneyFrame: Frame
	local BankItems_MoneyFrame = CreateFrame("Frame", "BankItems_MoneyFrame", BankItems_Frame, "SmallMoneyFrameTemplate")
	BankItems_MoneyFrame:SetPoint("BOTTOMRIGHT", -60, 20)
	BankItems_MoneyFrame:UnregisterAllEvents()
	BankItems_MoneyFrame:SetScript("OnEvent", nil)
	BankItems_MoneyFrame:SetScript("OnShow", nil)
	BankItems_MoneyFrame.small = 1
	BankItems_MoneyFrame.moneyType = "PLAYER"
	BankItems_MoneyFrame.info = {
		collapse = 1,
		canPickup = 1,
		showSmallerCoins = "Backpack"
	}

	-- Create the Money Total frame
	---@class MoneyFrameTotal: Frame
	local BankItems_MoneyFrameTotal = CreateFrame("Frame", "BankItems_MoneyFrameTotal", BankItems_Frame, "SmallMoneyFrameTemplate")
	BankItems_MoneyFrameTotal:SetPoint("BOTTOMLEFT", 38, 20)
	BankItems_MoneyFrameTotal:UnregisterAllEvents()
	BankItems_MoneyFrameTotal:SetScript("OnEvent", nil)
	BankItems_MoneyFrameTotal:SetScript("OnShow", nil)
	BankItems_MoneyFrameTotal.small = 1
	BankItems_MoneyFrameTotal.moneyType = "PLAYER"
	BankItems_MoneyFrameTotal.info = {
		collapse = 1,
		showSmallerCoins = "Backpack"
	}
	local BankItems_TotalMoneyText = BankItems_MoneyFrameTotal:CreateFontString("BankItems_TotalMoneyText", "BACKGROUND", "GameFontHighlightSmall")
	BankItems_TotalMoneyText:SetText("(total)")
	BankItems_TotalMoneyText:SetJustifyH("LEFT")
	BankItems_TotalMoneyText:SetPoint("LEFT", "BankItems_MoneyFrameTotalCopperButton", "RIGHT")

	-- Create the 14 (classic 12) bags
	for _, i in ipairs(BAGNUMBERS) do
		local name = "BankItems_ContainerFrame"..i
		BagContainerAr[i] = CreateFrame("Frame", name, UIParent)
		BagContainerAr[i]:SetID(i)
		BagContainerAr[i]:Hide()
		BagContainerAr[i]:EnableMouse(true)
		BagContainerAr[i]:SetToplevel(true)
		BagContainerAr[i]:SetMovable(true)
		BagContainerAr[i]:SetFrameStrata("MEDIUM")
		BagContainerAr[i].portrait = BagContainerAr[i]:CreateTexture(name.."Portrait", "BACKGROUND")
		BagContainerAr[i].portrait:SetWidth(40)
		BagContainerAr[i].portrait:SetHeight(40)
		BagContainerAr[i].portrait:SetPoint("TOPLEFT", 7, -5)
		BagContainerAr[i].backgroundtop = BagContainerAr[i]:CreateTexture(name.."BackgroundTop", "ARTWORK")
		BagContainerAr[i].backgroundtop:SetWidth(256)
		BagContainerAr[i].backgroundtop:SetPoint("TOPRIGHT")
		BagContainerAr[i].backgroundmiddle1 = BagContainerAr[i]:CreateTexture(name.."BackgroundMiddle1", "ARTWORK")
		BagContainerAr[i].backgroundmiddle1:SetWidth(256)
		BagContainerAr[i].backgroundmiddle1:SetPoint("TOP", BagContainerAr[i].backgroundtop, "BOTTOM")
		BagContainerAr[i].backgroundmiddle2 = BagContainerAr[i]:CreateTexture(name.."BackgroundMiddle2", "ARTWORK")
		BagContainerAr[i].backgroundmiddle2:SetWidth(256)
		BagContainerAr[i].backgroundmiddle2:SetPoint("TOP", BagContainerAr[i].backgroundmiddle1, "BOTTOM")
		BagContainerAr[i].backgroundbottom = BagContainerAr[i]:CreateTexture(name.."BackgroundBottom", "ARTWORK")
		BagContainerAr[i].backgroundbottom:SetWidth(256)
		BagContainerAr[i].backgroundbottom:SetHeight(10)
		BagContainerAr[i].backgroundbottom:SetTexCoord(0, 1, 0.330078125, 0.349609375)
		BagContainerAr[i].backgroundbottom:SetPoint("TOP", BagContainerAr[i].backgroundmiddle2, "BOTTOM")
		BagContainerAr[i].name = BagContainerAr[i]:CreateFontString(name.."Name", "ARTWORK", "GameFontHighlight")
		BagContainerAr[i].name:SetWidth(112)
		BagContainerAr[i].name:SetHeight(12)
		BagContainerAr[i].name:SetPoint("TOPLEFT", 47, -10)
		for j = 1, 36 do
			BagContainerAr[i][j] = CreateFrame("Button", name.."Item"..j, BagContainerAr[i], "ItemButtonTemplate")
			BagContainerAr[i][j]:SetID(j)
			BagContainerAr[i][j].count = _G[name.."Item"..j.."Count"]
			BagContainerAr[i][j].texture = _G[name.."Item"..j.."IconTexture"]
		end
		BagContainerAr[i].PortraitButton = CreateFrame("Button", name.."PortraitButton", BagContainerAr[i])
		BagContainerAr[i].PortraitButton:SetWidth(40)
		BagContainerAr[i].PortraitButton:SetHeight(40)
		BagContainerAr[i].PortraitButton:SetPoint("TOPLEFT", 7, -5)
		BagContainerAr[i].CloseButton = CreateFrame("Button", name.."CloseButton", BagContainerAr[i], "UIPanelCloseButton")
		BagContainerAr[i].CloseButton:SetPoint("TOPRIGHT", 0, -2)
	end

	-- Create the Show All Realms checkbox
	local BankItems_ShowAllRealms_Check = CreateFrame("CheckButton", "BankItems_ShowAllRealms_Check", BankItems_Frame, "UICheckButtonTemplate")
	BankItems_ShowAllRealms_Check:SetPoint("BOTTOMLEFT", 30, 40)
	BankItems_ShowAllRealms_Check:SetHitRectInsets(0, -100, 0, 0)
	BankItems_ShowAllRealms_Check:SetChecked(allRealms == true)
	_G[BankItems_ShowAllRealms_Check:GetName() .. "Text"]:SetText(BANKITEMS_ALLREALMS_TEXT)
	BankItems_ShowAllRealms_Check:SetScript("OnClick", function(self)
		allRealms = self:GetChecked()
		if (allRealms) then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		else
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		end
		BankItems_UserDropdownGenerateKeys()
		BankItems_UpdateMoney()
		CloseDropDownMenus()
	end)

	-- Create the User Dropdown
	local BankItems_UserDropdown = CreateFrame("Frame", "BankItems_UserDropdown", BankItems_Frame, "UIDropDownMenuTemplate")
	BankItems_UserDropdown:SetPoint("TOPRIGHT", BankItems_Frame, "BOTTOMRIGHT", -110, 69)
	BankItems_UserDropdown:SetHitRectInsets(16, 16, 0, 0)
	UIDropDownMenu_SetWidth(BankItems_UserDropdown, 140)
	UIDropDownMenu_EnableDropDown(BankItems_UserDropdown)

	-- Create the Export Button
	local BankItems_ExportButton = CreateFrame("Button", "BankItems_ExportButton", BankItems_Frame)
	BankItems_ExportButton:SetWidth(32)
	BankItems_ExportButton:SetHeight(32)
	BankItems_ExportButton:SetPoint("TOPRIGHT", BankItems_Frame, "BOTTOMRIGHT", -93, 71)
	BankItems_ExportButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	BankItems_ExportButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	BankItems_ExportButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	BankItems_ExportButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

	-- Create the Search Button
	local BankItems_SearchButton = CreateFrame("Button", "BankItems_SearchButton", BankItems_Frame)
	BankItems_SearchButton:SetWidth(32)
	BankItems_SearchButton:SetHeight(32)
	BankItems_SearchButton:SetPoint("TOPRIGHT", BankItems_Frame, "BOTTOMRIGHT", -65, 71)
	BankItems_SearchButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	BankItems_SearchButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	BankItems_SearchButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
	BankItems_SearchButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

	-- Create the Next Mail page button in bag 101
--	local BankItems_NextMailButton = CreateFrame("Button", "BankItems_NextMailButton", BagContainerAr[101])
--	BankItems_NextMailButton:SetWidth(32)
--	BankItems_NextMailButton:SetHeight(32)
--	BankItems_NextMailButton:SetPoint("TOPLEFT", 70, -22)
--	BankItems_NextMailButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
--	BankItems_NextMailButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
--	BankItems_NextMailButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
--	BankItems_NextMailButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

	-- Create the Prev Mail page button in bag 101
--	local BankItems_PrevMailButton = CreateFrame("Button", "BankItems_PrevMailButton", BagContainerAr[101])
--	BankItems_PrevMailButton:SetWidth(32)
--	BankItems_PrevMailButton:SetHeight(32)
--	BankItems_PrevMailButton:SetPoint("TOPLEFT", 45, -22)
--	BankItems_PrevMailButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
--	BankItems_PrevMailButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
--	BankItems_PrevMailButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
--	BankItems_PrevMailButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

	-- Create the mail text in bag 101
--	BagContainerAr[101].mailtext = BagContainerAr[101]:CreateFontString("BankItems_ContainerFrame101_MailText", "ARTWORK", "GameFontHighlight")
--	BagContainerAr[101].mailtext:SetPoint("BOTTOMRIGHT", BagContainerAr[101], "TOPLEFT", 95, -64)
--	BagContainerAr[101].mailtext:SetText("1 - 18 / 18")
--	BagContainerAr[101].mailtext:SetJustifyH("RIGHT")

	-- Create a frame for doing OnUpdates, this isn't used for anything else or shown
	-- This is to reduce the number of times BankItems records bag/worn item changes
	BankItems_UpdateFrame = CreateFrame("Frame")
end


------------------------------------------------------
-- Utility functions

-- Trims leading and trailing whitespace from a string
function BankItems_Trim(s)
	return gsub(s, "^%s*(.-)%s*$", "%1")
end

-- Prints a chat message
function BankItems_Chat(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("<BankItems> "..msg, 1, 1, 0)
	end
end

-- Extracts the itemName out from a full itemLink
function BankItems_ParseLink(link)
	return strmatch(link, "%[(.*)%]") or link
end

-- Returns the string representation of money
function BankItem_ParseMoney(money)
	local g, s, c
	g = floor(money / 10000)
	money = mod(money, 10000)
	s = floor(money / 100)
	money = mod(money, 100)
	c = mod(money, 100)
	return g.."g "..s.."s "..c.."c"
end

-- Table Pool for recycling tables
local tablePool = {}
setmetatable(tablePool, {__mode = "kv"})	-- Weak table

-- Get a new table
local function newTable()
	local t = next(tablePool) or {}
	tablePool[t] = nil
	return t
end

-- Delete table and add to table pool
local function delTable(t)
	if (type(t) == "table") then
		for k, v in pairs(t) do
			if (type(v) == "table") then
				delTable(v)	-- child tables get put into the pool
			end
			t[k] = nil
		end
		setmetatable(t, nil)
		t[true] = true
		t[true] = nil
		tablePool[t] = true
	end
	return nil
end


------------------------------------------------------
-- BankItems functions

function BankItems_SlashHandler(msg)
	msg = strtrim(strlower(msg or ""))
	local allBags

	if ( msg == "showbutton" ) then
		BankItems_Save.ButtonShown = true
		BankItems_MinimapButton_Init()
		return
	elseif ( msg == "hidebutton" ) then
		BankItems_Save.ButtonShown = false
		BankItems_MinimapButton_Init()
		return
	elseif ( strfind(msg, "search (.*)") ) then
		local searchText = strtrim(strmatch(msg, "search (.*)"))
		_G["BankItems_ExportFrame_SearchTextbox"]:SetText(searchText)
		_G["BankItems_ExportFrame_SearchTextbox"]:ClearFocus()
		BankItems_Search(searchText)
		BankItems_ExportFrame:Show()
		return
	elseif ( msg == "clear" ) then
		BankItems_DelPlayer(bankPlayerName)
		BankItems_UserDropdown_OnClick(nil, selfPlayerName)
		if bankPlayerName == selfPlayerName then
			BankItems_Generate_SelfItemCache()
		else
			BankItems_Generate_ItemCache()
		end
		return
	elseif ( msg == "clearall" ) then
		-- Cannot use this loop to delete yourself because a new table is created
		-- for yourself and results in undefined behavior for this pairs() loop
		for key, value in pairs(BankItems_Save) do
			if (type(value) == "table" and key ~= selfPlayerName and key ~= "Behavior") then
				BankItems_DelPlayer(key)
			end
		end
		-- Now delete yourself
		BankItems_DelPlayer(selfPlayerName)
		BankItems_Chat(BANKITEMS_ALL_DELETED_TEXT)
		BankItems_UserDropdown_OnClick(nil, selfPlayerName)
		BankItems_Generate_ItemCache()
		BankItems_Generate_SelfItemCache()
		return
	elseif (msg == "all") then
		allBags = 3
	elseif (msg == "allbank") then
		allBags = 2
	elseif (msg == "") then
		allBags = BankItems_Save.Behavior
	else
		-- Invalid option, show help text
		BankItems_Chat(BANKITEMS_VERSIONTEXT)
		BankItems_Chat(BANKITEMS_HELPTEXT1)
		BankItems_Chat(BANKITEMS_HELPTEXT2)
		BankItems_Chat(BANKITEMS_HELPTEXT3)
		BankItems_Chat(BANKITEMS_HELPTEXT4)
		BankItems_Chat(BANKITEMS_HELPTEXT5)
		BankItems_Chat(BANKITEMS_HELPTEXT6)
		BankItems_Chat(BANKITEMS_HELPTEXT7)
		BankItems_Chat(BANKITEMS_HELPTEXT8)
		return
	end

	if (BankItems_Frame:IsVisible()) then
		HideUIPanel(BankItems_Frame)
	else
		ShowUIPanel(BankItems_Frame)
		if (allBags == 3) then
			BankItems_OpenBagsByBehavior(true, true, false)
		elseif (allBags == 2) then
			BankItems_OpenBagsByBehavior(true, false, false)
		else
			BankItems_OpenBagsByBehavior(unpack(BankItems_Save.Behavior))
		end
	end
end

function BankItems_Initialize()
	-- Set variables about self
	selfPlayerRealm = BankItems_Trim(GetRealmName())
	selfPlayerName = UnitName("player").."|"..selfPlayerRealm
	BankItems_Save[selfPlayerName] = BankItems_Save[selfPlayerName] or newTable()
	selfPlayer = BankItems_Save[selfPlayerName]

	-- Initial player to display is self
	BankItems_SetPlayer(selfPlayerName)

	BankItems_UserDropdownGenerateKeys()
	_G["BankItems_UserDropdown"].initialize = BankItems_UserDropdown_Initialize
	_G["BankItems_UserDropdown"].selectedValue = selfPlayerName
	_G["BankItems_UserDropdownText"]:SetText(gsub(selfPlayerName, "|", " of "))

	if (not BankItems_Save.pospoint) then
		--BankItems_Save.pospoint = "TOPLEFT"
		--BankItems_Save.posrelpoint = "TOPLEFT"
		--BankItems_Save.posoffsetx = 50
		--BankItems_Save.posoffsety = -104
		BankItems_Save.pospoint = "CENTER"
		BankItems_Save.posrelpoint = "CENTER"
		BankItems_Save.posoffsetx = 0
		BankItems_Save.posoffsety = -0
	end
	--BankItems_Frame:SetPoint(BankItems_Save.pospoint, UIParent, BankItems_Save.posrelpoint, BankItems_Save.posoffsetx, BankItems_Save.posoffsety)
	BankItems_Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)


	-- Upgrade behavior
	if (type(BankItems_Save.Behavior) == "number") then
		local temp = {false, false, false}
		if (BankItems_Save.Behavior == 2) then
			temp[1] = true
		elseif (BankItems_Save.Behavior == 3) then
			temp[1] = true
			temp[2] = true
		end
		BankItems_Save.Behavior = temp
	elseif (type(BankItems_Save.Behavior) ~= "table") then
		BankItems_Save.Behavior = {false, false, false}
	end
end

function BankItems_SetPlayer(playerName)
	if (not BankItems_Save[playerName]) then
		BankItems_Chat(BANKITEMS_NO_DATA_TEXT..playerName)
		return
	end
	bankPlayerName = playerName
	bankPlayer = BankItems_Save[playerName]
end

function BankItems_DelPlayer(playerName)
	-- Need to check selfPlayer reference
	if (selfPlayer == BankItems_Save[playerName]) then
		-- Deleting yourself
		delTable(BankItems_Save[playerName])
		BankItems_Save[playerName] = nil
		selfPlayer = nil

		-- Create new table and reassign references to it
		BankItems_Save[selfPlayerName] = newTable()
		selfPlayer = BankItems_Save[selfPlayerName]
		bankPlayer = selfPlayer
		bankPlayerName = selfPlayerName

		-- Save data about self again
		if (isBankOpen) then
			BankItems_SaveItems()
		end
		BankItems_SaveInvItems()
		BankItems_SaveMoney()
		BankItems_SaveZone()
	else
		-- Deleting someone else
		delTable(BankItems_Save[playerName])
		BankItems_Save[playerName] = nil

		BankItems_UserDropdownGenerateKeys()
	end
end

function BankItems_SaveMoney()
	selfPlayer.money = GetMoney()
	if (BankItems_Frame:IsVisible()) then
		BankItems_UpdateMoney()
	end
end

function BankItems_SaveZone()
	selfPlayer.location = GetRealZoneText()
	if ( BankItems_Frame:IsVisible() and bankPlayer == selfPlayer ) then
		_G["BankItems_TitleText"]:SetText(gsub(bankPlayerName, "|", " of ").." ("..bankPlayer.location..")")
	end
end

function BankItems_SaveItems()
	local itemLink, bagNum_ID
	if (isBankOpen) then
		for num = 1, 24 do
			itemLink = GetContainerItemLink(BANK_CONTAINER, num)
			if (itemLink) then
				selfPlayer[num] = selfPlayer[num] or newTable()
				selfPlayer[num].icon, selfPlayer[num].count = GetContainerItemInfo(BANK_CONTAINER, num)
				selfPlayer[num].link = itemLink
			else
				delTable(selfPlayer[num])
				selfPlayer[num] = nil
			end
		end
		for bagNum = 5, 10 do
			bagNum_ID = BankButtonIDToInvSlotID(bagNum, 1) - 4
			itemLink = GetInventoryItemLink("player", bagNum_ID)
			if (itemLink) then
				selfPlayer["Bag"..bagNum] = selfPlayer["Bag"..bagNum] or newTable()
				local theBag = selfPlayer["Bag"..bagNum]
				theBag.link = itemLink
				theBag.icon = GetInventoryItemTexture("player", bagNum_ID)
				theBag.size = C_Container.GetContainerNumSlots(bagNum)
				for bagItem = 1, theBag.size do
					itemLink = GetContainerItemLink(bagNum, bagItem)
					if (itemLink) then
						theBag[bagItem] = theBag[bagItem] or newTable()
						theBag[bagItem].link = itemLink
						theBag[bagItem].icon, theBag[bagItem].count = GetContainerItemInfo(bagNum, bagItem)
					else
						delTable(theBag[bagItem])
						theBag[bagItem] = nil
					end
				end
			else
				delTable(selfPlayer["Bag"..bagNum])
				selfPlayer["Bag"..bagNum] = nil
				if (bankPlayer == selfPlayer) then
					BagContainerAr[bagNum]:Hide()
				end
			end
		end
	end
	if (BankItems_Frame:IsVisible()) then
		BankItems_PopulateFrame()
		for i = 5, 10 do
			if (BagContainerAr[i]:IsVisible()) then
				BankItems_PopulateBag(i)
			end
		end
	end
end

function BankItems_SaveInvItems(bagID)
	-- valid inputs to function: integer indicating bagID to update, or string "inv" to update worn items
	-- or nil to update all bags and worn items
	local startBag, endBag
	local itemLink, bagNum_ID

	-- if bagID is present, only update that bag
	if (bagID == "inv") then
		startBag = 1	-- don't record any bags, the loop won't run from 1 to 0
		endBag = 0
	elseif (bagID) then
		if (not isBankOpen and bagID > 4) then
			return		-- Don't update bank bags if bank isn't open
		end
		startBag = bagID
		endBag = bagID
	else
		startBag = 0
		endBag = 4
	end

	selfPlayer["NumBankSlots"] = GetNumBankSlots()
	for bagNum = startBag, endBag do
		local bagString = "Bag"..bagNum

		if (bagNum == 0) then
			-- Backpack (bag 0)
			selfPlayer[bagString] = selfPlayer[bagString] or newTable()
			selfPlayer[bagString].link = nil
			selfPlayer[bagString].icon = "Interface\\Buttons\\Button-Backpack-Up"
			selfPlayer[bagString].size = C_Container.GetContainerNumSlots(bagNum)
		else
			bagNum_ID = C_Container.ContainerIDToInventoryID(bagNum)
			itemLink = GetInventoryItemLink("player", bagNum_ID)
			if (itemLink) then
				selfPlayer[bagString] = selfPlayer[bagString] or newTable()
				selfPlayer[bagString].link = itemLink
				selfPlayer[bagString].icon = GetInventoryItemTexture("player", bagNum_ID)
				selfPlayer[bagString].size = C_Container.GetContainerNumSlots(bagNum)
			else
				delTable(selfPlayer[bagString])
				selfPlayer[bagString] = nil
				if (bankPlayer == selfPlayer) then
					BagContainerAr[bagNum]:Hide()
				end
			end
		end

		local theBag = selfPlayer[bagString]
		if (theBag) then
			for bagItem = 1, theBag.size do
				itemLink = GetContainerItemLink(bagNum, bagItem)
				if (itemLink) then
					theBag[bagItem] = theBag[bagItem] or newTable()
					theBag[bagItem].link = itemLink
					theBag[bagItem].icon, theBag[bagItem].count = GetContainerItemInfo(bagNum, bagItem)
				else
					delTable(theBag[bagItem])
					theBag[bagItem] = nil
				end
			end
		end

		if (bankPlayer == selfPlayer and BagContainerAr[bagNum]:IsVisible()) then
			BankItems_PopulateBag(bagNum)
		end
	end

	if (not bagID or bagID == "inv") then
		-- Save equipped items as bag 100
		selfPlayer.Bag100 = selfPlayer.Bag100 or newTable()
		local theBag = selfPlayer.Bag100
		theBag.link = nil
		theBag.icon = "Interface\\Icons\\INV_Shirt_White_01"
		theBag.size = 20
		for invNum = 0, 19 do
			theBag[invNum] = theBag[invNum] or newTable()
			theBag[invNum].link = GetInventoryItemLink("player", invNum)
			theBag[invNum].icon = GetInventoryItemTexture("player", invNum)
			theBag[invNum].count = GetInventoryItemCount("player", invNum)
		end

		if (bankPlayer == selfPlayer and BagContainerAr[100]:IsVisible()) then
			BankItems_PopulateBag(100)
		end
	end
end

function BankItems_SaveMailbox()
	local _, sender, money, daysLeft, itemCount, name, count, itemPointer
	local numItems, totalItems = GetInboxNumItems()
	local j, moneyTotal, subCount = 0, 0, 0
	local theTime = time()
	-- Save mailbox items as bag 101 [Hawksy: but will not display as a bag]
	selfPlayer.Bag101 = selfPlayer.Bag101 or newTable()
	selfPlayer.Bag101.icon = "Interface\\MailFrame\\Mail-Icon"
	selfPlayer.Bag101.time = theTime
	for i = 1, numItems do
		_, _, sender, _, money, _, daysLeft, itemCount = GetInboxHeaderInfo(i)
		moneyTotal = moneyTotal + money
		if itemCount then
			for k = 1, ATTACHMENTS_MAX_RECEIVE do
				name, _, _, count = GetInboxItem(i, k)
				if name then
					j = j + 1
					selfPlayer.Bag101[j] = selfPlayer.Bag101[j] or newTable()
					itemPointer = selfPlayer.Bag101[j]
					itemPointer.link = GetInboxItemLink(i, k)
					itemPointer.count = count
					itemPointer.expiry = theTime + floor(daysLeft*60*60*24)
					if InboxItemCanDelete(i) then -- item is returnable
						itemPointer.deleted = true
						itemPointer.returned = nil
					else
						itemPointer.deleted = nil
						itemPointer.returned = true
--						if sender then sender, subCount = sender:gsub("-","|",1) end --mail received from character on connected realm
--						if sender and subCount == 0 then sender = sender.."|"..selfPlayerRealm end --mail received from character on own realm
						if BankItems_Save[sender] then itemPointer.returnChar = sender end
					end
				end
			end
		end
	end
	if moneyTotal > 0 then
		j = j + 1
		selfPlayer.Bag101[j] = selfPlayer.Bag101[j] or newTable()
		itemPointer = selfPlayer.Bag101[j]
		itemPointer.link = moneyTotal
		itemPointer.icon = GetCoinIcon(moneyTotal)
		itemPointer.count = 1
	end

	for i = #selfPlayer.Bag101, j+1, -1 do
		delTable(tremove(selfPlayer.Bag101))
	end

	selfPlayer.Bag101.size = j -- when not displaying the mail as a bag, no constraints on bag size

	if bankPlayer == selfPlayer and BagContainerAr[101] then
		BankItems_PopulateBag(101)
	end

	selfPlayer.Bag101.outOfDate = nil
end

function BankItems_OpenBagsByBehavior(bank, inv, equip)
	if inv then
		for i = 0, 4 do
			BagContainerAr[i]:Hide()
			BagButtonAr[i]:Click()
		end
	end
	if bank then
		for i = 5, 10 do
			BagContainerAr[i]:Hide()
			BagButtonAr[i]:Click()
		end
	end
	if equip then
		BagContainerAr[100]:Hide()
		BagButtonAr[100]:Click()
	end
--	if (mail) then
--		BagContainerAr[101]:Hide()
--		BagButtonAr[101]:Click()
--	end
end

function BankItems_UpdateMoney()
	-- Check if bankPlayer is nil or doesn't have the money field
	if not bankPlayer or bankPlayer.money == nil then
		return
	end

	local total = 0
	for key, value in pairs(BankItems_Save) do
		if (type(value) == "table" and key ~= "Behavior") then
			local _, realm = strsplit("|", key)
			if (allRealms or realm == selfPlayerRealm) then
				total = total + (value.money or 0)
			end
		end
	end
	MoneyFrame_Update("BankItems_MoneyFrameTotal", total)
	MoneyFrame_Update("BankItems_MoneyFrame", bankPlayer.money or 0)
end

function BankItems_PopulateFrame()
	if not bankPlayer or bankPlayer.money == nil then
		error("[BankItems_PopulateFrame] bankPlayer is nil or lacks a money field")
	end

	-- Portrait
	if bankPlayer == selfPlayer then
		SetPortraitTexture(BankItems_Portrait, "player")
	else
		_G["BankItems_Portrait"]:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
	end
	-- 24 bank slots
	for i = 1, 24 do
		if ( bankPlayer[i] ) then
			ItemButtonAr[i].texture:SetTexture(bankPlayer[i].icon)

			local nCount = bankPlayer[i].count or 0;
			if (nCount > 1) then
				ItemButtonAr[i].count:Show()
				ItemButtonAr[i].count:SetText(bankPlayer[i].count)
			else
				ItemButtonAr[i].count:Hide()
			end
		else
			ItemButtonAr[i].texture:SetTexture()
			ItemButtonAr[i].count:Hide()
		end
	end
	-- 12 bag slots
	for i = 0, 10 do
		if ( bankPlayer["Bag"..i] and bankPlayer["Bag"..i].icon ) then
			BagButtonAr[i].texture:SetTexture(bankPlayer["Bag"..i].icon)
			BagButtonAr[i].texture:SetVertexColor(1, 1, 1)
		else
			BagButtonAr[i].texture:SetTexture("Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag")
			if (i >= 5) then
				if (bankPlayer["NumBankSlots"] and (i - 4) <= bankPlayer["NumBankSlots"]) then
					BagButtonAr[i].texture:SetVertexColor(1, 1, 1)
				else
					BagButtonAr[i].texture:SetVertexColor(1, 0.1, 0.1)
				end
			else
				BagButtonAr[i].texture:SetVertexColor(1, 1, 1)
			end
		end
		BagButtonAr[i]:Show()
	end
	-- Equipped items
	BagButtonAr[100].texture:SetTexture("Interface\\Icons\\INV_Shirt_White_01")
	BagButtonAr[100].texture:SetVertexColor(1, 1, 1)
	BagButtonAr[100]:Show()
	-- Mail items
--	BagButtonAr[101].texture:SetTexture("Interface\\MailFrame\\Mail-Icon")
--	BagButtonAr[101].texture:SetVertexColor(1, 1, 1)
--	BagButtonAr[101]:Show()
	-- Money
	BankItems_UpdateMoney()
	-- Location
	if ( bankPlayer.location ) then
		_G["BankItems_TitleText"]:SetText(gsub(bankPlayerName, "|", " of ").." ("..bankPlayer.location..")")
	else
		_G["BankItems_TitleText"]:SetText(gsub(bankPlayerName, "|", " of "))
	end
end

function BankItems_PopulateBag(bagID)
	local _, button, theBag, idx, textureName
	theBag = bankPlayer["Bag"..bagID]
	if theBag and theBag.size then
		for bagItem = 1, theBag.size do
			button = BagContainerAr[bagID][bagItem]
			idx = theBag.size - (bagItem - 1)
			if (bagID == 100 and idx == 20) then	-- Treat slot 20 as slot 0 (ammo slot)
				idx = 0
--			elseif (bagID == 101) then		-- Adjust for page number
--				idx = idx + (mailPage - 1) * 18
--				BagContainerAr[101].mailtext:SetText(((mailPage - 1) * 18 + 1).." - "..min(mailPage * 18, #bankPlayer.Bag101).." / "..#bankPlayer.Bag101)
--				if (theBag.size >= 18) then
--					BagContainerAr[101].mailtext:Show()
--					BankItems_NextMailButton:Show()
--					BankItems_PrevMailButton:Show()
--				else
--					BagContainerAr[101].mailtext:Hide()
--					BankItems_NextMailButton:Hide()
--					BankItems_PrevMailButton:Hide()
--				end
			end
			if (theBag[idx]) then
				if (bagID == 100) then
					_, textureName = GetInventorySlotInfo(BANKITEMS_INVSLOT[idx]:upper()) --The function is case insensitive, but the type system doesn't know that.
				end
				button.texture:SetTexture(theBag[idx].icon or textureName)
				if (theBag[idx].count > 1) then
					button.count:Show()
					button.count:SetText(theBag[idx].count)
				else
					button.count:Hide()
				end
			else
				button.texture:SetTexture()
				button.count:Hide()
			end
		end
	end
end

function BankItemsUpdateCFrameAnchors()
	local BANKITEMS_BOTTOM_SCREEN_LIMIT2 = BANKITEMS_BOTTOM_SCREEN_LIMIT / BankItems_Frame:GetScale()  -- scale it
	local prevBag, currBag, colBag
	local freeScreenHeight = BankItems_Frame:GetBottom() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
	local col

	-- First bag
	if BankItemsCFrames.bags[1] then
		prevBag = _G[BankItemsCFrames.bags[1]]
		colBag = prevBag
		if freeScreenHeight < prevBag:GetHeight() then
			-- No space in column 1, so anchor in column 3
			prevBag:SetPoint("TOPLEFT", BankItems_Frame, "TOPRIGHT", 0, 0)
			freeScreenHeight = BankItems_Frame:GetTop() - prevBag:GetHeight() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
			col = 3
		else
			-- Anchor in column 1
			prevBag:SetPoint("TOPLEFT", BankItems_Frame, "BOTTOMLEFT", 8, 0)
			freeScreenHeight = freeScreenHeight - prevBag:GetHeight()
			col = 1
		end
	end

	local index = 2
	while BankItemsCFrames.bags[index] do
		-- Anchor current bag to the previous bag
		currBag = getglobal(BankItemsCFrames.bags[index])
		if not currBag then
			error("currBag is nil")
		end

		if freeScreenHeight < currBag:GetHeight() then
			-- No space, so anchor in next column
			if col == 1 then
				-- Check column 2
				freeScreenHeight = BankItems_Frame:GetBottom() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
				if freeScreenHeight < currBag:GetHeight() then
					-- No space in column 2, so anchor in column 3
					currBag:SetPoint("TOPLEFT", BankItems_Frame, "TOPRIGHT", 0, 0)
					freeScreenHeight = BankItems_Frame:GetTop() - currBag:GetHeight() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
				else
					-- Anchor in column 2
					currBag:SetPoint("TOPLEFT", colBag, "TOPRIGHT", 0, 0)
					freeScreenHeight = BankItems_Frame:GetBottom() - currBag:GetHeight() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
				end
			elseif col == 2 then
				-- Anchor in column 3
				currBag:SetPoint("TOPLEFT", BankItems_Frame, "TOPRIGHT", 0, 0)
				freeScreenHeight = BankItems_Frame:GetTop() - currBag:GetHeight() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
			else
				-- Anchor in next column relative to colBag
				currBag:SetPoint("TOPLEFT", colBag, "TOPRIGHT", 0, 0)
				freeScreenHeight = BankItems_Frame:GetTop() - currBag:GetHeight() - BANKITEMS_BOTTOM_SCREEN_LIMIT2
			end
			colBag = currBag
			col = col + 1
		else
			-- Anchor below prevBag
			currBag:SetPoint("TOPLEFT", prevBag, "BOTTOMLEFT", 0, 0)
			freeScreenHeight = freeScreenHeight - currBag:GetHeight()
		end

		prevBag = currBag
		index = index + 1
	end
end

function BankItems_updateContainerFrameAnchors()
	local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column
	local screenWidth = GetScreenWidth()
	local containerScale = 1
	local leftLimit = 0
	if BankFrame:IsVisible() then
		leftLimit = BankFrame:GetRight() - 25
	end
	if BankItems_Frame:IsVisible() then
		if leftLimit < BankItems_Frame:GetRight() * BankItems_Frame:GetScale() then
			leftLimit = BankItems_Frame:GetRight() * BankItems_Frame:GetScale()
		end
	end

	while containerScale > CONTAINER_SCALE do
		screenHeight = GetScreenHeight() / containerScale
		-- Adjust the start anchor for bags depending on the multibars
		xOffset = CONTAINER_OFFSET_X / containerScale
		yOffset = CONTAINER_OFFSET_Y / containerScale
		-- freeScreenHeight determines when to start a new column of bags
		freeScreenHeight = screenHeight - yOffset
		leftMostPoint = screenWidth - xOffset
		column = 1
		local frameHeight
		for index, frameName in ipairs(ContainerFrame1.bags) do
			frameHeight = _G[frameName]:GetHeight()
			if freeScreenHeight < frameHeight then
				-- Start a new column
				column = column + 1
				leftMostPoint = screenWidth - ( column * CONTAINER_WIDTH * containerScale ) - xOffset
				freeScreenHeight = screenHeight - yOffset
			end
			freeScreenHeight = freeScreenHeight - frameHeight - VISIBLE_CONTAINER_SPACING
		end
		if leftMostPoint < leftLimit then
			containerScale = containerScale - 0.01
		else
			break
		end
	end

	if containerScale < CONTAINER_SCALE then
		containerScale = CONTAINER_SCALE
	end

	screenHeight = GetScreenHeight() / containerScale
	-- Adjust the start anchor for bags depending on the multibars
	xOffset = CONTAINER_OFFSET_X / containerScale
	yOffset = CONTAINER_OFFSET_Y / containerScale
	-- freeScreenHeight determines when to start a new column of bags
	freeScreenHeight = screenHeight - yOffset
	column = 0
	for index, frameName in ipairs(ContainerFrame1.bags) do
		frame = getglobal(frameName)
		if not frame then
			error("frame is nil")
		end

		frame:SetScale(containerScale)
		if index == 1 then
			-- First bag
			frame:SetPoint("BOTTOMRIGHT", frame:GetParent(), "BOTTOMRIGHT", -xOffset, yOffset )
		elseif freeScreenHeight < frame:GetHeight() then
			-- Start a new column
			column = column + 1
			freeScreenHeight = screenHeight - yOffset
			frame:SetPoint("BOTTOMRIGHT", frame:GetParent(), "BOTTOMRIGHT", -(column * CONTAINER_WIDTH) - xOffset, yOffset )
		else
			-- Anchor to the previous bag
			frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, CONTAINER_SPACING)
		end
		freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING
	end
end

function BankItems_UserDropdown_Sort(a, b)
	-- Sorting code courtesy of doxxx
	local nameA, realmA = strsplit("|", a)
	local nameB, realmB = strsplit("|", b)
	if nameA == nameB then
		return realmA < realmB
	else
		return nameA < nameB
	end
end

function BankItems_UserDropdownGenerateKeys()
	for k, v in pairs(sortedKeys) do
		sortedKeys[k] = nil
	end
	for key, value in pairs(BankItems_Save) do
		if (type(value) == "table" and key ~= "Behavior") then
			local _, realm = strsplit("|", key)
			if (allRealms or realm == selfPlayerRealm) then
				table.insert(sortedKeys, key)
			end
		end
	end
	table.sort(sortedKeys, BankItems_UserDropdown_Sort)
end

function BankItems_UserDropdown_OnClick(button, playerName, text)
	text = text or gsub(playerName, "|", " of ")
	CloseDropDownMenus()
	_G["BankItems_UserDropdownText"]:SetText(text)
	_G["BankItems_UserDropdownText"].selectedValue = playerName
	BankItems_SetPlayer(playerName)

	BankItems_Frame_OnHide()
	BankItems_PopulateFrame()
	BankItems_OpenBagsByBehavior(unpack(BankItems_Save.Behavior))
end

function BankItems_UserDropdown_Initialize()
	for _, key in ipairs(sortedKeys) do
		info.text = gsub(key, "|", " of ")
		info.arg1 = key
		info.arg2 = info.text
		info.func = BankItems_UserDropdown_OnClick
		info.checked = (bankPlayerName == info.arg1)
		UIDropDownMenu_AddButton(info)
	end
end

function BankItems_GenerateExportText()
	local text = "Contents of "..gsub(bankPlayerName, "|", " of ").."\n\n"
	local prefix = ""
	local errorflag = false
	BankItems_ExportFrame.mode = "export"
	_G["BankItems_ExportFrame_ResetButton"]:SetText(BANKITEMS_RESET_TEXT)
	_G["BankItems_ExportFrame_SearchTextbox"]:Hide()
	_G["BankItems_ExportFrame_SearchAllRealms"]:Hide()
	_G["BankItems_ExportFrame_ShowBagPrefix"]:SetChecked(BankItems_Save.ExportPrefix)
	_G["BankItems_ExportFrame_GroupData"]:SetChecked(BankItems_Save.GroupExportData)

	if BankItems_Save.GroupExportData then
		-- Group similar items together in the report
		local data = newTable()
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture
		for num = 1, 24 do
			if (bankPlayer[num]) then
				itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(bankPlayer[num].link)
				if (itemType) then
					data[itemType] = data[itemType] or newTable()
					data[itemType][itemName] = (data[itemType][itemName] or 0) + (bankPlayer[num].count or 1)
				else
					errorflag = true
				end
			end
		end
		for _, bagNum in ipairs(BAGNUMBERSPLUSMAIL) do
			local theBag = bankPlayer["Bag"..bagNum]
			if (bagNum ~= 100 and theBag) then
				local realSize = theBag.size
				if (bagNum == 101) then
					realSize = #theBag
				end
				for bagItem = 1, realSize do
					if (theBag[bagItem] and type(theBag[bagItem].link) == "string") then
						itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(theBag[bagItem].link)
						if (itemType) then
							data[itemType] = data[itemType] or newTable()
							data[itemType][itemName] = (data[itemType][itemName] or 0) + (theBag[bagItem].count or 1)
						else
							errorflag = true
						end
					end
				end
				if type(theBag.link) == "string" then
					itemName, _, _, _, _, itemType = GetItemInfo(theBag.link)
					if itemType then
						data[itemType] = data[itemType] or newTable()
						data[itemType][itemName] = (data[itemType][itemName] or 0) + 1
					else
						errorflag = true
					end
				end
			end
		end

		-- Generate the report
		for itemType, items in pairs(data) do
			text = text..itemType.."\n"
			for itemName, count in pairs(items) do
				text = text..count.." "..itemName.."\n"
			end
			text = text.."\n"
		end
		if (errorflag) then
			text = text.."CAUTION: Some items were not parsed/displayed in this report because they do not exist in your WoW local cache yet. A recent WoW patch or launcher update wiped out your local cache. Log on this character and visit the bank to correct this OR hover your mouse on every item in every bag to query the server for each item (may disconnect you).\n"
		end
		delTable(data)
	else
		-- Don't group similar items together in the report
		for num = 1, 24 do
			if bankPlayer[num] then
				if BankItems_Save.ExportPrefix then
					prefix = "Bank Item "..num..": "
				end
				text = text..prefix..bankPlayer[num].count.." "..BankItems_ParseLink(bankPlayer[num].link).."\n"
			end
		end
		for _, bagNum in ipairs(BAGNUMBERSPLUSMAIL) do
			local theBag = bankPlayer["Bag"..bagNum]
			if (bagNum ~= 100 and theBag) then
				local realSize = theBag.size
				if (bagNum == 101) then
					realSize = #theBag
				end
				for bagItem = 1, realSize do
					if (theBag[bagItem] and type(theBag[bagItem].link) == "string") then
						if (BankItems_Save.ExportPrefix) then
							prefix = "Bag "..bagNum.." Item "..bagItem..": "
						end
						text = text..prefix..theBag[bagItem].count.." "..BankItems_ParseLink(theBag[bagItem].link).."\n"
					end
				end
			end
		end
	end

	if bankPlayer.money then
		text = text.."\nMoney: "..BankItem_ParseMoney(bankPlayer.money).."\n"
	end

	_G["BankItems_ExportFrame_ScrollText"]:SetText(text)
end

function BankItems_Search(searchText)
	local text = ""
	local prefix = "     "
	local temp
	local count
	searchText = strlower(searchText)

	if (BankItems_Save.GroupExportData) then
		-- Group similar items together in the report
		local data = newTable()
		-- 'key' is the player name
		for key, bankPlayer in pairs(BankItems_Save) do
			local _, realm = strsplit("|", key)
			if (type(bankPlayer) == "table" and (BankItems_Save.SearchAllRealms or realm == selfPlayerRealm) and key ~= "Behavior") then
				for num = 1, 24 do
					if (bankPlayer[num]) then
						temp = strmatch(bankPlayer[num].link, "%[(.*)%]")
						if strfind(strlower(temp), searchText, 1, true) then
							data[temp] = data[temp] or newTable()
							data[temp][key] = data[temp][key] or newTable()
							data[temp][key].count = (data[temp][key].count or 0) + (bankPlayer[num].count or 1)
							data[temp][key].bank = (data[temp][key].bank or 0) + (bankPlayer[num].count or 1)
						end
					end
				end
				for _, bagNum in ipairs(BAGNUMBERSPLUSMAIL) do
					local theBag = bankPlayer["Bag"..bagNum]
					if (bagNum ~= 100 and theBag) then
						local realSize = theBag.size
						if (bagNum == 101) then
							realSize = #theBag
						end
						for bagItem = 1, realSize do
							if (theBag[bagItem] and type(theBag[bagItem].link) == "string") then
								temp = strmatch(theBag[bagItem].link, "%[(.*)%]")
								if (strfind(strlower(temp), searchText, 1, true)) then
									data[temp] = data[temp] or newTable()
									data[temp][key] = data[temp][key] or newTable()
									data[temp][key].count = (data[temp][key].count or 0) + (theBag[bagItem].count or 1)
									if (bagNum >= 0 and bagNum <= 4) then
										data[temp][key].inv = (data[temp][key].inv or 0) + (theBag[bagItem].count or 1)
									elseif (bagNum == 101) then
										data[temp][key].mail = (data[temp][key].mail or 0) + (theBag[bagItem].count or 1)
									else
										data[temp][key].bank = (data[temp][key].bank or 0) + (theBag[bagItem].count or 1)
									end
								end
							end
						end
					end
				end
			end
		end

		-- Generate the report
		local text2
		local totalCount
		for itemName, whotable in pairs(data) do
			text2 = ""
			totalCount = 0
			for who, counttable in pairs(whotable) do
				text2 = text2.."     "..counttable.count.." "..gsub(who, "|", " of ").." ("
				totalCount = totalCount + counttable.count
				local flag = false
				if (counttable.bank) then
					text2 = text2..BANKITEMS_BANK_TEXT.." "..counttable.bank
					flag = true
				end
				if (counttable.inv) then
					if flag then text2 = text2..", " end
					text2 = text2..BANKITEMS_BAGS_TEXT.." "..counttable.inv
					flag = true
				end
				if (counttable.mail) then
					if flag then text2 = text2..", " end
					text2 = text2..BANKITEMS_MAIL_TEXT.." "..counttable.mail
				end
				text2 = text2..")\n"
			end
			text = text..itemName.." ("..totalCount..")\n"..text2.."\n"
		end
		delTable(data)
	else
		-- Don't group similar items together in the report
		for key, bankPlayer in pairs(BankItems_Save) do
			local _, realm = strsplit("|", key)
			if (type(bankPlayer) == "table" and (BankItems_Save.SearchAllRealms or realm == selfPlayerRealm) and key ~= "Behavior") then
				count = 0
				for num = 1, 24 do
					if ( bankPlayer[num] and bankPlayer[num].link ) then
						if (BankItems_Save.ExportPrefix) then
							prefix = "     Bank Item "..num..": "
						end
						temp = strlower(strmatch(bankPlayer[num].link, "%[(.*)%]"))
						if (strfind(temp, searchText, 1, true)) then
							count = count + 1
							if (count == 1) then
								text = text.."Contents of "..gsub(key, "|", " of ").."\n"
							end
							text = text..prefix..bankPlayer[num].count.." "..BankItems_ParseLink(bankPlayer[num].link).."\n"
						end
					end
				end
				for _, bagNum in ipairs(BAGNUMBERSPLUSMAIL) do
					local theBag = bankPlayer["Bag"..bagNum]
					if (bagNum ~= 100 and theBag) then
						local realSize = theBag.size
						if (bagNum == 101) then
							realSize = #theBag
						end
						for bagItem = 1, realSize do
							if (theBag[bagItem] and type(theBag[bagItem].link) == "string") then
								if (BankItems_Save.ExportPrefix) then
									if (bagNum == 101) then
										prefix = "     In Mailbox: "
									else
										prefix = "     Bag "..bagNum.." Item "..bagItem..": "
									end
								end
								temp = strlower(strmatch(theBag[bagItem].link, "%[(.*)%]"))
								if (strfind(temp, searchText, 1, true)) then
									count = count + 1
									if (count == 1) then
										text = text.."Contents of "..gsub(key, "|", " of ").."\n"
									end
									text = text..prefix..theBag[bagItem].count.." "..BankItems_ParseLink(theBag[bagItem].link).."\n"
								end
							end
						end
					end
				end
				if (count > 0) then
					text = text.."\n"
				end
			end
		end
	end

	text = text.."\nSearch for \""..searchText.."\" complete.\n"

	BankItems_DisplaySearch()
	_G["BankItems_ExportFrame_ScrollText"]:SetText(text)
end

function BankItems_DisplaySearch()
	BankItems_ExportFrame.mode = "search"
	_G["BankItems_ExportFrame_ResetButton"]:SetText(BANKITEMS_SEARCH_TEXT)
	_G["BankItems_ExportFrame_SearchTextbox"]:Show()
	_G["BankItems_ExportFrame_SearchAllRealms"]:Show()
	_G["BankItems_ExportFrame_ShowBagPrefix"]:SetChecked(BankItems_Save.ExportPrefix)
	_G["BankItems_ExportFrame_GroupData"]:SetChecked(BankItems_Save.GroupExportData)
	_G["BankItems_ExportFrame_SearchAllRealms"]:SetChecked(BankItems_Save.SearchAllRealms)
	BankItems_ExportFrame:Show()
end

function BankItems_Hook_SendMail(recipient, subject, body)
	-- Capitalize the first letter, lower the rest
	recipient = string.upper(strsub(recipient, 1, 1))..strsub(recipient, 2)
	recipient = recipient.."|"..selfPlayerRealm
	if BankItems_Save[recipient] then
		-- Target recipient exists in our database, cache some data to be saved later if mail sending is successful
		mailItem.recipient = recipient
		for i = 1, ATTACHMENTS_MAX_SEND do
			mailItem[i] = mailItem[i] or newTable()
			local name, _, _, count = GetSendMailItem(i)
			mailItem[i].name, mailItem[i].count = name, count and count > 1 and count or nil
			mailItem[i].link = GetSendMailItemLink(i)
			mailItem[i].returned = true
			mailItem[i].deleted = nil
			mailItem[i].returnChar = selfPlayerName
		end
		if GetSendMailCOD() > 0 then
			mailItem.money = 0
			mailItem.CoD = true
		else
			mailItem.money = GetSendMailMoney()
			mailItem.CoD = false
		end
		BankItems_Frame:RegisterEvent("MAIL_SEND_SUCCESS")
	end
end
hooksecurefunc("SendMail", BankItems_Hook_SendMail)

function BankItems_Frame_MailSendSuccess()
if not mailItem.recipient then return end
	local targetPlayer = BankItems_Save[mailItem.recipient]
	targetPlayer.Bag101 = targetPlayer.Bag101 or newTable()
	local targetBag = targetPlayer.Bag101
	targetBag.icon = "Interface\\MailFrame\\Mail-Icon"

	for i = ATTACHMENTS_MAX_SEND, 1, -1 do
		if mailItem[i].name then
			local data = newTable()
			data.link = mailItem[i].link
			data.icon = mailItem[i].icon
			data.count = mailItem[i].count
			data.returned = mailItem[i].returned
			data.deleted = mailItem[i].deleted
			data.returnChar = mailItem[i].returnChar
			if mailItem.CoD then
				data.expiry = time() + 3*60*60*24
			else
				data.expiry = time() + 30*60*60*24
			end
			tinsert(targetBag, 1, data)
		end
	end
	if mailItem.money ~= 0 then
		if #targetBag == 0 or type(targetBag[#targetBag].link) == "string" then
			local data = newTable()
			data.link = mailItem.money
			data.icon = GetCoinIcon(mailItem.money)
			tinsert(targetBag, data)
		elseif type(targetBag[#targetBag].link) == "number" then
			local data = targetBag[#targetBag]
			data.link = data.link + mailItem.money
			data.icon = GetCoinIcon(data.link)
		end
	end

	targetBag.size = #targetBag -- when not displaying the mail as a bag, no constraints on bag size

	-- Hawksy: not sure if this will send any information about this mailing to the targetPlayer
	if bankPlayer == targetPlayer and BagContainerAr[101] then
		BagButtonAr[101]:Click()
	end
end

local BankItems_Orig_ReturnInboxItem = ReturnInboxItem
function ReturnInboxItem(index, ...)
	local _, _, recipient, _, money = GetInboxHeaderInfo(index)
	recipient = recipient.."|"..selfPlayerRealm
	if (recipient and BankItems_Save[recipient]) then
		-- Target recipient exists in our database, set some data to be saved
		mailItem.recipient = recipient
		for i = 1, ATTACHMENTS_MAX_SEND do
			mailItem[i] = mailItem[i] or newTable()
			local name, _, _, count = GetInboxItem(index, i)
			mailItem[i].link = GetInboxItemLink(index, i)
			mailItem[i].returned = nil
			mailItem[i].deleted = true
		end
		mailItem.money = money
		BankItems_Frame_MailSendSuccess()
		BankItems_Generate_ItemCache()
	end
	return BankItems_Orig_ReturnInboxItem(index, ...)
end
--hooksecurefunc("ReturnInboxItem", BankItems_Hook_ReturnInboxItem)


-- Public function called during cache generation.
-- It can be used by other addons as hook point to catch item names
-- and corresponding item ids stored in Bank Item cache tables.
-- To get item name you can use: itemName = strmatch(link,"|h%[([^%]]+)%]|h|r$")
function BankItems_Cache_ItemName(itemId, link)
end

local function BankItems_createUniqueItem(link)

	--7.0.3 format = item:itemID:enchant:gemID1:gemID2:gemID3:gemID4:suffixID:uniqueID:linkLevel:specializationID:upgradeTypeID:instanceDifficultyID:numBonusIDs[:bonusID1:bonusID2:...][:upgradeValue1:upgradeValue2:...]:relic1NumBonusIDs[:relic1BonusID1:relic1BonusID2:...]:relic2NumBonusIDs[:relic2BonusID1:relic2BonusID2:...]:relic3NumBonusIDs[:relic3BonusID1:relic3BonusID2:...]
	if not link or not BankItems_Save.TTUnique then return end
	local itemID = link:match("item:([-%d]+)")

	if not itemID then return end
	local uniqueItem = link:match("(item:[-%d]-):[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:0?:[-%d]-:[-%d]-:[-%d]-:0?:0?:0?")
	--                                   itemID                              suffixID                 upType instdif numBonus
	if uniqueItem then return uniqueItem end

	if not link:match(":::|") or itemID == "138019" then return end --artifact weapon or mythic keystone
	local suffixID, upgradeTypeID, numBonusIDs = link:match("item:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:([-%d]-):[-%d]-:[-%d]-:[-%d]-:([-%d]-):[-%d]-:([-%d]-)[:|]")

	upgradeTypeID = upgradeTypeID and tonumber(upgradeTypeID) or 0
	numBonusIDs = numBonusIDs and tonumber(numBonusIDs) or 0
	suffixID = suffixID and tonumber(suffixID) or 0
	--local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(link)
	--itemEquipLoc = itemEquipLoc or ""
	--if itemEquipLoc == "" and numBonusIDs == 0 then return link:match("(item:[-%d]+)") end --return as base item since I am pretty sure non-equippable items need a bonusID to change them in a meaningful way (e.g. hellfire tier tokens) and some have different instanceDifficultyID's with no meaningful differences

	if numBonusIDs ~= 0 or suffixID ~=0 or (upgradeTypeID ~= 0 and upgradeTypeID ~= 4) then
		uniqueItem = link:match("(item:[-:%d]+|)h%[")
		if uniqueItem then
			if upgradeTypeID ~= 0 and upgradeTypeID ~= 512 then --skip saving upgradeValue unless it is timewarped
				uniqueItem = gsub(uniqueItem,"(item:[-%d]-):[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:([-%d]-):[-%d]-:[-%d]-:[-%d]-:([-%d]-):[-%d]-:([-:%d]+):[-%d]-:[-%d]-:[-%d]-:[-%d]-|", "%1:%2:%3:%4") --pretty sure instance difficulty itself doesn't make meaningful changes (bonus ID's do the work) but can cause matching problems if included
				--                            (     itemID)                                   (suffixID)                    (upType)         (numBon+bonuses) upVal
			else --if upgradeTypeID == 0 or nil this will return only the bonusID's
				uniqueItem = gsub(uniqueItem,"(item:[-%d]-):[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:([-%d]-):[-%d]-:[-%d]-:[-%d]-:([-%d]-):[-%d]-:([-:%d]+):[-%d]-:[-%d]-:[-%d]-|", "%1:%2:%3:%4")
				--                            (     itemID)                                   (suffixID)                    (upType) 	       (numBon+bonus+UpVal)
			end
		else
			uniqueItem = link:match("(item:[-%d]+)")
		end
	else
		uniqueItem = link:match("(item:[-%d]+)")
	end

	return uniqueItem
end

function BankItems_Generate_ItemCache()
	-- This function generates an item cache that contains everything all players except the current player on the current realm
	local temp, uniqueItem
	local data = newTable()
	for key, bankPlayer in pairs(BankItems_Save) do
		local _, realm = strsplit("|", key)
		if type(bankPlayer) == "table" and selfPlayer ~= bankPlayer and (BankItems_Save.ShowAllRealms or (realm == selfPlayerRealm)) and key ~= "Behavior" and key ~= "Behavior2" then
			for num = 1, NUM_BANKGENERIC_SLOTS do
				if bankPlayer[num] then
					--temp = strmatch(bankPlayer[num].link, "%[(.*)%]")
					temp = tonumber(strmatch(bankPlayer[num].link, "item:(%d+)"))
					if temp then
						BankItems_Cache_ItemName(temp, bankPlayer[num].link)
						data[temp] = data[temp] or newTable()
						data[temp][key] = data[temp][key] or newTable()
						data[temp][key].count = (data[temp][key].count or 0) + (bankPlayer[num].count or 1)
						data[temp][key].bank = (data[temp][key].bank or 0) + (bankPlayer[num].count or 1)
						uniqueItem = BankItems_createUniqueItem(bankPlayer[num].link)
						if uniqueItem then
							data[uniqueItem] = data[uniqueItem] or newTable()
							data[uniqueItem][key] = data[uniqueItem][key] or newTable()
							data[uniqueItem][key].count = (data[uniqueItem][key].count or 0) + (bankPlayer[num].count or 1)
							data[uniqueItem][key].bank = (data[uniqueItem][key].bank or 0) + (bankPlayer[num].count or 1)
						end
					end
				end
			end
			for _, bagNum in ipairs(BAGNUMBERSPLUSMAIL) do
				local theBag = bankPlayer[format("Bag%d", bagNum)]
				if theBag then
					local realSize = theBag.size or 0
					for bagItem = 1, realSize or 0 do -- if realSize is nil skip the loop since table is empty or has an error
						if theBag[bagItem] and type(theBag[bagItem].link) == "string" then
							--temp = strmatch(theBag[bagItem].link, "%[(.*)%]")
							temp = tonumber(strmatch(theBag[bagItem].link, "item:(%d+)"))
							if temp then
								BankItems_Cache_ItemName(temp, theBag[bagItem].link)
								data[temp] = data[temp] or newTable()
								data[temp][key] = data[temp][key] or newTable()
								data[temp][key].count = (data[temp][key].count or 0) + (theBag[bagItem].count or 1)
								uniqueItem = BankItems_createUniqueItem(theBag[bagItem].link)
								if uniqueItem then
									data[uniqueItem] = data[uniqueItem] or newTable()
									data[uniqueItem][key] = data[uniqueItem][key] or newTable()
									data[uniqueItem][key].count = (data[uniqueItem][key].count or 0) + (theBag[bagItem].count or 1)
								end
								if bagNum >= 0 and bagNum <= 4 then
									data[temp][key].inv = (data[temp][key].inv or 0) + (theBag[bagItem].count or 1)
									if uniqueItem then data[uniqueItem][key].inv = (data[uniqueItem][key].inv or 0) + (theBag[bagItem].count or 1) end
								elseif bagNum == 100 then
									data[temp][key].equipped = (data[temp][key].equipped or 0) + (theBag[bagItem].count or 1)
									if uniqueItem then data[uniqueItem][key].equipped = (data[uniqueItem][key].equipped or 0) + (theBag[bagItem].count or 1) end
								elseif bagNum == 101 then
									data[temp][key].mail = (data[temp][key].mail or 0) + (theBag[bagItem].count or 1)
									if uniqueItem then data[uniqueItem][key].mail = (data[uniqueItem][key].mail or 0) + (theBag[bagItem].count or 1) end
								else
									data[temp][key].bank = (data[temp][key].bank or 0) + (theBag[bagItem].count or 1)
									if uniqueItem then data[uniqueItem][key].bank = (data[uniqueItem][key].bank or 0) + (theBag[bagItem].count or 1) end
								end
							end
						end
					end
				end
			end
		end
	end
	delTable(BankItems_Cache)
	BankItems_Cache = data
	delTable(BankItems_TooltipCache)
	BankItems_TooltipCache = newTable()
end

function BankItems_Generate_SelfItemCache()
	-- This function generates an item cache with only the player's items
	local temp, uniqueItem
	local data = newTable()
	local equippedBags = newTable()
	local bankPlayer = selfPlayer
	for num = 1, NUM_BANKGENERIC_SLOTS do
		if bankPlayer[num] then
			--temp = strmatch(bankPlayer[num].link, "%[(.*)%]")
			temp = tonumber(strmatch(bankPlayer[num].link, "item:(%d+)"))
			if temp then
				BankItems_Cache_ItemName(temp, bankPlayer[num].link)
				data[temp] = data[temp] or newTable()
				data[temp].count = (data[temp].count or 0) + (bankPlayer[num].count or 1)
				data[temp].bank = (data[temp].bank or 0) + (bankPlayer[num].count or 1)
				uniqueItem = BankItems_createUniqueItem(bankPlayer[num].link)
				if uniqueItem then
					data[uniqueItem] = data[uniqueItem] or newTable()
					data[uniqueItem].count = (data[uniqueItem].count or 0) + (bankPlayer[num].count or 1)
					data[uniqueItem].bank = (data[uniqueItem].bank or 0) + (bankPlayer[num].count or 1)
				end
			end
		end
	end
	for _, bagNum in ipairs(BAGNUMBERSPLUSMAIL) do
		local theBag = bankPlayer[format("Bag%d", bagNum)]
		if theBag then
			local realSize = theBag.size or 0
			if type(theBag.link) == "string" then
				temp = tonumber(strmatch(theBag.link, "item:(%d+)"))
				if temp then
					equippedBags[temp] = (equippedBags[temp] or 0) +  1 --equipped bag count
				end
			end
			for bagItem = 1, realSize or 0 do -- if realSize is nil skip the loop since table is empty or has an error
				if theBag[bagItem] and type(theBag[bagItem].link) == "string" then
					--temp = strmatch(theBag[bagItem].link, "%[(.*)%]")
					temp = tonumber(strmatch(theBag[bagItem].link, "item:(%d+)"))
					if temp then
						BankItems_Cache_ItemName(temp, theBag[bagItem].link)
						data[temp] = data[temp] or newTable()
						data[temp].count = (data[temp].count or 0) + (theBag[bagItem].count or 1)
						uniqueItem = BankItems_createUniqueItem(theBag[bagItem].link)
						if uniqueItem then
							data[uniqueItem] = data[uniqueItem] or newTable()
							data[uniqueItem].count = (data[uniqueItem].count or 0) + (theBag[bagItem].count or 1)
						end
						if bagNum >= 0 and bagNum <= 4 then
							data[temp].inv = (data[temp].inv or 0) + (theBag[bagItem].count or 1)
							if uniqueItem then data[uniqueItem].inv = (data[uniqueItem].inv or 0) + (theBag[bagItem].count or 1) end
						elseif bagNum == 100 then
							data[temp].equipped = (data[temp].equipped or 0) + (theBag[bagItem].count or 1)
							if uniqueItem then data[uniqueItem].equipped = (data[uniqueItem].equipped or 0) + (theBag[bagItem].count or 1) end
						elseif bagNum == 101 then
							data[temp].mail = (data[temp].mail or 0) + (theBag[bagItem].count or 1)
							if uniqueItem then data[uniqueItem].mail = (data[uniqueItem].mail or 0) + (theBag[bagItem].count or 1) end
						else
							data[temp].bank = (data[temp].bank or 0) + (theBag[bagItem].count or 1)
							if uniqueItem then data[uniqueItem].bank = (data[uniqueItem].bank or 0) + (theBag[bagItem].count or 1) end
						end
					end
				end
			end
		end
	end
	if not isBankOpen then
		for k, v in pairs(data) do
			if tonumber(k) then
				local bankCount = GetItemCount(k, true) - (data[k].inv or 0) - (data[k].reagentbank or 0) - (data[k].equipped or 0) - (equippedBags[k] or 0) --GetItemCount(k, true) can get an updated count of items without the bank open
				data[k].count = data[k].count - (data[k].bank or 0) + bankCount
				data[k].bank = bankCount
				if data[k].bank == 0 then data[k].bank = nil end
				if data[k].count == 0 then data[k] = delTable(data[k]) end
			end
		end
	end
	delTable(equippedBags)
	delTable(BankItems_SelfCache)
	BankItems_SelfCache = data
	delTable(BankItems_TooltipCache)
	BankItems_TooltipCache = newTable()
end


-------------------------------------------------
-- Set scripts of the various widgets

-- The 24 main bank buttons
for i = 1, 24 do
	ItemButtonAr[i]:SetScript("OnLeave", BankItems_Button_OnLeave)
	ItemButtonAr[i]:SetScript("OnEnter", BankItems_Button_OnEnter)
	ItemButtonAr[i]:SetScript("OnClick", BankItems_Button_OnClick)
end

-- The 14 (classic 12) bag buttons
for _, i in ipairs(BAGNUMBERS) do
	BagButtonAr[i]:SetScript("OnLeave", BankItems_Button_OnLeave)
	BagButtonAr[i]:SetScript("OnEnter", BankItems_Bag_OnEnter)
	BagButtonAr[i]:SetScript("OnClick", BankItems_Bag_OnClick)
end

-- The 14 (classic 12) bags
for _, i in ipairs(BAGNUMBERS) do
	BagContainerAr[i]:SetScript("OnShow", BankItems_Bag_OnShow)
	BagContainerAr[i]:SetScript("OnHide", BankItems_Bag_OnHide)
	for j = 1, 36 do
		BagContainerAr[i][j]:SetScript("OnLeave", BankItems_Button_OnLeave)
		BagContainerAr[i][j]:SetScript("OnEnter", BankItems_BagItem_OnEnter)
		BagContainerAr[i][j]:SetScript("OnClick", BankItems_BagItem_OnClick)
	end
	BagContainerAr[i].PortraitButton:SetScript("OnEnter", BankItems_BagPortrait_OnEnter)
	BagContainerAr[i].PortraitButton:SetScript("OnLeave", BankItems_Button_OnLeave)
end

-- The Show All Realms checkbox
_G["BankItems_ShowAllRealms_Check"]:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(BANKITEMS_ALLREALMS_TOOLTIP_TEXT, nil, nil, nil, nil, 1)
end)
_G["BankItems_ShowAllRealms_Check"]:SetScript("OnLeave", BankItems_Button_OnLeave)

-- The User Dropdown
BankItems_UserDropdown:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	GameTooltip:SetText(BANKITEMS_USERDROPDOWN_TOOLTIP_TEXT, nil, nil, nil, nil, 1)
end)
BankItems_UserDropdown:SetScript("OnLeave", BankItems_Button_OnLeave)

-- The Export Button
BankItems_ExportButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(BANKITEMS_EXPORTBUTTON_TEXT, nil, nil, nil, nil, 1)
end)
BankItems_ExportButton:SetScript("OnLeave", BankItems_Button_OnLeave)
BankItems_ExportButton:SetScript("OnClick", function(self)
	BankItems_GenerateExportText()
	BankItems_ExportFrame:Show()
end)

-- The Search Button
BankItems_SearchButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(BANKITEMS_SEARCHBUTTON_TEXT, nil, nil, nil, nil, 1)
end)
BankItems_SearchButton:SetScript("OnLeave", BankItems_Button_OnLeave)
BankItems_SearchButton:SetScript("OnClick", BankItems_DisplaySearch)


-- The BankItems frame
BankItems_Frame:SetScript("OnShow", BankItems_Frame_OnShow)
BankItems_Frame:SetScript("OnHide", BankItems_Frame_OnHide)
BankItems_Frame:SetScript("OnEvent", BankItems_Frame_OnEvent)
BankItems_Frame:SetScript("OnDragStart", BankItems_Frame_OnDragStart)
BankItems_Frame:SetScript("OnDragStop", BankItems_Frame_OnDragStop)
BankItems_Frame:RegisterEvent("VARIABLES_LOADED")
BankItems_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
BankItems_Frame:RegisterEvent("PLAYER_MONEY")
BankItems_Frame:RegisterEvent("ZONE_CHANGED")
BankItems_Frame:RegisterEvent("ZONE_CHANGED_INDOORS")
BankItems_Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
BankItems_Frame:RegisterEvent("BANKFRAME_OPENED")
BankItems_Frame:RegisterEvent("BANKFRAME_CLOSED")
BankItems_Frame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
BankItems_Frame:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
BankItems_Frame:RegisterEvent("BAG_UPDATE")
BankItems_Frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
BankItems_Frame:RegisterEvent("MAIL_SHOW")
BankItems_Frame:RegisterEvent("MAIL_CLOSED")
BankItems_Frame:RegisterEvent("MAIL_SEND_SUCCESS")
BankItems_Frame:RegisterEvent("ADDON_LOADED")


function BankItems_AddTooltipData(self, ...)
	--[[Add tooltip data and return any values passed through ... 
	Call as     return BankItems_AddTooltipData(self, originalFunc(self, ...))     for returns from hooked tooltip functions
	Doing this in case we hook a function that doesn't trigger OnTooltipSetItem and we need a way to
	modify it after tooltip is drawn while still returning any resulting values. Mostly for future proofing
	in case Blizzard adds return values to more functions.]]
	if self.BankItemsDone then return ... end
	local _, link = self:GetItem()
	-- Hawksy for some reason Classic doesn't have item for materials in enchanting window, so we just get 'nil' here
	local item = link and tonumber(link:match("item:(%d+)"))
	if not item or item == 0 then --tooltip item not found or returned item id as 0 so check BankItems_Link assigned by hooks
		link = self.BankItems_Link
		item = link and (tonumber(link:match("item:(%d+)")))
	end
	if BankItems_Save.TTUnique and self.BankItemsStripLink then --need to strip irrelevant bonusID and instance difficulty data for this item
		link = gsub(link,"(item:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:[-%d]-:)[-%d]-:[-%d]-([:|])","%1:%2")
		self.BankItemsStripLink = false
	end
	if not item or item == 0 then return ... end --if no link or a link from item id 0 was passed then stop function
	if item == 6948 then --Ignore Hearthstone
		self.BankItemsDone = true
		return ...
	end
	local item = BankItems_createUniqueItem(link) or item

	-- Hawksy: if A mails something to B, it doesn't show up properly for B until it arrives in B's mailbox and B opens their mailbox

	if not BankItems_TooltipCache[item] then
		BankItems_TooltipCache[item] = newTable()

		local baginfos = {
			{ "Bank" },
			{ "Bags" },
			{ "Equipped" },
			{ "Mail" }
		}
		local totalCount = 0
		local characters = 0
		if BankItems_SelfCache[item] then
			local text
			local counttable = BankItems_SelfCache[item]
			totalCount = totalCount + (counttable.count or 0)

			baginfos[1][2] = counttable.bank
			baginfos[2][2] = counttable.inv
			baginfos[3][2] = counttable.equipped
			baginfos[4][2] = counttable.mail
			text = format("%s %s %d [", strsplit("|", selfPlayerName), "has", counttable.count)
			local first = true
			for i = 1, #baginfos do
				if baginfos[i][2] then
					if not first then text = text..", " end
					text = text..baginfos[i][1].." "..baginfos[i][2]
					first = false
				end
			end
			text = text.."]"
			tinsert(BankItems_TooltipCache[item], text)
			characters = characters + 1
		end
		if BankItems_Cache[item] then
			for who, counttable in pairs(BankItems_Cache[item]) do
				local text
				local name
				local n, r = strsplit("|", who)
				if selfPlayerRealm ~= r then
					name = n.."-"..r
				else
					name = n
				end
				totalCount = totalCount + counttable.count

				baginfos[1][2] = counttable.bank
				baginfos[2][2] = counttable.inv
				baginfos[3][2] = counttable.equipped
				baginfos[4][2] = counttable.mail

				text = format("%s %s %d [", name, "has", counttable.count)
				local first = true
				for i = 1, #baginfos do
					if baginfos[i][2] then
						if not first then text = text..", " end
						text = text..baginfos[i][1].." "..baginfos[i][2]
						first = false
					end
				end
				text = text.."]"
				tinsert(BankItems_TooltipCache[item], text)
				characters = characters + 1
			end
		end
		if characters > 1 then
			tinsert(BankItems_TooltipCache[item], "Total: "..format(totalCount))
		end
	end
	local num = #BankItems_TooltipCache[item]
	if num > 0 then
		for i = 1, num do
			-- Hawksy: this is where the BankItems tooltips get added to the tooltip
			-- Hawksy: note that this function is called repeatedly as long as the mouse is hovering over the item (same problem in Retail)
			-- Hawksy: figure out if this can be made once-only
			self:AddLine(BankItems_TooltipCache[item][i], 0.2890625, 0.6953125, 0.8359375)
		end
		self:Show()
	end
	self.BankItemsDone = true
	return ...
end

function BankItems_ClearTooltipData(self)
	self.BankItemsDone = nil
end

function BankItems_TooltipHidden(self)
	self.BankItems_Link = nil
end

function BankItems_Hooktooltip(tooltip)
	-- Use nonsecure hooks and upvalues for speed
	local a = tooltip:GetScript("OnTooltipSetItem")
	if a then
		tooltip:SetScript("OnTooltipSetItem", function(self, ...)
			BankItems_AddTooltipData(self)
			return a(self, ...)
		end)
	else
		tooltip:SetScript("OnTooltipSetItem", BankItems_AddTooltipData)
	end

	local b = tooltip:GetScript("OnTooltipCleared")
	if b then
		tooltip:SetScript("OnTooltipCleared", function(self, ...)
			-- Credits to Siz on this code
			self.BankItemsDone = nil
			return b(self, ...)
		end)
	else
		tooltip:SetScript("OnTooltipCleared", BankItems_ClearTooltipData)
	end

	local c = tooltip:GetScript("OnHide")
	if c then
		tooltip:SetScript("OnHide", function(self, ...)
			--have to nil the link data or unhooked items that don't work with GameTooltip:GetItem() will show the last used items counts
			--can't nil this at OnTooltipCleared since recipes can clear the tooltip multiple times while being set to a tooltip the first time after client load
			self.BankItems_Link = nil
			return c(self, ...)
		end)
	else
		tooltip:SetScript("OnHide", BankItems_TooltipHidden)
	end

	-- Hook some functions...
	local d = tooltip.SetCurrencyByID
	tooltip.SetCurrencyByID = function(self, ...)
		self.BankItems_Link = "currency:"..(...)
		d(self, ...)
		BankItems_AddTooltipData(self) --currency tooltip functions typically don't trigger OnTooltipSetItem so call BankItems_AddTooltipData function
	end

	local e = tooltip.SetCurrencyToken
	tooltip.SetCurrencyToken = function(self, ...)
		self.BankItems_Link = GetCurrencyListLink(...)
		e(self, ...)
		BankItems_AddTooltipData(self)
	end

	local f = tooltip.SetHyperlink
	tooltip.SetHyperlink = function(self, ...)
		self.BankItems_Link = ...
		f(self, ...)
		if (...) and strfind(..., "currency:%d+") then
			BankItems_AddTooltipData(self)
		end
	end
	local g = tooltip.SetCurrencyTokenByID
	tooltip.SetCurrencyTokenByID = function(self, ...)
		self.BankItems_Link = "currency:"..(...)
		g(self, ...)
		BankItems_AddTooltipData(self)
	end

	local h = tooltip.SetMerchantCostItem
	tooltip.SetMerchantCostItem = function(self, ...)
		local _, _, link, name = GetMerchantItemCostItem(...) --currencies currently return nil for the link
		self.BankItems_Link = link or GetCurrencyString(name)
		h(self, ...)
		if not link then
			BankItems_AddTooltipData(self)
		end
	end

	local i = tooltip.SetBackpackToken
	tooltip.SetBackpackToken = function(self, ...)
		self.BankItems_Link = "currency:"..select(4, GetBackpackCurrencyInfo(...))
		i(self, ...)
		BankItems_AddTooltipData(self)
	end

	local j = tooltip.SetRecipeReagentItem --tooltip.SetTradeSkillItem removed in 7.0 and replaced with this
	tooltip.SetRecipeReagentItem = function(self, ...)
		self.BankItems_Link = GetRecipeReagentItemLink(...)
		j(self, ...)
	end

	local k = tooltip.SetQuestLogItem --is this still needed in 7.0?
	tooltip.SetQuestLogItem = function(self, ...)
		self.BankItems_Link = GetQuestLogItemLink(...)
		k(self, ...)
	end

	local l = tooltip.SetQuestItem --is this still needed in 7.0?
	tooltip.SetQuestItem = function(self, ...)
		self.BankItems_Link = GetQuestItemLink(...)
		l(self, ...)
	end

	local m = tooltip.SetQuestLogCurrency
	tooltip.SetQuestLogCurrency = function(self, ...)
		local _, index = ...
		self.BankItems_Link = GetCurrencyString(GetQuestLogRewardCurrencyInfo(index))
		m(self, ...)
		BankItems_AddTooltipData(self)
	end

	local n = tooltip.SetQuestCurrency
	tooltip.SetQuestCurrency = function(self, ...)
		self.BankItems_Link = GetCurrencyString(GetQuestCurrencyInfo(...))
		n(self, ...)
		BankItems_AddTooltipData(self)
	end

	local q = tooltip.SetInboxItem --returns values, need to hook for some recipe items to display counts
	tooltip.SetInboxItem = function(self, ...)
		local arg1, arg2 = ...
		if arg2 then --2 arguments passed so mail has more than 1 item in it
			self.BankItems_Link = GetInboxItemLink(arg1, arg2)
		else --just 1 item in the mail
			self.BankItems_Link = GetInboxItemLink(arg1, 1)
		end
		return q(self, ...)
	end
	local r = tooltip.SetMerchantItem
	tooltip.SetMerchantItem = function(self, ...)
		self.BankItems_Link = GetMerchantItemLink(...)
		r(self, ...)
		if self.BankItems_Link and strfind(self.BankItems_Link, "currency:%d+") then
			BankItems_AddTooltipData(self)
		end
	end
	local s = tooltip.SetRecipeResultItem
	tooltip.SetRecipeResultItem = function(self, ...)
		--flag to strip irrelevant bonusID and instance difficulty data for this item
		self.BankItemsStripLink = true
		s(self, ...)
	end
	--The following GameTooltip functions can return values when called so be careful with hooking: SetInventoryItem, SetBagItem, SetInboxItem, SetSendMailItem, SetTradeTargetItem, SetTradePlayerItem
	--All return information for battle pets and most return information for cooldowns. SetInventoryItem and SetBagItem also return information for non-battlepet items such as whether the item exists at the target location and repair costs.
end

function BankItems_HookTooltips()
	-- Walk through all frames
	local tooltip = EnumerateFrames()
	while tooltip do
		if tooltip:GetObjectType() == "GameTooltip" then
			local name = tooltip:GetName()
			if name then
				for i = 1, #TooltipList do
					if strfind(name, TooltipList[i], 1, true) then
						BankItems_Hooktooltip(tooltip)
						break
					end
				end
			end
		end
		tooltip = EnumerateFrames(tooltip)
	end
	if _G["LinkWrangler"] then
		_G['LinkWrangler'].RegisterCallback("BankItems", BankItems_Hooktooltip, "allocate")
	end
	-- Kill function so that it won't get called twice (causing double hooking)
	BankItems_HookTooltips = function() end
end


-- Add slash command
SlashCmdList["BANKITEMS"] = function(msg)
	BankItems_SlashHandler(msg)
end
SLASH_BANKITEMS1 = "/bankitems"
SLASH_BANKITEMS2 = "/bi"

SlashCmdList["BANKITEMSSEARCH"] = function(msg)
	if (msg and #msg > 0) then
		BankItems_SlashHandler("search "..msg)
	else
		BankItems_DisplaySearch()
	end
end
SLASH_BANKITEMSSEARCH1 = "/bis"

-- Makes ESC key close BankItems
tinsert(UISpecialFrames, "BankItems_Frame")
tinsert(UISpecialFrames, "BankItems_ExportFrame")


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Minimap Button

local BankItems_MinimapButton = CreateFrame("Button", "BankItems_MinimapButton", Minimap)
BankItems_MinimapButton:EnableMouse(true)
BankItems_MinimapButton:SetMovable(false)
BankItems_MinimapButton:SetFrameStrata("LOW")
BankItems_MinimapButton:SetWidth(33)
BankItems_MinimapButton:SetHeight(33)
BankItems_MinimapButton:SetPoint("TOPLEFT", Minimap, "RIGHT", 2, 0)
BankItems_MinimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

local BankItems_MinimapButtonIcon = BankItems_MinimapButton:CreateTexture(nil, "BORDER")
BankItems_MinimapButtonIcon:SetWidth(20)
BankItems_MinimapButtonIcon:SetHeight(20)
BankItems_MinimapButtonIcon:SetPoint("CENTER", -2, 1)
BankItems_MinimapButtonIcon:SetTexture("Interface\\Icons\\INV_Misc_Bag_10_Blue")

local BankItems_MinimapButtonBorder = BankItems_MinimapButton:CreateTexture(nil, "OVERLAY")
BankItems_MinimapButtonBorder:SetWidth(52)
BankItems_MinimapButtonBorder:SetHeight(52)
BankItems_MinimapButtonBorder:SetPoint("TOPLEFT")
BankItems_MinimapButtonBorder:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

function BankItems_MinimapButton_Init()
	-- Initialise defaults if not present
	if (BankItems_Save.ButtonShown == false) then
		BankItems_MinimapButton:Hide()
		BankItems_Save.ButtonShown = false
	else
		BankItems_MinimapButton:Show()
		BankItems_Save.ButtonShown = true
	end
	BankItems_Save.ButtonRadius = BankItems_Save.ButtonRadius or 78
	BankItems_Save.ButtonPosition = BankItems_Save.ButtonPosition or 345
	BankItems_MinimapButton_UpdatePosition()
end

function BankItems_MinimapButton_UpdatePosition()
	BankItems_MinimapButton:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (BankItems_Save.ButtonRadius * cos(BankItems_Save.ButtonPosition)),
		(BankItems_Save.ButtonRadius * sin(BankItems_Save.ButtonPosition)) - 55
	)
end

-- Thanks to Yatlas for this code
function BankItems_MinimapButton_BeingDragged()
	-- Thanks to Gello for this code
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	local v = math.deg(math.atan2(ypos, xpos))
	if (v < 0) then
		v = v + 360
	end
	BankItems_Save.ButtonPosition = v
	BankItems_MinimapButton_UpdatePosition()

	if (BankItems_OptionsFrame:IsVisible()) then
		BankItems_ButtonRadiusSlider:SetValue(BankItems_Save.ButtonRadius)
		BankItems_ButtonPosSlider:SetValue(BankItems_Save.ButtonPosition)
	end
end

BankItems_MinimapButton:RegisterEvent("VARIABLES_LOADED")
BankItems_MinimapButton:RegisterForDrag("RightButton")
BankItems_MinimapButton:SetScript("OnDragStart", function(self)
	self:SetScript("OnUpdate", BankItems_MinimapButton_BeingDragged)
end)
BankItems_MinimapButton:SetScript("OnDragStop", function(self)
	self:SetScript("OnUpdate", nil)
end)
BankItems_MinimapButton:SetScript("OnClick", function(self)
	BankItems_SlashHandler()
end)
BankItems_MinimapButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetText(BANKITEMS_MINIMAPBUTTON_TOOLTIP)
	GameTooltip:AddLine(BANKITEMS_MINIMAPBUTTON_TOOLTIP2)
	GameTooltip:AddLine(BANKITEMS_MINIMAPBUTTON_TOOLTIP3)
	GameTooltip:Show()
end)
BankItems_MinimapButton:SetScript("OnLeave", BankItems_Button_OnLeave)
BankItems_MinimapButton:SetScript("OnEvent", BankItems_MinimapButton_Init)


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Options Frame

do
	local temp
	local BANKITEMS_OPTIONS_BACKDROP = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
	 	insets = { left = 11, right = 12, top = 12, bottom = 11 },
	}

	-- Create the BankItems Options frame
	BankItems_OptionsFrame = CreateFrame("Frame", "BankItems_OptionsFrame", UIParent, "DialogBoxFrame") --4/10/2023 Specify backdrop during frame creation
	BankItems_OptionsFrame:Hide()
	BankItems_OptionsFrame:SetWidth(300)
	BankItems_OptionsFrame:SetHeight(330)
	BankItems_OptionsFrame:SetPoint("CENTER")
	BankItems_OptionsFrame:EnableMouse(true)
	BankItems_OptionsFrame:SetToplevel(true)
	BankItems_OptionsFrame:SetMovable(true)
	BankItems_OptionsFrame:SetFrameStrata("DIALOG")
	--BankItems_OptionsFrame:SetBackdrop(BANKITEMS_OPTIONS_BACKDROP)  4/10/2023 SetBackdrop not available in classic; specify during frame creation instead

	-- Title background
	temp = BankItems_OptionsFrame:CreateTexture(nil, "ARTWORK")
	temp:SetWidth(300)
	temp:SetHeight(64)
	temp:SetPoint("TOP", 0, 12)
	temp:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")

	-- Title text
	temp = BankItems_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	temp:SetPoint("TOP", 0, -3)
	temp:SetText(BANKITEMS_OPTIONS_TEXT)

	-- Lock Window checkbox
	local BankItems_OptionsFrame_LockWindow = CreateFrame("CheckButton", "BankItems_OptionsFrame_LockWindow", BankItems_OptionsFrame, "OptionsCheckButtonTemplate")
	BankItems_OptionsFrame_LockWindow:SetPoint("TOPLEFT", 25, -25)
	BankItems_OptionsFrame_LockWindow:SetHitRectInsets(0, -210, 0, 0)
	_G["BankItems_OptionsFrame_LockWindowText"]:SetText(BANKITEMS_LOCK_MAIN_WINDOW_TEXT)
	BankItems_OptionsFrame_LockWindow:SetScript("OnClick", function(self)
		if (BankItems_Save.LockWindow) then
			BankItems_Save.LockWindow = false
			BankItems_Frame:RegisterForDrag("LeftButton")
		else
			BankItems_Save.LockWindow = true
			BankItems_Frame:RegisterForDrag()
		end
		self:SetChecked(BankItems_Save.LockWindow)
	end)

	-- Minimap Button checkbox
	local BankItems_OptionsFrame_MinimapButton = CreateFrame("CheckButton", "BankItems_OptionsFrame_MinimapButton", BankItems_OptionsFrame, "OptionsCheckButtonTemplate")
	BankItems_OptionsFrame_MinimapButton:SetPoint("TOPLEFT", 25, -47)
	BankItems_OptionsFrame_MinimapButton:SetHitRectInsets(0, -210, 0, 0)
	BankItems_OptionsFrame_MinimapButtonText:SetText(BANKITEMS_MINIMAP_BUTTON_TEXT)
	BankItems_OptionsFrame_MinimapButton:SetScript("OnClick", function(self)
		if (BankItems_Save.ButtonShown) then
			BankItems_Save.ButtonShown = false
			BankItems_MinimapButton:Hide()
		else
			BankItems_Save.ButtonShown = true
			BankItems_MinimapButton:Show()
		end
		self:SetChecked(BankItems_Save.ButtonShown)
	end)

	-- Window Style checkbox
	local BankItems_OptionsFrame_WindowStyle = CreateFrame("CheckButton", "BankItems_OptionsFrame_WindowStyle", BankItems_OptionsFrame, "OptionsCheckButtonTemplate")
	BankItems_OptionsFrame_WindowStyle:SetPoint("TOPLEFT", 25, -69)
	BankItems_OptionsFrame_WindowStyle:SetHitRectInsets(0, -210, 0, 0)
	_G["BankItems_OptionsFrame_WindowStyleText"]:SetText(BANKITEMS_WINDOW_STYLE_TEXT)
	BankItems_OptionsFrame_WindowStyle:SetScript("OnClick", function(self)
		HideUIPanel(BankItems_Frame)
		if (BankItems_Save.WindowStyle == 2) then
			BankItems_Save.WindowStyle = 1
			self:SetChecked(false)
			BankItems_Frame:SetAttribute("UIPanelLayout-enabled", nil)
		else
			BankItems_Save.WindowStyle = 2
			self:SetChecked(true)
			BankItems_Frame:SetAttribute("UIPanelLayout-enabled", true)
			BankItems_ScaleSlider:SetValue(100)
			BankItems_Chat(BANKITEMS_BAGPARENT_CAUTION11_TEXT)
			BankItems_Chat(BANKITEMS_BAGPARENT_CAUTION12_TEXT)
		end
	end)

	-- Bag Parent checkbox
	local BankItems_OptionsFrame_BagParent = CreateFrame("CheckButton", "BankItems_OptionsFrame_BagParent", BankItems_OptionsFrame, "OptionsCheckButtonTemplate")
	BankItems_OptionsFrame_BagParent:SetPoint("TOPLEFT", 25, -91)
	BankItems_OptionsFrame_BagParent:SetHitRectInsets(0, -210, 0, 0)
	_G[BankItems_OptionsFrame_BagParent:GetName().. "Text"]:SetText(BANKITEMS_BAGPARENT_TEXT)
	BankItems_OptionsFrame_BagParent:SetScript("OnClick", function(self)
		BankItems_Frame_OnHide()
		if (BankItems_Save.BagParent == 1) then
			BankItems_Save.BagParent = 2
			self:SetChecked(true)
			BankItems_Chat(BANKITEMS_BAGPARENT_CAUTION1_TEXT)
			BankItems_Chat(BANKITEMS_BAGPARENT_CAUTION2_TEXT)
			BankItems_Chat(BANKITEMS_BAGPARENT_CAUTION3_TEXT)
			updateContainerFrameAnchors = BankItems_updateContainerFrameAnchors
			updateContainerFrameAnchors()
		elseif (BankItems_Save.BagParent == 2) then
			BankItems_Save.BagParent = 1
			self:SetChecked(false)
			for _, i in ipairs(BAGNUMBERS) do
				BagContainerAr[i]:SetScale(BankItems_Save.Scale / 100)
			end
			updateContainerFrameAnchors = BANKITEMS_UCFA
			BankItemsUpdateCFrameAnchors()
		end
	end)

	-- Behavior dropdown
	local BankItems_BehaviorDropDown = CreateFrame("Frame", "BankItems_BehaviorDropDown", BankItems_OptionsFrame, "UIDropDownMenuTemplate")
	BankItems_BehaviorDropDown:SetPoint("TOP", 0, -130)
	BankItems_BehaviorDropDown:SetHitRectInsets(16, 16, 0, 0)
	UIDropDownMenu_SetWidth(BankItems_BehaviorDropDown, 140)
	UIDropDownMenu_EnableDropDown(BankItems_BehaviorDropDown)
	local BankItems_BehaviorDropDown_Text = BankItems_BehaviorDropDown:CreateFontString("BankItems_BehaviorDropDown_Text", "BACKGROUND", "GameFontNormalSmall")
	BankItems_BehaviorDropDown_Text:SetPoint("BOTTOMLEFT", BankItems_BehaviorDropDown, "TOPLEFT", 21, 1)
	BankItems_BehaviorDropDown_Text:SetText(BANKITEMS_BEHAVIOR_TEXT)

	-- Minimap Button Radius slider
	local BankItems_ButtonRadiusSlider = CreateFrame("Slider", "BankItems_ButtonRadiusSlider", BankItems_OptionsFrame, "OptionsSliderTemplate")
	BankItems_ButtonRadiusSlider:SetWidth(240)
	BankItems_ButtonRadiusSlider:SetHeight(16)
	BankItems_ButtonRadiusSlider:SetPoint("TOP", 0, -170)
	_G[BankItems_ButtonRadiusSlider:GetName() .. 'Text']:SetText(BANKITEMS_BUTTONRADIUS_TEXT)
	_G[BankItems_ButtonRadiusSlider:GetName() .. 'Low']:SetText("0")
	_G[BankItems_ButtonRadiusSlider:GetName() .. 'High']:SetText("200")
	BankItems_ButtonRadiusSlider:SetMinMaxValues(0,200)
	BankItems_ButtonRadiusSlider:SetValueStep(1)
	BankItems_ButtonRadiusSlider:SetScript("OnValueChanged", function(self, value)
		_G[BankItems_ButtonRadiusSlider:GetName() .. 'Text']:SetText(BANKITEMS_BUTTONRADIUS_TEXT.." "..value)
		BankItems_Save.ButtonRadius = value
		BankItems_MinimapButton_UpdatePosition()
	end)

	-- Minimap Button Position slider
	local BankItems_ButtonPosSlider = CreateFrame("Slider", "BankItems_ButtonPosSlider", BankItems_OptionsFrame, "OptionsSliderTemplate")
	BankItems_ButtonPosSlider:SetWidth(240)
	BankItems_ButtonPosSlider:SetHeight(16)
	BankItems_ButtonPosSlider:SetPoint("TOP", 0, -200)
	_G[BankItems_ButtonPosSlider:GetName() .. 'Text']:SetText(BANKITEMS_BUTTONPOS_TEXT)
	_G[BankItems_ButtonPosSlider:GetName() .. 'Low']:SetText("0")
	_G[BankItems_ButtonPosSlider:GetName() .. 'High']:SetText("360")
	BankItems_ButtonPosSlider:SetMinMaxValues(0, 360)
	BankItems_ButtonPosSlider:SetValueStep(1)
	BankItems_ButtonPosSlider:SetScript("OnValueChanged", function(self, value)
		_G[BankItems_ButtonPosSlider:GetName() .. 'Text']:SetText(BANKITEMS_BUTTONPOS_TEXT.." "..value)
		BankItems_Save.ButtonPosition = value
		BankItems_MinimapButton_UpdatePosition()
	end)

	-- Transparency slider
	local BankItems_TransparencySlider = CreateFrame("Slider", "BankItems_TransparencySlider", BankItems_OptionsFrame, "OptionsSliderTemplate")
	BankItems_TransparencySlider:SetWidth(240)
	BankItems_TransparencySlider:SetHeight(16)
	BankItems_TransparencySlider:SetPoint("TOP", 0, -230)
	_G[BankItems_TransparencySlider:GetName() .. 'Text']:SetText(BANKITEMS_TRANSPARENCY_TEXT)
	_G[BankItems_TransparencySlider:GetName() .. 'Low']:SetText("25%")
	_G[BankItems_TransparencySlider:GetName() .. 'High']:SetText("100%")
	BankItems_TransparencySlider:SetMinMaxValues(25, 100)
	BankItems_TransparencySlider:SetValueStep(1)
	BankItems_TransparencySlider:SetScript("OnValueChanged", function(self, value)
		_G[BankItems_TransparencySlider:GetName() .. 'Text']:SetText(BANKITEMS_TRANSPARENCY_TEXT.." "..value.."%")
		BankItems_Save.Transparency = value
		BankItems_Frame:SetAlpha(value / 100)
	end)

	-- Scale slider
	local BankItems_ScaleSlider = CreateFrame("Slider", "BankItems_ScaleSlider", BankItems_OptionsFrame, "OptionsSliderTemplate")
	BankItems_ScaleSlider:SetWidth(240)
	BankItems_ScaleSlider:SetHeight(16)
	BankItems_ScaleSlider:SetPoint("TOP", 0, -260)
	_G[BankItems_ScaleSlider:GetName() .. 'Text']:SetText(BANKITEMS_SCALING_TEXT)
	_G[BankItems_ScaleSlider:GetName() .. 'Low']:SetText("50%")
	_G[BankItems_ScaleSlider:GetName() .. 'High']:SetText("100%")
	BankItems_ScaleSlider:SetMinMaxValues(50, 100)
	BankItems_ScaleSlider:SetValueStep(1)
	BankItems_ScaleSlider:SetScript("OnValueChanged", function(self, value)
		_G[BankItems_ScaleSlider:GetName() .. 'Text']:SetText(BANKITEMS_SCALING_TEXT.." "..value.."%")
		BankItems_Save.Scale = value
		BankItems_Frame:SetScale(value / 100)
		if (BankItems_Save.BagParent == 1) then
			for _, i in ipairs(BAGNUMBERS) do
				BagContainerAr[i]:SetScale(BankItems_Save.Scale / 100)
			end
			BankItemsUpdateCFrameAnchors()
		elseif (BankItems_Save.BagParent == 2) then
			updateContainerFrameAnchors()
		end
	end)


	-- Done button
	local BankItems_OptionsFrameDone = CreateFrame("Button", "BankItems_OptionsFrameDone", BankItems_OptionsFrame, "OptionsButtonTemplate")
	BankItems_OptionsFrameDone:SetPoint("BOTTOM", 0, 20)
	BankItems_OptionsFrameDone:SetText(DONE)
	BankItems_OptionsFrameDone:SetScript("OnClick", function(self)
		self:GetParent():Hide()
	end)
end

function BankItems_Options_Init(self, event)
	-- Initialise defaults if not present
	if (BankItems_Save.LockWindow == nil) then
		BankItems_Save.LockWindow = true
	end
	BankItems_Save.Scale = BankItems_Save.Scale or 80
	BankItems_Save.Transparency = BankItems_Save.Transparency or 100
	BankItems_Save.BagParent = BankItems_Save.BagParent or 1
	BankItems_Save.WindowStyle = BankItems_Save.WindowStyle or 1
	BankItems_Save.Behavior = BankItems_Save.Behavior or 1
	if (BankItems_Save.ExportPrefix == nil) then
		BankItems_Save.ExportPrefix = true
	end
	if (BankItems_Save.GroupExportData == nil) then
		BankItems_Save.GroupExportData = false
	end
	if (BankItems_Save.SearchAllRealms == nil) then
		BankItems_Save.SearchAllRealms = false
	end

	-- Apply saved settings
	if (BankItems_Save.LockWindow) then
		BankItems_Frame:RegisterForDrag()
	else
		BankItems_Frame:RegisterForDrag("LeftButton")
	end
	BankItems_Frame:SetScale(BankItems_Save.Scale / 100)
	BankItems_Frame:SetAlpha(BankItems_Save.Transparency / 100)
	if (BankItems_Save.BagParent == 1) then
		for _, i in ipairs(BAGNUMBERS) do
			BagContainerAr[i]:SetScale(BankItems_Save.Scale / 100)
		end
	elseif (BankItems_Save.BagParent == 2) then
		updateContainerFrameAnchors = BankItems_updateContainerFrameAnchors
	end
	BankItems_Frame:SetAttribute("UIPanelLayout-defined", "true")
	for name, value in pairs(BANKITEMS_UIPANELWINDOWS_TABLE) do
		BankItems_Frame:SetAttribute("UIPanelLayout-"..name, value)
	end
	if (BankItems_Save.WindowStyle == 1) then
		BankItems_Frame:SetAttribute("UIPanelLayout-enabled", nil)
	elseif (BankItems_Save.WindowStyle == 2) then
		BankItems_Frame:SetAttribute("UIPanelLayout-enabled", true)
	end
	UIDropDownMenu_SetWidth(BankItems_BehaviorDropDown, 220)
	BankItems_BehaviorDropDown.initialize = BankItems_BehaviorDropDown_Initialize
	BankItems_BehaviorDropDownText:SetText(BANKITEMS_BEHAVIOR2_TEXT)

	BankItems_HookTooltips()

	self:UnregisterEvent("VARIABLES_LOADED")
	self:SetScript("OnEvent", nil)
	BankItems_Options_Init = nil
end

function BankItems_BehaviorDropDown_Initialize()
	for i = 1, #BANKITEMS_BEHAVIORLIST do
		info.checked		= BankItems_Save.Behavior[i]
		info.text		= BANKITEMS_BEHAVIORLIST[i]
		info.func		= BankItems_BehaviorDropDown_OnClick
		info.arg1		= i
		info.arg2		= nil
		info.keepShownOnClick	= 1
		UIDropDownMenu_AddButton(info)
	end
end

function BankItems_BehaviorDropDown_OnClick(button, selected)
	BankItems_Save.Behavior[selected] = not BankItems_Save.Behavior[selected]
end

function BankItems_Options_OnShow()
	BankItems_OptionsFrame_LockWindow:SetChecked(BankItems_Save.LockWindow)
	BankItems_OptionsFrame_MinimapButton:SetChecked(BankItems_Save.ButtonShown)
	BankItems_OptionsFrame_WindowStyle:SetChecked(BankItems_Save.WindowStyle == 2)
	BankItems_OptionsFrame_BagParent:SetChecked(BankItems_Save.BagParent == 2)
	BankItems_ButtonRadiusSlider:SetValue(BankItems_Save.ButtonRadius)
	BankItems_ButtonPosSlider:SetValue(BankItems_Save.ButtonPosition)
	BankItems_TransparencySlider:SetValue(BankItems_Save.Transparency)
	BankItems_ScaleSlider:SetValue(BankItems_Save.Scale)
end

BankItems_OptionsFrame:RegisterEvent("VARIABLES_LOADED")
BankItems_OptionsFrame:SetScript("OnEvent", BankItems_Options_Init)
BankItems_OptionsFrame:SetScript("OnShow", BankItems_Options_OnShow)


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Export Frame

do
	local temp
	local BANKITEMS_EXPORT_BACKDROP = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
	 	insets = { left = 5, right = 5, top = 5, bottom = 5 },
	}

	-- Create the BankItems Export frame
	BankItems_ExportFrame = CreateFrame("Frame", "BankItems_ExportFrame", UIParent, "DialogBoxFrame")
	BankItems_ExportFrame:Hide()
	BankItems_ExportFrame:SetWidth(500)
	BankItems_ExportFrame:SetHeight(400)
	BankItems_ExportFrame:SetPoint("CENTER")
	BankItems_ExportFrame:EnableMouse(true)
	BankItems_ExportFrame:SetToplevel(true)
	BankItems_ExportFrame:SetMovable(true)
	BankItems_ExportFrame:SetFrameStrata("DIALOG")
	--BankItems_ExportFrame:SetBackdrop(BANKITEMS_EXPORT_BACKDROP)  4/10/2023 SetBackdrop not available in classic; specify during frame creation instead

	-- Title text
	temp = BankItems_ExportFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	temp:SetPoint("TOPLEFT", 5, -5)
	temp:SetText(BANKITEMS_VERSIONTEXT)

	-- Group Data checkbox
	local BankItems_ExportFrame_GroupData = CreateFrame("CheckButton", "BankItems_ExportFrame_GroupData", BankItems_ExportFrame, "OptionsCheckButtonTemplate")
	BankItems_ExportFrame_GroupData:SetPoint("BOTTOMLEFT", 5, 5)
	BankItems_ExportFrame_GroupData:SetHitRectInsets(0, -100, 3, 0)
	_G[BankItems_ExportFrame_GroupData:GetName() .. "Text"]:SetText(BANKITEMS_GROUP_DATA_TEXT)
	BankItems_ExportFrame_GroupData:SetScript("OnClick", function(self)
		if (BankItems_Save.GroupExportData) then
			BankItems_Save.GroupExportData = false
		else
			BankItems_Save.GroupExportData = true
		end
		self:SetChecked(BankItems_Save.GroupExportData)
		_G["BankItems_ExportFrame_ShowBagPrefix"]:SetChecked(false)
		BankItems_Save.ExportPrefix = false
		_G["BankItems_ExportFrame_ResetButton"]:Click()
	end)

	-- Show Bag Prefix checkbox
	local BankItems_ExportFrame_ShowBagPrefix = CreateFrame("CheckButton", "BankItems_ExportFrame_ShowBagPrefix", BankItems_ExportFrame, "OptionsCheckButtonTemplate")
	BankItems_ExportFrame_ShowBagPrefix:SetPoint("BOTTOMLEFT", 5, 25)
	BankItems_ExportFrame_ShowBagPrefix:SetHitRectInsets(0, -100, 0, 0)
	_G[BankItems_ExportFrame_ShowBagPrefix:GetName().."Text"]:SetText(BANKITEMS_SHOW_BAG_PREFIX_TEXT)
	BankItems_ExportFrame_ShowBagPrefix:SetScript("OnClick", function(self)
		if (BankItems_Save.ExportPrefix) then
			BankItems_Save.ExportPrefix = false
		else
			BankItems_Save.ExportPrefix = true
		end
		self:SetChecked(BankItems_Save.ExportPrefix)
		BankItems_ExportFrame_GroupData:SetChecked(false)
		BankItems_Save.GroupExportData = false
		G["BankItems_ExportFrame_ResetButton"]:Click()
	end)

	-- Search editbox
	local BankItems_ExportFrame_SearchTextbox = CreateFrame("EditBox", "BankItems_ExportFrame_SearchTextbox", BankItems_ExportFrame, "InputBoxTemplate")
	BankItems_ExportFrame_SearchTextbox:SetWidth(167)
	BankItems_ExportFrame_SearchTextbox:SetHeight(16)
	BankItems_ExportFrame_SearchTextbox:SetPoint("BOTTOMRIGHT", -10, 35)
	BankItems_ExportFrame_SearchTextbox:SetMaxLetters(50)
	BankItems_ExportFrame_SearchTextbox:SetNumeric(false)
	BankItems_ExportFrame_SearchTextbox:SetAutoFocus(false)
	BankItems_ExportFrame_SearchTextbox:SetScript("OnEnterPressed", function(self)
		_G["BankItems_ExportFrame_ResetButton"]:Click()
	end)
	BankItems_ExportFrame_SearchTextbox:SetScript("OnEscapePressed", BankItems_ExportFrame_SearchTextbox.ClearFocus)
	BankItems_ExportFrame_SearchTextbox:SetScript("OnTabPressed", function(self)
		_G["BankItems_ExportFrame_ScrollText"]:SetFocus()
	end)

	-- Search All Realms checkbox
	local BankItems_ExportFrame_SearchAllRealms = CreateFrame("CheckButton", "BankItems_ExportFrame_SearchAllRealms", BankItems_ExportFrame, "OptionsCheckButtonTemplate")
	BankItems_ExportFrame_SearchAllRealms:SetPoint("TOPLEFT", BankItems_ExportFrame_SearchTextbox, "BOTTOMLEFT", -10, 3)
	BankItems_ExportFrame_SearchAllRealms:SetHitRectInsets(0, -60, 0, 0)
	_G[BankItems_ExportFrame_SearchAllRealms:GetName().."Text"]:SetText(BANKITEMS_ALL_REALMS_TEXT)
	BankItems_ExportFrame_SearchAllRealms:SetScript("OnClick", function(self)
		if (BankItems_Save.SearchAllRealms) then
			BankItems_Save.SearchAllRealms = false
		else
			BankItems_Save.SearchAllRealms = true
		end
		self:SetChecked(BankItems_Save.SearchAllRealms)
		BankItems_ExportFrame_ResetButton:Click()
	end)

	-- Reset/Search button
	local BankItems_ExportFrame_ResetButton = CreateFrame("Button", "BankItems_ExportFrame_ResetButton", BankItems_ExportFrame, "UIPanelButtonTemplate")
	BankItems_ExportFrame_ResetButton:SetWidth(80)
	BankItems_ExportFrame_ResetButton:SetHeight(24)
	BankItems_ExportFrame_ResetButton:SetPoint("BOTTOMRIGHT", -10, 10)
	BankItems_ExportFrame_ResetButton:SetText(BANKITEMS_RESET_TEXT)
	BankItems_ExportFrame_ResetButton:SetScript("OnClick", function(self)
		if (BankItems_ExportFrame.mode == "search") then
			BankItems_ExportFrame_SearchTextbox:SetText(strtrim(BankItems_ExportFrame_SearchTextbox:GetText()))
			BankItems_ExportFrame_SearchTextbox:ClearFocus()
			BankItems_Search(BankItems_ExportFrame_SearchTextbox:GetText())
		elseif (BankItems_ExportFrame.mode == "export") then
			BankItems_GenerateExportText()
		end
	end)

	-- Main scrollframe to display results
	local BankItems_ExportFrame_Scroll = CreateFrame("ScrollFrame", "BankItems_ExportFrame_Scroll", BankItems_ExportFrame, "UIPanelScrollFrameTemplate")
	BankItems_ExportFrame_Scroll:SetToplevel(true)
	BankItems_ExportFrame_Scroll:SetWidth(455)
	BankItems_ExportFrame_Scroll:SetHeight(320)
	BankItems_ExportFrame_Scroll:SetPoint("TOP", -10, -20)
	local BankItems_ExportFrame_ScrollText = CreateFrame("EditBox", "BankItems_ExportFrame_ScrollText", BankItems_ExportFrame)
	BankItems_ExportFrame_ScrollText:SetWidth(450)
	BankItems_ExportFrame_ScrollText:SetHeight(314)
	BankItems_ExportFrame_ScrollText:SetMaxLetters(99999)
	BankItems_ExportFrame_ScrollText:SetNumeric(false)
	BankItems_ExportFrame_ScrollText:SetAutoFocus(false)
	BankItems_ExportFrame_ScrollText:SetMultiLine(true)
	BankItems_ExportFrame_ScrollText:SetFontObject(ChatFontNormal)
	BankItems_ExportFrame_ScrollText:SetScript("OnTextChanged", function(self) ScrollingEdit_OnTextChanged(self, self:GetParent()) end)
	BankItems_ExportFrame_ScrollText:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
	BankItems_ExportFrame_ScrollText:SetScript("OnUpdate", function(self, elapsed) ScrollingEdit_OnUpdate(self, elapsed, self:GetParent()) end)
	BankItems_ExportFrame_ScrollText:SetScript("OnEscapePressed", BankItems_ExportFrame_ScrollText.ClearFocus)
	BankItems_ExportFrame_ScrollText:SetScript("OnTabPressed", function(self)
		if (BankItems_ExportFrame_SearchTextbox:IsVisible()) then
		BankItems_ExportFrame_SearchTextbox:SetFocus()
			end
		end)
	BankItems_ExportFrame_Scroll:SetScrollChild(BankItems_ExportFrame_ScrollText)
end


----------------------------------------------------------------------------------
-- Code to add additional tooltip information since the lazy authors didn't hook GameTooltip:SetHyperlink()
-- but hooked everything else (:SetBagItem, :SetLootItem, :SetQuestItem, :SetQuestLogItem, :SetTradeSkillItem,
-- :SetMerchantItem, :SetAuctionItem, :SetLootRollItem, :SetInventoryItem, :SetItemRef).

function BankItems_Hook_GameTooltip_SetHyperlink(self, hyperlink)
	-- Add Saeris Lootlink extra tooltip info
	if (C_AddOns.IsAddOnLoaded("LootLink") and _G["LootLink_Database"]) then
		_G["LootLink"]:Tooltips_AddAllApplicableInfo(hyperlink, self, BankItems_Quantity)
	end
	-- Add HealPoints extra tooltip info
	if (C_AddOns.IsAddOnLoaded("HealPoints")) then
		local hp = _G["HealPoints"]
		if (hp and hp.ISHEALER == 1 and hp:IsActive()) then
			hp:DrawTooltip(self, hyperlink)
		end
	end
end
hooksecurefunc(GameTooltip, "SetHyperlink", BankItems_Hook_GameTooltip_SetHyperlink)


