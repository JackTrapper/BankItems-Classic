-- BankItems enUS Locale File
-- Yes, there is only one line of localization in this file.

BANKITEMS_LOCALIZATION = setmetatable({}, {__index = function(self, key)
	self[key] = key
	return key
end})
local L = BANKITEMS_LOCALIZATION

L["BANKITEMS_CAUTION_TEXT"] = "CAUTION: Some items were not parsed/displayed in this report because they do not exist in your WoW local cache yet. A recent WoW patch or launcher update caused the local cache to be cleared. Log on this character and visit the bank to correct this OR hover your mouse on every item in every bag to query the server for each itemlink (this may disconnect you).\n"



--Hawksy partial fix, many of the following aren't otherwise known to the code
BINDING_HEADER_BANKITEMS		= "BankItems Bindings";
BINDING_NAME_TOGGLEBANKITEMS		= "Toggle BankItems";
BINDING_NAME_TOGGLEBANKITEMSALL		= "Toggle BankItems and all Bags";
BINDING_NAME_TOGGLEBANKITEMSBANK	= "Toggle BankItems and all Bank Bags";

BANKITEMS_VERSIONTEXT	= "BankItems Classic v2.56";
BANKITEMS_HELPTEXT1 	= "Type /bi or /bankitems to open BankItems";
BANKITEMS_HELPTEXT2 	= "-- /bi all : open BankItems and all bags";
BANKITEMS_HELPTEXT3 	= "-- /bi allbank : open BankItems and all bank bags only";
BANKITEMS_HELPTEXT4 	= "-- /bi clear : clear currently selected player's info";
BANKITEMS_HELPTEXT5 	= "-- /bi clearall : clear all players' info";
BANKITEMS_HELPTEXT6 	= "-- /bi showbutton : show the minimap button";
BANKITEMS_HELPTEXT7 	= "-- /bi hidebutton : hide the minimap button";
BANKITEMS_HELPTEXT8 	= "-- /bi search itemname : search for items";

BANKITEMS_MINIMAPBUTTON_TOOLTIP		= "BankItems";
BANKITEMS_MINIMAPBUTTON_TOOLTIP2	= "Left-click to open BankItems."
BANKITEMS_MINIMAPBUTTON_TOOLTIP3	= "Right-click and drag to move this button."

BANKITEMS_OPTION_TEXT		= "Options...";
BANKITEMS_OPTIONS_TEXT		= "BankItems Options";
BANKITEMS_LOCK_MAIN_WINDOW_TEXT	= "Lock main window from being moved";
BANKITEMS_MINIMAP_BUTTON_TEXT	= "Show the minimap button";
BANKITEMS_WINDOW_STYLE_TEXT	= "Open BankItems with Blizzard windows";
BANKITEMS_BAGPARENT_TEXT	= "Open BankItems bags with Blizzard bags";
BANKITEMS_BEHAVIOR_TEXT		= [[On the command "/bi":]];
BANKITEMS_BEHAVIOR2_TEXT	= "Open BankItems and...";
BANKITEMS_BUTTONRADIUS_TEXT	= "Minimap Button Radius";
BANKITEMS_BUTTONPOS_TEXT	= "Minimap Button Position";
BANKITEMS_TRANSPARENCY_TEXT	= "Transparency";
BANKITEMS_SCALING_TEXT		= "Scaling";
BANKITEMS_RESET_TEXT		= "Reset";
BANKITEMS_SEARCH_TEXT		= "Search";

BANKITEMS_USERDROPDOWN_TOOLTIP_TEXT	= "You are viewing this player's bank contents.";
BANKITEMS_ALLREALMS_TOOLTIP_TEXT	= "Check to show all saved characters, regardless of realm.";
BANKITEMS_ALLREALMS_TEXT		= "All Realms";
BANKITEMS_EXPORTBUTTON_TEXT		= "Export BankItems...";
BANKITEMS_SEARCHBUTTON_TEXT		= "Search BankItems...";
BANKITEMS_EQUIPPED_ITEMS_TEXT		= "Equipped Items";
BANKITEMS_MAILBOX_ITEMS_TEXT		= "Items in Mailbox";
BANKITEMS_MAILBOX_MONEY_TEXT		= "Money (cumulative)";

BANKITEMS_BEHAVIORLIST = {
	"Open bank bags",
	"Open inventory bags",
	"Open equipped bag"
}
--	"Open mail bag",

BANKITEMS_BAGPARENT_CAUTION1_TEXT	= "Caution - Using this option may taint the petbar and";
BANKITEMS_BAGPARENT_CAUTION2_TEXT	= "prevent it from showing in combat. You are recommended to";
BANKITEMS_BAGPARENT_CAUTION3_TEXT	= "turn it off and then reloadui if you encounter problems.";
BANKITEMS_BAGPARENT_CAUTION11_TEXT	= "Note - Blizzard frames doesn't like it if your";
BANKITEMS_BAGPARENT_CAUTION12_TEXT	= "scale isn't 100% when using this option.";

BANKITEMS_ALL_DELETED_TEXT		= "All players' data have been cleared.";
BANKITEMS_DATA_NOT_FOUND_TEXT		= "Equipped items data not found/recorded. Please log on this character once to record it.";
BANKITEMS_MAILDATA_NOT_FOUND_TEXT	= "Mailbox items data not found/recorded. Please visit the mailbox on this character once to record it.";
BANKITEMS_BAG_NOT_INIT_TEXT		= "Bank bag is empty, and not initialized.";
BANKITEMS_NO_DATA_TEXT			= "No data exists for ";

BANKITEMS_SHOW_BAG_PREFIX_TEXT		= "Show bag prefix";
BANKITEMS_GROUP_DATA_TEXT		= "Group similar items";
BANKITEMS_ALL_REALMS_TEXT		= "All Realms";

BANKITEMS_BANK_TEXT	= "Bank";
BANKITEMS_BAGS_TEXT	= "Bags";
BANKITEMS_MAIL_TEXT	= "Mail";
