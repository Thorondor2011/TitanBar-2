-- BIG TODO: CHANGE ALL "NAME.BCALPHA"  TO "SETINGS.NAME.BCALPHA" - - BUT FIRST CHECK IF IT WORKS (SAVING)

function LoadTitanBar()
	--[[TitanBar.settings = {};
	settings = TitanBar.settings;
	
	if Locale == "de" then
		settings = Turbine.PluginData.Load( Turbine.DataScope.Character, "TitanBar2SettingsDE" );
	elseif Locale == "en" then
		settings = Turbine.PluginData.Load( Turbine.DataScope.Character, "TitanBar2SettingsEN" );
	elseif Locale == "fr" then
		settings = Turbine.PluginData.Load( Turbine.DataScope.Character, "TitanBar2SettingsFR" );
	end
	if settings == nil then settings={}; end]]
	
	-- Check if TitanBar Reloader/Unloader is loaded
	Turbine.PluginManager.RefreshAvailablePlugins();
	loaded_plugins = Turbine.PluginManager.GetLoadedPlugins();

	TBRChecker = Turbine.UI.Control();
	TBRChecker:SetWantsUpdates( true );
	
	TBRChecker.Update = function( sender, args )
		for k,v in pairs(loaded_plugins) do
			if v.Name == "TitanBar2 Reloader" then
				Turbine.PluginManager.UnloadScriptState( 'TitanBar2Reloader' );
				--break;
			end
			if v.Name == "TitanBar2 Unloader" then
				Turbine.PluginManager.UnloadScriptState( 'TitanBar2Unloader' );
				--break;
			end
		end
		TBRChecker:SetWantsUpdates( false );
	end
	
	-- Load settings
	if Locale == "en" then	tA, tR, tG, tB, tX, tY, tW = 0.3, 0.3, 0.3, 0.3, 0, 0, 3;
	else tA, tR, tG, tB, tX, tY, tW = "0,3", "0,3", "0,3", "0,3", "0", "0", "3"; end
	tL, tT = 100, 100; --Default position of control window
	
	if settings.TitanBar == nil then settings.TitanBar = {}; end
	if settings.TitanBar.A == nil then settings.TitanBar.A = string.format("%.3f", tA); end --Default Alpha color value
	if settings.TitanBar.R == nil then settings.TitanBar.R = string.format("%.3f", tR); end --Default Red color value
	if settings.TitanBar.G == nil then settings.TitanBar.G = string.format("%.3f", tG); end --Default Green color value
	if settings.TitanBar.B == nil then settings.TitanBar.B = string.format("%.3f", tB); end --Default Blue color value
	if settings.TitanBar.W == nil then settings.TitanBar.W = string.format("%.0f", screenWidth); end -- Default TitanBar Width
	if settings.TitanBar.L == nil then settings.TitanBar.L = Locale; end -- Default TitanBar Language
	if settings.TitanBar.H == nil then settings.TitanBar.H = string.format("%.0f", 30); end -- Default TitanBar Height
	if settings.TitanBar.F == nil then settings.TitanBar.F = string.format("%.0f", 1107296268); end -- Default TitanBar Font type #
	if settings.TitanBar.T == nil then settings.TitanBar.T = "TrajanPro14"; end -- Default TitanBar Font name
	if settings.TitanBar.D == nil then settings.TitanBar.D = true; end -- True ->TitanBar set to Top of the screen
	if settings.TitanBar.Z == nil then settings.TitanBar.Z = false; end -- TitanBar was reloaded
	TitanBar.bcAlpha = tonumber(settings.TitanBar.A);
	TitanBar.bcRed = tonumber(settings.TitanBar.R);
	TitanBar.bcGreen = tonumber(settings.TitanBar.G);
	TitanBar.bcBlue = tonumber(settings.TitanBar.B);
	TitanBar.Width = tonumber(settings.TitanBar.W);
	local TBLocale = settings.TitanBar.L;
	import ("Thorondor.TitanBar2.Translations."..TBLocale); -- Load Language file
	TitanBar.Height = tonumber(settings.TitanBar.H);
	if TitanBar.Height > 30 then TitanBar.CTRHeight = 30 else TitanBar.CTRHeight = TitanBar.Height; end
	TitanBar.Font = tonumber(settings.TitanBar.F);
	TitanBar.FontT = settings.TitanBar.T;
	
	local tStrS = tonumber(string.sub( TitanBar.FontT, string.len(TitanBar.FontT) - 1, string.len(TitanBar.FontT) )); --Get Font Size
	tStr = string.sub( TitanBar.FontT, 1, string.len(TitanBar.FontT) - 2 ); --Get Font name
	if tStrS == nil then tStrS = 0; end
	TitanBar.NumMultiplier = FontN[tStr][tStrS]; --Number multiplier
	TitanBar.TextMultiplier = FontT[tStr][tStrS]; --Text multiplier
	TitanBar.Top = settings.TitanBar.D;
	TitanBar.Reloaded = settings.TitanBar.Z;
	TitanBar.ReloadedText = settings.TitanBar.ZT;

	if settings.Options == nil then settings.Options = {}; end
	if settings.Options.L == nil then settings.Options.L = string.format("%.0f", tL); end --X position of options window
	if settings.Options.T == nil then settings.Options.T = string.format("%.0f", tT); end --Y position of options window
	if settings.Options.H == nil then settings.Options.H = TitanBar.L.OP_AH_D; end --Auto hide option (Default is: Only in combat) --L.OPAHC
	if settings.Options.I == nil then settings.Options.I = string.format("%.0f", 32); end --Icon size (Default is: 32)
	--TitanBar.OptionsWindow.Left = tonumber(settings.Options.L);
	--TitanBar.OptionsWindow.Top = tonumber(settings.Options.T);
	
	TitanBar.AutoHide = settings.Options.H;
	-- If user changes language, Auto hide option not showing in proper language. Fix: Re-input correct word in variable.
	if TitanBar.AutoHide == "Disabled" or TitanBar.AutoHide == "D\195\169sactiver" or TitanBar.AutoHide == "niemals" then TitanBar.AutoHide = TitanBar.L.OP_AH_D; end
	if TitanBar.AutoHide == "Always" or TitanBar.AutoHide == "Toujours" or TitanBar.AutoHide == "immer" then TitanBar.AutoHide = TitanBar.L.OP_AH_A; end
	if TitanBar.AutoHide == "Only in combat" or TitanBar.AutoHide == "Seulement en combat" or TitanBar.AutoHide == "Nur in der Schlacht" then TitanBar.AutoHide = TitanBar.L.OP_AH_C; end

	TitanBar.IconSize = settings.Options.I;
	-- If user changes language, icon disappears. Fix: Re-input correct word in variable.
	if TitanBar.IconSize == "Small (16x16)" or TitanBar.IconSize == "Petit (16x16)" or TitanBar.IconSize == "klein (16x16)" then TitanBar.IconSize = TitanBar.L.OP_IS_S;
	elseif TitanBar.IconSize == "Medium (32x32)" or TitanBar.IconSize == "Moyen (32x32)" then TitanBar.IconSize = TitanBar.L.OP_IS_M;
	elseif TitanBar.IconSize == "Large (32x32)" or TitanBar.IconSize == "Grand (32x32)" or TitanBar.IconSize == "Breit (32x32)" then TitanBar.IconSize = TitanBar.L.OP_IS_L; end
	
	
	if settings.Profile == nil then settings.Profile = {}; end
	--settings.Profile.V = nil; --Remove after oct, 15th 2013
	if settings.Profile.L == nil then settings.Profile.L = string.format("%.0f", tL); end
	if settings.Profile.T == nil then settings.Profile.T = string.format("%.0f", tT); end
	--TitanBar.ProfileWindow.Left = tonumber(settings.Profile.L);
	--TitanBar.ProfileWindow.Top = tonumber(settings.Profile.T);


	if settings.Shell == nil then settings.Shell = {}; end
	if settings.Shell.L == nil then settings.Shell.L = string.format("%.0f", tL); end --X position of Shell commands window
	if settings.Shell.T == nil then settings.Shell.T = string.format("%.0f", tT); end --Y position of Shell commands window
	--TitanBar.ShellWindow.Left = tonumber(settings.Shell.L);
	--TitanBar.ShellWindow.Top = tonumber(settings.Shell.T);


	if settings.Background == nil then settings.Background = {}; end
	if settings.Background.Left == nil then settings.Background.Left = string.format("%.0f", tL); end --X position of Background window
	if settings.Background.Top == nil then settings.Background.Top = string.format("%.0f", tT); end --Y position of Background window
	if settings.Background.ToAll == nil then settings.Background.ToAll = false; end --ToAll option
	--TitanBar.BGWindow.Left = tonumber(settings.Background.L);
	--TitanBar.BGWindow.Top = tonumber(settings.Background.T);
	--TitanBar.BGWindow.ToAll = settings.Background.A;
	
	TitanBar.Window = Turbine.UI.Window();
	if TitanBar.Top then TitanBar.Window:SetPosition( 0, 0 );
	else TitanBar.Window:SetPosition( 0, screenHeight - TitanBar.Height ); end
	TitanBar.Window:SetSize( screenWidth, TitanBar.Height );
	TitanBar.Window:SetBackColor( Turbine.UI.Color( TitanBar.bcAlpha, TitanBar.bcRed, TitanBar.bcGreen, TitanBar.bcBlue ) );
	TitanBar.Window:SetWantsKeyEvents( true );
	TitanBar.Window:SetVisible( true );
	TitanBar.Window:Activate();

	--[[ fix these
	LoadPlayerMoney();
	LoadPlayerVault();
	LoadPlayerSharedStorage();
	LoadPlayerBags();
	LoadPlayerReputation();
	LoadPlayerTurbinePoints();
	LoadPlayerItemTrackingList();
	LoadPlayerProfile();]]
	
	-- Load Player Wallet
	TitanBar.Wallet = LocalPlayer:GetWallet();
	WalletSize = TitanBar.Wallet:GetSize();
	
	TitanBar.ItemList = {};
	for f=1, WalletSize do
		WalletItem = TitanBar.Wallet:GetItem(f)
		name = WalletItem:GetName();
		TitanBar.ItemList[name]={};
		TitanBar.ItemList[name]["name"]=name;
		TitanBar.ItemList[name]["desc"]=WalletItem:GetDescription();
		TitanBar.ItemList[name]["ico"]=WalletItem:GetSmallImage();
		TitanBar.ItemList[name]["big"]=WalletItem:GetImage();
		TitanBar.ItemList[name]["qty"]=WalletItem:GetQuantity();
		TitanBar.ItemList[name]["item"]=WalletItem;
	end
	
	TitanBar.tempTable = {};
	local I = 0;
	for k,v in pairs(TitanBar.ItemList) do
		table.insert(TitanBar.tempTable, k);
		I = I + 1;
	end
	table.sort(TitanBar.tempTable);
	
	TitanBar.WalletCtr = TitanBar.BaseControl({Icon=resources.Wallet, ToolTip="Wallet", NAME="Wallet"});
	TitanBar.WalletCtr:AddMenuItem();
	import ("Thorondor.TitanBar2.Controls.Wallet");
	TitanBar.WalletItemCtr = {};
	for i = 1,I do
		local WalletItemName = TitanBar.tempTable[i];
		local init = {Icon = TitanBar.ItemList[WalletItemName]["big"], 
					  ToolTip = TitanBar.ItemList[WalletItemName]["desc"], 
					  NAME = WalletItemName}
		TitanBar.WalletItemCtr[WalletItemName] = TitanBar.BaseControl(init);
		TitanBar.WalletItemCtr[WalletItemName].IsWalletItem = true;
		TitanBar.WalletItemCtr[WalletItemName]:ShowHide(TitanBar.WalletItemCtr[WalletItemName].ShowMe);
	end
	
	--[[PlayerWalletSize = TitanBar.Wallet:GetSize();
	
	for i = 1, PlayerWalletSize do
		local CurItem = TitanBar.Wallet:GetItem(i);
		local CurName = TitanBar.Wallet:GetItem(i):GetName();

		PlayerCurrency[CurName] = CurItem;
		if PlayerCurrencyHandler[CurName] == nil then PlayerCurrencyHandler[CurName] = AddCallback(PlayerCurrency[CurName], "QuantityChanged", function(sender, args) TitanBar.WalletItemCtr[CurName]:UpdateCurrency(CurName); end); end
	end]]
	
	--PlayerWalletSize = TitanBar.Wallet:GetSize();
	--write(tostring(PlayerWalletSize));
	--[[if PlayerWalletSize ~= 0 then 
		for i = 1, PlayerWalletSize do
			local CurItem = TitanBar.Wallet:GetItem(i);
			local CurName = TitanBar.Wallet:GetItem(i):GetName();

			PlayerCurrency[CurName] = CurItem;
			--if PlayerCurrencyHandler[CurName] == nil then PlayerCurrencyHandler[CurName] = AddCallback(PlayerCurrency[CurName], "QuantityChanged", function(sender, args) UpdateCurrency(CurName); end); end
		end
	end]]
	
	-- TitanBar event handlers
	TitanBar.Window.KeyDown = function( sender, args )
		if ( args.Action == 268435635 ) then -- Hide if F12 key is pressed
			if not CSPress then
				TitanBar.Window:SetVisible( not TitanBar.Window:IsVisible() );
				if not windowOpen then MouseHoverCtr:SetVisible( not MouseHoverCtr:IsVisible() ); end
			end
			F12Press = not F12Press;
		elseif ( args.Action == 268435579 ) then -- Hide if (Ctrl + \) is pressed
			if not F12Press then
				TitanBar.Window:SetVisible( not TitanBar.Window:IsVisible() );
				if not windowOpen then MouseHoverCtr:SetVisible( not MouseHoverCtr:IsVisible() ); end
			end
			CSPress = not CSPress;
		end
	end

	TitanBar.Window.MouseMove = function( sender, args )
		windowOpen = false;
		AutoHideCtr:SetWantsUpdates( true );
	end

	TitanBar.Window.MouseLeave = function( sender, args )
		if LocalPlayer:IsInCombat() and windowOpen and TitanBar.AutoHide ~= TitanBar.L.OP_AH_D then AutoHideCtr:SetWantsUpdates( true );
		elseif TitanBar.AutoHide == TitanBar.L.OP_AH_A then AutoHideCtr:SetWantsUpdates( true ); end
	end
	
	TitanBar.Window.MouseClick = function( sender, args )
		TitanBar.Window.MouseMove();

		if ( args.Button == Turbine.UI.MouseButton.Right ) then
			mouseXPos, mouseYPos = Turbine.UI.Display.GetMousePosition();
			--_G.sFromCtr = "TitanBar";
			TitanBarMenu:ShowMenu();
		end
	end

	TitanBar.Window.MouseDoubleClick = function( sender, args )
		ReloadTitanBar();
	end
	-- TitanBar event handlers - END

	MouseHoverCtr = Turbine.UI.Window();
	MouseHoverCtr:SetPosition( (TitanBar.Window:GetWidth() / 2) - 125 , TitanBar.Window:GetHeight() );
	MouseHoverCtr:SetSize( 250, 15 );
	MouseHoverCtr:SetBackground( resources.HoverBG ); 

	MouseHoverCtr.MouseHover = function( sender, args )
		AutoHideCtr:SetWantsUpdates( true );
	end
	
	AutoHideCtr = Turbine.UI.Control();
	AutoHideCtr.Update = function( sender, args )
		if windowOpen then
			MouseHoverCtr:SetVisible( false );
			if TitanBar.Top then --TitanBar is at top
				if ( TitanBar.Window:GetTop() + TitanBar.Window:GetHeight() == 0 ) then
					AutoHideCtr:SetWantsUpdates( false );
					windowOpen = false;
					MouseHoverCtr:SetVisible( true );
					MouseHoverCtr:SetTop( TitanBar.Window:GetTop() + TitanBar.Window:GetHeight() );
				else
					TitanBar.Window:SetTop( TitanBar.Window:GetTop() - 1 );
				end
			else  --TitanBar is at bottom
				if ( TitanBar.Window:GetTop() == screenHeight ) then
					AutoHideCtr:SetWantsUpdates( false );
					windowOpen = false;
					MouseHoverCtr:SetVisible( true );
					MouseHoverCtr:SetTop( TitanBar.Window:GetTop() - MouseHoverCtr:GetHeight() );
				else
					TitanBar.Window:SetTop( TitanBar.Window:GetTop() + 1 );
				end
			end
		else
			MouseHoverCtr:SetVisible( false );
			if TitanBar.Top then --TitanBar is at top
				if ( TitanBar.Window:GetTop() == 0 ) then
					AutoHideCtr:SetWantsUpdates( false );
					windowOpen = true;
				else
					TitanBar.Window:SetTop( TitanBar.Window:GetTop() + 1 );
				end
			else --TitanBar is at bottom
				if ( TitanBar.Window:GetTop() + TitanBar.Window:GetHeight() == screenHeight ) then
					AutoHideCtr:SetWantsUpdates( false );
					windowOpen = true;
				else
					TitanBar.Window:SetTop( TitanBar.Window:GetTop() - 1 );
				end
			end
		end
	end
	
	--PlayerCurrency = {};
	--PlayerCurrencyHandler = {};

	-- fix
	if TitanBar.Reloaded and TitanBar.ReloadedText == "Profile" then opt_profile.Click(); end -- TitanBar was reloaded because a profile need to be loaded
	if TitanBar.Reloaded and TitanBar.ReloadedText == "Font" then opt_options.Click(); end -- TitanBar was reloaded because a font need to be loaded

	if TitanBar.AutoHide == TitanBar.L.OP_AH_A then AutoHideCtr:SetWantsUpdates( true ); end -- Auto hide if needed

	--[[if isFreep then
		if PlayerWalletSize ~= nil or PlayerWalletSize ~= 0 then
			if _G.SPWhere ~= 3 then ImportCtr( "SP" ); end
			if _G.SMWhere ~= 3 then ImportCtr( "SM" ); end
			if _G.MCWhere ~= 3 then ImportCtr( "MC" ); end
			if _G.HTWhere ~= 3 then ImportCtr( "HT" ); end
			if _G.MPWhere ~= 3 then ImportCtr( "MP" ); end
			if _G.SLWhere ~= 3 then ImportCtr( "SL" ); end
			if _G.CPWhere ~= 3 then ImportCtr( "CP" ); end
			-- AU3 MARKER 1 - DO NOT REMOVE
	        if _G.ASPWhere ~= 3 then ImportCtr( "ASP" ); end
			if _G.SOMWhere ~= 3 then ImportCtr( "SOM" ); end
			-- AU3 MARKER 1 END
		end
	else
		-- Disable DurabilityInfos, EquipInfos, DestinyPoints, Shard, SkirmishMark, Medallion, Seal, Vault, SharedStoreage. (Infos not usefull in Monster Play)
		ShowDurabilityInfos, ShowEquipInfos, ShowDestinyPoints, ShowShards, ShowSkirmishMarks, ShowHytboldTokens, ShowMedallions, ShowSeals, ShowVault, ShowSharedStorage, ShowReputation = false, false, false, false, false, false, false, false, false, false, false;
		-- AU3 MARKER 2 - DO NOT REMOVE
	    ShowAmrothSilverPiece = false
		ShowStarsofMerit = false
		-- AU3 MARKER 2 END
		if PlayerWalletSize ~= nil or PlayerWalletSize ~= 0 then
			if ShowWallet then ImportCtr( "WI" ); end
			if _G.CPWhere ~= 3 then ImportCtr( "CP" ); end
			if _G.TPWhere ~= 3 then ImportCtr( "TP" ); end
		end
	end]]

	--[[ Pseudo code
	
	if ControlName.ShowMe then ImportCtr( ControlName ); end
	
	
	if ShowWallet then ImportCtr( "WI" ); end
	if _G.MIWhere ~= 3 then ImportCtr( "MI" ); end
	if _G.DPWhere ~= 3 then ImportCtr( "DP" ); end
	--if _G.SPWhere ~= 3 then import (AppCtrD.."Shards"); end --if _G.SPWhere ~= 3 then ImportCtr( "SP" ); end  --Put back when wallet info are available before plugin load
	--if _G.SMWhere ~= 3 then import (AppCtrD.."SkirmishMarks"); end --if _G.SMWhere ~= 3 then ImportCtr( "SM" ); end --Put back when wallet info are available before plugin load
	--if _G.MPWhere ~= 3 then import (AppCtrD.."Medallions"); end --if _G.MPWhere ~= 3 then ImportCtr( "MP" ); end  --Put back when wallet info are available before plugin load
	--if _G.SLWhere ~= 3 then import (AppCtrD.."Seals"); end --if _G.SLWhere ~= 3 then ImportCtr( "SL" ); end  --Put back when wallet info are available before plugin load
	--if _G.CPWhere ~= 3 then import (AppCtrD.."Commendations"); end --if _G.CPWhere ~= 3 then ImportCtr( "CP" ); end  --Put back when wallet info are available before plugin load
	if ShowTrackItems then ImportCtr( "TI" ); end --Track Items
	if ShowInfamy then ImportCtr( "IF" ); end --Infamy/Renown
	if ShowVault then ImportCtr( "VT" ); end --Vault
	if ShowSharedStorage then ImportCtr( "SS" ); end --SharedStorage
	--if ShowBank then ImportCtr( "BK" ); end --Bank
	if ShowDayNight then ImportCtr( "DN" ); end --Day & Night time
	if ShowReputation then ImportCtr( "RP" ); end --Reputation Points
	if _G.TPWhere ~= 3 then ImportCtr( "TP" ); end --Turbine Points

	--**v Workaround for the ItemRemoved that fire before the backpack was updated (Turnine API issue) v**
	ItemRemovedTimer = Turbine.UI.Control();
	
	ItemRemovedTimer.Update = function( sender, args )
		ItemRemovedTimer:SetWantsUpdates( false );
		UpdateBackpackInfos();
	end
	--**
	
	if ShowBagInfos then ImportCtr( "BI" );	end
	if ShowPlayerInfos then ImportCtr( "PI" ); end
	if ShowPlayerLoc then ImportCtr( "PL" ); end
	if ShowGameTime then ImportCtr( "GT" ); end

	if ShowDurabilityInfos or ShowEquipInfos then
		GetEquipmentInfos();
		AddCallback(PlayerEquipment, "ItemEquipped", function(sender, args) if ShowEquipInfos then GetEquipmentInfos(); UpdateEquipsInfos(); end if ShowDurabilityInfos then GetEquipmentInfos(); UpdateDurabilityInfos(); end end);
		AddCallback(PlayerEquipment, "ItemUnequipped", function(sender, args) ItemUnEquippedTimer:SetWantsUpdates( true ); end); --Workaround
		--AddCallback(PlayerEquipment, "ItemUnequipped", function(sender, args) if ShowEquipInfos then GetEquipmentInfos(); UpdateEquipsInfos(); end if ShowDurabilityInfos then GetEquipmentInfos(); UpdateDurabilityInfos(); end end);
	end
	
	--**v Workaround for the ItemUnequipped that fire before the Equipment was updated (Turnine API issue) v**
	ItemUnEquippedTimer = Turbine.UI.Control();

	ItemUnEquippedTimer.Update = function( sender, args )
		if ShowEquipInfos then GetEquipmentInfos(); UpdateEquipsInfos(); end
		if ShowDurabilityInfos then GetEquipmentInfos(); UpdateDurabilityInfos(); end
		ItemUnEquippedTimer:SetWantsUpdates( false );
	end
	--**
	
	if ShowEquipInfos then ImportCtr( "EI" ); end
	if ShowDurabilityInfos then ImportCtr( "DI" ); end
	
	--**v Run those function at-starup only once, because if TitanBar is loaded with in-game plugin manager some control does not update properly v**
	OneTimer = Turbine.UI.Control();
	AllTimer = Turbine.UI.Control();
	AllTimer:SetWantsUpdates( true );
	
	if ShowEquipInfos or ShowDurabilityInfos then OneTimer:SetWantsUpdates( true ); AllTimer:SetWantsUpdates( false ); NumSec = 0; Interval = 2; end
	if TBReloaded then OneTimer:SetWantsUpdates( false ); settings.TitanBar.Z = false; settings.TitanBar.ZT = "TB"; SaveSettings( false ); end --TitanBar was reloaded

	OneTimer.Update = function( sender, args )
		local currentdate = Turbine.Engine.GetDate();
		local currentsecond = currentdate.Second;
		if _G.Debug then max = 6; else max = 24; end
		if NumSec < max then -- Run for 24 secs.
			if (oldsecond ~= currentsecond) then
				if Interval == 0 then
					if ShowEquipInfos or ShowDurabilityInfos then GetEquipmentInfos();
						if PlayerEquipment ~= nil then
							if ShowEquipInfos then ImportCtr( "EI" ); end
							if ShowDurabilityInfos then ImportCtr( "DI" ); end
						end
					end

					if _G.Debug then write( "OneTimer: Interval" );	end

					Interval = 2;
				else
					Interval = Interval - 1;
				end
				
				oldsecond = currentsecond;
				NumSec = NumSec + 1;

				if _G.Debug then
					if NumSec <= 1 then seconds = "sec"; else seconds = "secs"; end
					write( "OneTimer: " .. NumSec .. " " .. seconds );
				end
			end
		else
			AllTimer:SetWantsUpdates( true );
			OneTimer:SetWantsUpdates( false );
		end
	end
	--**
	
	--**v Run those functions all the time v**	
	AllTimer.Update = function( sender, args )
		local currentdate = Turbine.Engine.GetDate();
		local currentminute = currentdate.Minute;
		local currentsecond = currentdate.Second;
		
		if (oldminute ~= currentminute) then
			if ShowGameTime then-- Until i found the minute Changed event or something similar
				if _G.ShowBT then UpdateGameTime("bt");
				elseif _G.ShowST then UpdateGameTime("st");
				else UpdateGameTime("gt") end
			end
		end
		
		if (oldsecond ~= currentsecond) then
			--Detect if wallet size has changed
			if PlayerWallet:GetSize() ~= PlayerWalletSize then -- Until i found the size Changed event or something similar in wallet
				LoadPlayerWallet();
				if _G.SPWhere ~= 3 then ImportCtr( "SP" ); end
				if _G.SMWhere ~= 3 then ImportCtr( "SM" ); end
				if _G.MCWhere ~= 3 then ImportCtr( "MC" ); end
				if _G.HTWhere ~= 3 then ImportCtr( "HT" ); end
				if _G.MPWhere ~= 3 then ImportCtr( "MP" ); end
				if _G.SLWhere ~= 3 then ImportCtr( "SL" ); end
				if _G.TPWhere ~= 3 then ImportCtr( "CP" ); end
				-- AU3 MARKER 3 - DO NOT REMOVE
	            if _G.ASPWhere ~= 3 then ImportCtr( "ASP" ); end
				if _G.SOMWhere ~= 3 then ImportCtr( "SOM" ); end
				-- AU3 MARKER 3 END
			end

			screenWidth, screenHeight = Turbine.UI.Display.GetSize();
			if TBWidth ~= screenWidth then ReplaceCtr(); end --Replace control if screen width has changed

			if ShowDayNight then UpdateDayNight(); end
		end

		oldminute = currentminute;
		oldsecond = currentsecond;

		--When player log out & log in with same character, the durability control show -1%
		--Because equipment info are not avail when re-login, weird!
		--if PlayerAlign == 1 and ShowDurabilityInfos then if DI["Lbl"]:GetText() == "-1%" then GetEquipmentInfos(); UpdateDurabilityInfos(); end end
	end
	--**]]
end

function ReloadTitanBar()
	settings.TitanBar.Z = true;
	SavePluginData();
	Turbine.PluginManager.LoadPlugin( 'TitanBar2 Reloader' );
end