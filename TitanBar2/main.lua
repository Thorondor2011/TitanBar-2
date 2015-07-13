import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";

TitanBar = {}; -- Main bar
Color = {}; -- Color DB
PlayerCurrency = {};
PlayerCurrencyHandler = {};
pluginName = "TitanBar2";
screenWidth, screenHeight = Turbine.UI.Display.GetSize();
write = Turbine.Shell.WriteLine;
LocalPlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
VaultPack = LocalPlayer:GetVault();
SharedPack = LocalPlayer:GetSharedStorage();
Backpack = LocalPlayer:GetBackpack();
PlayerName = LocalPlayer:GetName();
isFreep = LocalPlayer:GetAlignment(); --1: Free People / 2: Monster Play

-- Detect game language
Locale = Turbine.Engine.GetLanguage(); -- Legend: 0 = invalid / 2 = English / 268435457 = EnglishGB / 268435459 = Francais / 268435460 = Deutsch / 268435463 = Russian
if Locale == 268435459 then Locale = "fr";
elseif Locale == 268435460 then Locale = "de"; 
else Locale = "en";
end

-- BlendMode 1: Color / 2: Normal / 3: Multiply / 4: AlphaBlend / 5: Overlay / 6: Grayscale / 7: Screen / 8: Undefined

-- [FontName]={[Fontzise]=pixel needed to show one number}
FontN = {
	["Arial"] = {[12]=6},
	["TrajanPro"] = {[13]=7,[14]=7,[15]=7,[16]=8,[18]=9,[19]=10,[20]=10,[21]=11,[23]=11,[24]=11,[25]=7,[26]=12,[28]=13},
	["TrajanProBold"] = {[16]=9,[22]=11,[24]=12,[25]=13,[30]=15,[36]=18},
	["Verdana"] = {[10]=5,[12]=7,[14]=8,[16]=8,[18]=12,[20]=12,[22]=12,[23]=13}
	};

-- [FontName]={[Fontzise]=pixel needed to show one letter}
FontT = {
	["Arial"] = {[12]=6},
	["TrajanPro"] = {[13]=8,[14]=9,[15]=9,[16]=10,[18]=11,[19]=12,[20]=12,[21]=13,[23]=14,[24]=15,[25]=7,[26]=16,[28]=17},
	["TrajanProBold"] = {[16]=10,[22]=14,[24]=15,[25]=16,[30]=19,[36]=22},
	["Verdana"] = {[10]=5.5,[12]=7,[14]=8,[16]=9,[18]=10,[20]=11,[22]=12,[23]=12}
	};

-- ********************
-- Load data
settings = {};
if Locale == "de" then
	settings = Turbine.PluginData.Load( Turbine.DataScope.Character, "TitanBar2SettingsDE" );
elseif Locale == "en" then
	settings = Turbine.PluginData.Load( Turbine.DataScope.Character, "TitanBar2SettingsEN" );
elseif Locale == "fr" then
	settings = Turbine.PluginData.Load( Turbine.DataScope.Character, "TitanBar2SettingsFR" );
end
if settings == nil then	settings = {}; end

AppDir = "Thorondor.TitanBar2.";
import (AppDir.."TBresources");
import (AppDir.."color");
import (AppDir.."TitanBar");
import (AppDir.."BaseControlClass");
import (AppDir.."functions");
import (AppDir.."menu");

--import "Thorondor.TitanBar2.settings";
--[[import (AppClassD.."Class");
import (AppDir);
import (AppDirD.."color");
import (AppDirD.."settings");
LoadSettings();
import (AppDirD.."functionsCtr");
import (AppDirD.."functionsMenu");
import (AppDirD.."functionsMenuControl");
import (AppDirD.."OptionPanel"); -- LUA option panel file (for in-game plugin manager options tab)
import (AppDirD.."menuControl");
import (AppDirD.."frmMain");]]

-- Import Bunny's files
import "Thorondor.TitanBar2.Bunny.Class";
import "Thorondor.TitanBar2.Bunny.Type";
import "Thorondor.TitanBar2.Bunny.VindarPatch";
import "Thorondor.TitanBar2.Bunny.BaseFunc";
import "Thorondor.TitanBar2.Bunny.BaseClass";
import "Thorondor.TitanBar2.Bunny.ClassTWallet";

LoadTitanBar();
--LoadSettings();

--[[
if PlayerAlign == 1 then MenuItem = { L["MGSC"], L["MDP"], L["MSP"], L["MSM"], L["MMC"], L["MHT"], L["MMP"], L["MSL"], L["MCP"], L["MTP"], L["MASP"], L["MSOM"]};
else MenuItem = { L["MCP"], L["MTP"], L["MSOM"] }; end

TitanBarCommand = Turbine.ShellCommand()

function TitanBarCommand:Execute( command, arguments )
	if ( arguments == L["SCa1"] or arguments == "opt") then
		TitanBarMenu:ShowMenu();
	elseif ( arguments == L["SCa2"] or arguments == "u" ) then
		UnloadTitanBar();
	elseif ( arguments == L["SCa3"] or arguments == "r" ) then
		ReloadTitanBar();
	elseif ( arguments == L["SCa4"] or arguments == "ra" ) then
		ResetSettings();
	elseif ( arguments == L["SCa13"] or arguments == "?" or arguments == "sc" ) then
		HelpInfo();
	--elseif ( arguments == L["SCa??"] or arguments == "ab") then
		--AboutTitanBar();
	elseif ( arguments == "pw" ) then
		write("");
		write("This is your currency:");
		write("-----v----------------------");
		ShowTableContent(PlayerCurrency);
		write("-----^----------------------");
		write("You may request to add a currency if it's not listed in the wallet menu! Give the 'key' string to Habna so it can be added into future version of TitanBar thx!");
		write("");
	else
		ShowNS = true;
	end

	if ShowNS then write( "TitanBar: " .. L["SC0"] ); ShowNS = nil; end -- Command not supported
end

Turbine.Shell.AddCommand('TitanBar', TitanBarCommand)
]]

Turbine.Plugin.Load = function(self,sender,args)
	write("TitanBar2 v" .. self:GetVersion() .. " (c) 2015 " .. self:GetAuthor());
	-- load stuff
end
--[[Turbine.Plugin.Load = function( self, sender, args )
	write( L["TBLoad"] ); --TitanBar version loaded!
end]]

Turbine.Plugin.Unload = function(self,sender,args)
	-- unload stuff
end;
--[[Turbine.Plugin.Unload = function( self, sender, args )
	--write("Unloading TitanBar");
	SavePlayerMoney( true );
	SavePlayerBags();]
end]]
