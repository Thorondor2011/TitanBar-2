TitanBar.L = {
TBSSCS = "TitanBar: Screen size has changed, repositioning controls...",
TBSSCD = "TitanBar: done!",
TBOpt = "Options are available by right clicking on TitanBar",

--Misc
NoData = "No other data available in API",
NA = "N/A",
You = "You: ",
ButDel = "Delete data for this character",

-- TitanBar Menu
MWallet = "Wallet",
MGSC = "Money",
MBI = "Backpack infos",
MPI = "Player infos",
MEI = "Equipment infos",
MDI = "Durability infos",
MPL = "Player Location",
MGT = "Time",
MOP = "More options",
MPP = "Profile",
MSC = "Shell commands",
MRA = "Reset all settings",
MUTB = "Unload",
MRTB = "Reload",
MATB = "About ",
MBG = "Set back color",
MCL = "Change language to ...",
MCLen = "English",
MCLfr = "French",
MCLde = "Deutsch",
MTI = "Track Items",
MVault = "Vault",
MStorage = "Shared Storage",
MDayNight = "Day & Night Time",
MReputation = "Reputation",

-- Control Menu
MCU = "Unload ...",
MCBG = "Change back color of this control",
MTBBG = "Apply TitanBar back color to ...",
MTBBGC = "this control",
MTBBGAC = "all controls",
MCRBG = "Reset back color of ...",
MCABT = "Apply this control back color to ...",
MCABTA = "all controls & TitanBar",
MCABTTB = "TitanBar",
MCRC = "Refresh ...",

-- Background window
BWTitle = "Set back color",
BWAlpha = "Alpha",
BWCurSetColor = "Currently set color",
BWApply = " Apply color to all elements",
BWSave = "Save color",
BWDef = "Default",
BWBlack = "Black",
BWTrans = "Transparent",

-- Wallet infos window
WIt = "Right click a currency name to get it's settings",
WIot = "On TitanBar",
WIiw = "In tooltip",
WIds = "Don't show",
WInc = "You track no currency!\nLeft click to see the currency list.",

-- Money infos window
MIWTitle = "Coin",
MIWTotal = "Total",
MIWAll = "Show total on TitanBar",
MIWCM = "Show player money",
MIWCMAll = "Show to all your character",
MIWSSS = "Show session statistics in tooltip",
MIWSTS = "Show today statistics in tooltip",
MIWID = " wallet info deleted!",
MIMsg = "No wallet info was found!",
MISession = "Session",
MIDaily = "Today",
MIStart = "Starting",
MIEarned = "Earned",
MISpent = "Spent",

-- Vault window
VTh = "vault",
VTnd = "No data was found for this character",
VTID = " vault info deleted!",
VTSe = "Search:",
VTAll = "-- All --",

-- Shared Storage window
SSh = "shared storage",
SSnd = "Need to open your shared storage at least once",

-- Backpack window
BIh = "backpack",
BID = " bags info deleted!",

-- Bank window
BKh = "bank",

-- Day & Night window
Dawn = "Dawn",
Morning = "Morning",
Noon = "Noon",
Afternoon = "Afternoon",
Dusk = "Dusk",
Gloaming = "Gloaming",
Evening = "Evening",
Midnight = "Midnight",
LateWatches = "Late Watches",
Foredawn = "Foredawn",
NextT = "Show next time",
TAjustL = "Timer seed",

-- Reputation window
RPt = "select / unselect a faction\nright click to get it's settings",
RPnf = "You track no faction!\nLeft click to see the faction list.",
RPMSR = "Maximum standing reached",
RPGL1 = "Neutral",
RPGL2 = "Acquaintance",
RPGL3 = "Friend",
RPGL4 = "Ally",
RPGL5 = "Kindred",
RPBL1 = "Outsider",
RPBL2 = "Enemy",--need traduction
RPBL3 = "bad 3",--need traduction
RPBL4 = "bad 4",--need traduction
RPBL5 = "bad 5",--need traduction
RPGG1 = "Initiate",
RPGG2 = "Apprentice",
RPGG3 = "Journeyman",
RPGG4 = "Expert",
RPGG5 = "Artisan",
RPGG6 = "Master",
RPGG7 = "Eastemnet Master",
RPGG8 = "Westemnet Master",

-- Infamy/Renown window
--if PlayerAlign == 1 then IFWTitle = "Renown", IFIF = "Total renown:",
--else IFWTitle = "Infamy", IFIF = "Total infamy:", end
IFCR = "Your rank:",
IFTN = "points for the next rank",

-- GameTime window
GTWTitle = "Real/Server Time",
GTW24h = "Show time in 24 hour format",
GTWSST = "Show server time       GMT",
GTWSBT = "Show real & server time",
GTWST = "Server: ",
GTWRT = "Real: ",

-- More Options window
OPWTitle = MOP,
OPHText = "Height:",
OPFText = "Font:",
OPAText = "Auto hide:",
OP_AH_D = "Disabled",
OP_AH_A = "Always",
OP_AH_C = "Only in combat",
OPIText = "Icon size:",
OPTBTop = "At top of screen",
OPISS = "Small",
OPISM = "Medium",
OPISL = "Large",

-- Profile window
PWLoad = "Load", 
PWSave = "Save",
PWCreate = "Create",
PWCancel = "Cancel",
PWNFound = "No profile was found",
PWEPN = "Enter a profile name",
PWProfil = "Profile",
PWDeleted = "deleted",
PWLoaded = "loaded",
PWFail = "This profile cannot be loaded because the language of the game is not the same language of this profile",

-- Shell commands window
SCWTitle = "TitanBar Shell Commands",
SCWC1 = "Show TitanBar Options",
SCWC2 = "Unload TitanBar",
SCWC3 = "Reload TitanBar",
SCWC4 = "Reset all settings to default",

-- Shell commands
SC0 = "Command not supported",
SCa1 = "options",
SCb1 = "opt / ",
SCa2 = "unload",
SCb2 = "  u / ",
SCa3 = "reload",
SCb3 = "  r / ",
SCa4 = "resetall",
SCb4 = " ra / ",

-- Durability infos window
DWTitle = "Durability infos",
DWLbl = " damaged item",
DWLbls = " damaged items",
DWLblND = "All your items are at 100%",
DIIcon = "Show icon in tooltip",
DIText = "Show item name in tooltip",
DWnint = "Not showing icon & item name",

-- Equipment infos window
EWLbl = "Items currently on your character",
EWLblD = "Score",
EWItemNP = " Item not present",
EWST1 = "Head",
EWST2 = "Left Earring",
EWST3 = "Right Earring",
EWST4 = "Necklace",
EWST5 = "Shoulder",
EWST6 = "Back",
EWST7 = "Chest",
EWST8 = "Left Bracelet",
EWST9 = "Right Bracelet",
EWST10 = "Left Ring",
EWST11 = "Right Ring",
EWST12 = "Gloves",
EWST13 = "Legs",
EWST14 = "Feet",
EWST15 = "Pocket",
EWST16 = "Primary Weapon",
EWST17 = "Secondary Weapon/Shield",
EWST18 = "Ranged Weapon",
EWST19 = "Craft Tool",
EWST20 = "Class",

-- Player Infos control
Morale = "Morale",
Power = "Power",
Armour = "Armour",
Stats = "Statistics",
Might = "Might",
Agility = "Agility",
Vitality = "Vitality",
Will = "Will",
Fate = "Fate",
Finesse = "Finesse",
Mitigations = "Mitigations",
Common = "Common",
Fire = "Fire",
Frost = "Frost",
Shadow = "Shadow",
Lightning = "Lightning",
Acid = "Acid",
Physical = "Physical",
Tactical = "Tactical",
Healing = "Healing",
Outgoing = "Outgoing",
Incoming = "Incoming",
Avoidances = "Avoidances",
Block = "Block",
Parry = "Parry",
Evade = "Evade",
Resistances = "Resistance",
Base = "Base",
CritAvoid = "Crit. Defence",
CritChance = "Crit. Chance",
Mastery = "Mastery",
Level = "Level",
Race = "Race",
Class = "Class",
XP = "Exp.",
NXP = "Next lvl at",
MLvl = "Maximum level reached",
Offence = "Offence",
Defence = "Defence",
Wrath = "Wrath",
Orc = "Orc-craft",
Fell = "Fell-wrought",
Melee = "Melee dam.",
Ranged = "Ranged dam.",
CritHit = "Crit. hit",
CritMag = "Crit. mag.",
DevHit = "Dev. hit",
DevMag = "Dev. mag.",
CritDef = "Crit. defence",
Partial = "partial",
Capped = "Values in YELLOW are CAPPED.",

-- Money Infos control
MGh = "Quantity of gold",
MSh = "Quantity of silver",
MCh = "Quantity of copper",
MGB = "Bag of Gold Coins", -- Thx Heridan!
MSB = "Bag of Silver Coins", -- Thx Heridan!
MCB = "Bag of Copper Coins", -- Thx Heridan!

-- Bag Infos control
BINI = "You track no item!\nLeft click to see your items.",
BIIL = "Items list",
BIT = "Select / unselect an item",
BIUsed = " Show used over free slots",
BIMax = " Show total bag slots",
BIMsg = "No stackable item was found in your bag!",

-- Equipment Infos control
EIh = "Points for all your equipment",
EIt1 = "Left click to open the options window",
EIt2 = "Hold left click to move the control",
EIt3 = "Right click to open the control menu",

-- Durability Infos control
DIh = "Durability of all your equipment",

-- Player Location control
PLh = "This is where you are",
PLMsg = "Enter a City!",

-- Game Time control
GTh = "Real/Server Time",

-- Chat message
TBR = "TitanBar: All my settings are set back to default",

-- Character Race
Elf = "Elf",
Man = "Man",
Dwarf = "Dwarf",
Hobbit = "Hobbit",
Beorning = "Beorning",

-- Free People Class
Burglar = "Burglar",
Captain = "Captain",
Champion = "Champion",
Guardian = "Guardian",
Hunter = "Hunter",
LoreMaster = "Lore-Master",
Minstrel = "Minstrel",
RuneKeeper = "Rune-Keeper",
Warden = "Warden",

-- Monster Play Class
Reaver = "Reaver",
Weaver = "Weaver",
Blackarrow = "Blackarrow",
Warleader = "Warleader",
Stalker = "Stalker",
Defiler = "Defiler",

-- Durability
D = "Durability",
D1 = "All Durability",
D2 = "Weak",
D3 = "Substantial",
D4 = "Brittle",
D5 = "Normal",
D6 = "Tough",
D7 = "Filmsy",
D8 = "Indestructible",

-- Quality
Q = "Quality",
Q1 = "All Quality",
Q2 = "Common",
Q3 = "UnCommon",
Q4 = "Incomparable",
Q5 = "Rare",
Q6 = "Legendary"
};