BankItems v60002
==============

17th October 2014
For use with Live Servers v6.0.2.19034.

An addon that remembers the contents of your bank, bags, mail, equipped, currency, AH, void storage and display them anywhere in the world. Also able to remember/display the banks of any character on the same account on any server, as well as searching and exporting lists of bag/bank items out.

Type /bi or /bankitems to see what is currently in your bank. You must visit your bank once to initialize. Type /bigb or /bankitemsgb to see what is currently in your bank. You must visit your guildbank once to initialize.

- /bi clear : clear currently selected player's info
- /bigb clear : clear currently selected guild's info

Read below for other commands.

BankItems will also remember the contents of Guild Banks if you are able to view them. Use /bigb to see them. Note that Guild Banks are a shared repository and changes can occur to it by other members of your guild.

FuBar plugin for BankItems
--------------

http://www.wowace.com/projects/bank-items-fu/

These plugins allow clicking on the panel/plugin icon to open BankItems, giving a summarized view of inventory slots and money of each character on the same realm, and deleting data with the menu quickly.

Titan Panel plugin for BankItems
--------------------------

http://wowui.incgamers.com/?p=mod&m=3848

Note: I no longer support the Titan Panel plugin and its current author is not me.

LDB plugin for BankItems
-------------------

BankItems provides a LDB launcher if LibDataBroker-1.1 is detected to be loaded.

Commands
-----------

- /bi : open BankItems
- /bi all : open BankItems and all bags
- /bi allbank: open BankItems and all bank bags only
- /bi clear : clear currently selected player's info
- /bi clearall : clear all players' info
- /bi showbuttun : show the minimap button
- /bi hidebutton : hide the minimap button
- /bi open charname : open bank of charname on the same server
- /bi charname : open bank of charname on the same server
- /bi search itemname : search for items
- /bis itemname : search for items
- /bigb : open BankItems guild bank
- /bigb clear : clear currently selected guild's info

Most options are found in the GUI options panel.

Not a bug
----------

If you close your bank after retrieving/storing an item in it too quickly and the server hasn't updated your inventory, BankItems is unable to record the change to your bank when the item actually moves later. The WoW API does not give you any data about your bank once BANK_FRAME_CLOSED event has fired.

Tooltip information regarding items on the Auction House, Mailbox and Guild Bank(s) may be out of date and thus be inaccurate. They will only be updated on your next visit to the respective places.

Credits
---------

Original concept from Merphle
Last maintained by JASlaughter, then Galmok@Stormrage-EU.

Change Log
===========

Changes from v50003 to v60000 (17 October 2014)
-----------------

- For use with Live Server v6.0.2.19034
- NEW: Added Reagent Bank support


Changes from v50002 to v50003 (13 October 2012)
-----------------

- For use with Live Servers v5.0.5.16135.
- FIXED: Fixed incorrect item linking bug introduced in the last update.

Changes from v50001 to v50002 (7 October 2012)
--------------

- For use with Live Servers v5.0.5.16057.
- UPDATED: Add workaround for crash problems with the game client if the user has taint log enabled.
- NEW: Added Void Storage support (thanks cybermind)
- FIXED: Fix the bug where a 4-slot or smaller sized bag doesn't display the bottom background texture.

Changes from v40300 to v50001 (23 September 2012)
----------------

- For use with Live Servers v5.0.5.16057.
- UPDATED: Upgrade all saved data to new itemlinks format.
- UPDATED: Added search filtering. Does not work for bankitems guild bank.
- FIXED: Remove Keyring and ranged slot + ammo (thanks iceeagle), and remove their data.
- NEW: Add ptBR and itIT localization files - the actual localizations are not in though.

Changes from v40200 to v40300 (3 December 2011)
---------------

- For use with Live Servers v4.3.0.15050.
- FIXED: Fix errors caused by patch 4.3 when visiting the Auction House.
- TO BE IMPLEMENTED: Void Storage/Bag search filter.

Changes from v40000 to v40200 (3 July 2011)
-----------------

- For use with Live Servers v4.2.0.14333.
- FIXED: Fix errors with the export/search result frame's scrolling edit box.
- UPDATED: Reimplemented currency recording.

Changes from v30300 to v40000 (13 October 2010)
------------------

- For use with Live Servers v4.0.1.13164 or Cataclysm Beta Servers v4.0.3.13117.
- UPDATED: All stored data for items are updated to the Cataclysm item format.
- FIXED: Fix bug where ammo is not registering as unequipped when you unequip ammo.
FIXED: Fix error that occurs for freshly created characters.
UPDATED: Items with the same name but with different itemIDs (such as heroic and non-heroic versions of the same item) are now treated as different items in the tooltips.
UPDATED: Upgrade all saved data to Cataclysm itemlinks.
NEW: Add "/bi open charname" and "/bi charname" command to open the bank of desired character on the same server.
TODO: Currency recording is temporarily disabled. The live servers, beta servers and PTR servers are too different.
Changes from v30200 to v30300 (24 December 2009)

For use with Live Servers v3.3.0.11159.
FIXED: Ammo will no longer count double when equipped.
NEW: Add support for oGlow (github version - http://github.com/haste/oGlow, not the wowinterface one).
Changes from v30100 to v30200 (16 August 2009)

For use with Live Servers v3.2.0.10192.
NEW: Added a checkbox to toggle displaying data from the opposite faction (affects both dropdowns and tooltips).
UPDATED: Items on the Auction House are now shown in the tooltip information. Note that this information can be inaccurate if these items are sold or expired.
Changes from v30002 to v30100 (9th June 2009)

FIXED: Fix rare "selfPlayer (nil value)" error.
UPDATED: Remove all pre-Wrath compatibility code.
UPDATED: Export now exports equipped gear as well.
UPDATED: BankItems now uses the WoWAce localization system at http://www.wowace.com/projects/bank-items/localization/
UPDATED: Update BankItems tooltip information to work with LinkWrangler's dynamic frame creation.
UPDATED: Linking items from BankItems should now behave like the default UI (including being able to link into the AH search box).
UPDATED: Significantly reduce string garbage generation. Also some code optimizations.
UPDATED: When taking items from the mailbox, the tooltip information is now updated immediately.
UPDATED: Add esES localization.
NEW: Currency tokens are now recorded.
NEW: The contents of the Keyring are now recorded.
NEW: Items you have put up for auction are now recorded when you visit the Auction House. These items are not included in searches or tooltips.
NEW: Register a LDB launcher if LDB-1.1 is detected during VARIABLES_LOADED.
NEW: BankItems will now only show/search characters and guilds from the same faction and realm. You will need to login at least once per character/guild for BankItems to save faction information otherwise these characters will no longer show up unless the "Show/Search All Realms" checkbox is checked.
Changes from v30001 to v30002 (24th October 2008)

FIXED: Fix errors that occur when used with HealPoints.
FIXED: Fix errors that occur when clearing data of a player/guildbank.
REMOVED: Removed support for Saeris' Lootlink, which is discontinued and no longer works in patch 3.0.2.
Changes from v30000 to v30001 (15th October 2008)

For use with Live Servers v3.0.2.9056 or WotLK Beta Servers v3.0.2.9061.
FIXED: Fix errors that appear when opening the Addon options frame.
Changes from v24001 to v30000 (14th October 2008)

For use with Live Servers v3.0.2.9056 or WotLK Beta Servers v3.0.2.9061.
FIXED: Fix errors resulting from the base UI code being rewritten to use locals and "self" arguments in WotLK.
UPDATED: Delay creation of some 600+ child frames and textures (mostly item buttons) until they are shown (saves 50kb). Experimental. May screw up Skinner.
UPDATED: Add upgrade function to convert old TBC format links to new WotLK format links.
Changes from v24000 to v24001 (16th May 2008)

For use with Live Servers v2.4.2.8278.
CODING: Removed redundant semicolons and brackets.
FIXED: Fix deleted/returned flags that mark if a mail item is going to be deleted or returned when it expires. Existing incorrect flags remain incorrect until you next visit the mailbox.
UPDATED: BankItems no longer stores iconpath data or itemcount data if it is 1. This results in roughly 30% reduction in savedvariable size.
Changes from v23003 to v24000 (27th March 2008)

For use with Live Servers v2.4.0.8089.
ADDED: Store mail expiry time for each item in the mailbox.
ADDED: New option to ignore soulbound items that are not stackable for tooltip information.
UPDATED: Moved the options window into the default UI's new Interace Options panel.
Changes from v23002 to v23003 (9th January 2008)

For use with Live Servers v2.3.2.7741.
FIXED: Fix for BankItems.lua: 3894: attempt to call global 'GetUIPanelWindowInfo' (a nil value)
Changes from v23001 to v23002 (2nd January 2008)

FIXED: Add a tooltip:Show() to force tooltip repainting after adding tooltip information.
FIXED: *Very* aggressively cache tooltip text that is added for performance (slight memory increase).
FIXED: Switched method of hooking tooltips to improve performance (credit to Siz).
FIXED: Rebuild alt-cache on returning items to an existing alt.
ADDED: Added a button to open BIGB in BankItems.
For older changes going all the way back to 2006, read the first part of BankItems.lua.
