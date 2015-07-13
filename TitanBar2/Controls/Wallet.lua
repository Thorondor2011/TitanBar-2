function TitanBar.WalletCtr:ShowWindow()
	--L = TitanBar.L;
	wcur = nil;
	import ("Thorondor.TitanBar2.ComboBox");
	self.ComboBox = Thorondor.TitanBar2.ComboBox();
	WIWLeft = settings.Wallet.L;
	WIWTop = settings.Wallet.T;
	
	-- Set some window stuff
	self.Window = Turbine.UI.Lotro.Window();
	self.Window:SetSize( 350, 550 ); --280x260
    self.Window:SetPosition( WIWLeft, WIWTop );
	self.Window:SetText( TitanBar.L.MWallet );
	self.Window:SetVisible( true );
	self.Window:SetWantsKeyEvents( true );
	self.Window:Activate();

	self.Window.KeyDown = function( sender, args )
		if ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
			self.Window:Close();
		elseif ( args.Action == 268435635 ) or ( args.Action == 268435579 ) then -- Hide if F12 key or 'ctrl + \' is press
			self.Window:SetVisible( not self.Window:IsVisible() );
		elseif ( args.Action == 162 ) then --Enter key was pressed
			self.WindowSaveButton.Click( sender, args );
		end
	end

	self.Window.MouseDown = function( sender, args )
		if ( args.Button == Turbine.UI.MouseButton.Left ) then dragging = true; end
	end

	self.Window.MouseMove = function( sender, args )
		if dragging then if self.ComboBox.dropped then self.ComboBox:CloseDropDown(); end end
	end

	self.Window.MouseUp = function( sender, args )
		dragging = false;
		settings.Wallet.L = string.format("%.0f", self.Window:GetLeft());
		settings.Wallet.T = string.format("%.0f", self.Window:GetTop());
		WIWLeft, WIWTop = self.Window:GetPosition();
		SavePluginData();
	end

	self.Window.Closing = function( sender, args )
		self.ComboBox.dropDownWindow:SetVisible(false);
		self.Window:SetWantsKeyEvents( false );
		self.Window = nil;
		frmWI = nil;
	end
	
	self.WindowLabel = Turbine.UI.Label();
	self.WindowLabel:SetParent( self.Window );
	self.WindowLabel:SetText( TitanBar.L.WIt );
	self.WindowLabel:SetPosition( 20, 35);
	self.WindowLabel:SetSize( self.Window:GetWidth()-40 , 35 );
	self.WindowLabel:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.WindowLabel:SetForeColor( Turbine.UI.Color( 0, 1, 0 ) );

	-- Set the Wallet listbox
	self.WindowListBox = Turbine.UI.ListBox();
	self.WindowListBox:SetParent( self.Window );
	self.WindowListBox:SetZOrder( 1 );
	self.WindowListBox:SetPosition( 20, self.WindowLabel:GetTop()+self.WindowLabel:GetHeight()+10 );
	self.WindowListBox:SetSize( self.Window:GetWidth()-40, self.Window:GetHeight()-105 );
	self.WindowListBox:SetMaxItemsPerLine( 1 );
	self.WindowListBox:SetOrientation( Turbine.UI.Orientation.Horizontal );
	
	-- Set the listbox scrollbar
	self.WindowListBoxScrollBar = Turbine.UI.Lotro.ScrollBar();
	self.WindowListBoxScrollBar:SetParent( self.WindowListBox );
	self.WindowListBoxScrollBar:SetZOrder( 1 );
	self.WindowListBoxScrollBar:SetOrientation( Turbine.UI.Orientation.Vertical );
	self.WindowListBox:SetVerticalScrollBar( self.WindowListBoxScrollBar );
	self.WindowListBoxScrollBar:SetPosition( self.WindowListBox:GetWidth() - 10, 0 );
	self.WindowListBoxScrollBar:SetSize( 12, self.WindowListBox:GetHeight() );
	
	self.WindowControl = Turbine.UI.Control();
	self.WindowControl:SetParent( self.Window );
	self.WindowControl:SetPosition( self.WindowListBox:GetLeft(), self.WindowListBox:GetTop() );
	self.WindowControl:SetSize( self.WindowListBox:GetWidth(), self.WindowListBox:GetHeight() );
	self.WindowControl:SetZOrder( 0 );
	self.WindowControl:SetVisible( false );
	self.WindowControl:SetBlendMode( 5 );
	self.WindowControl:SetBackground( resources.WalletWindow );

	self.WindowControl.MouseClick = function( sender, args )
		if ( args.Button == Turbine.UI.MouseButton.Right ) then
			self.ComboBox.Cleanup();
			self.WindowControl:SetVisible( false );
			self.WindowControl:SetZOrder( 0 );
		end
	end
	
	self.WindowLabelFN = Turbine.UI.Label();
	self.WindowLabelFN:SetParent( self.WindowControl );
	self.WindowLabelFN:SetPosition( 0 , self.WindowControl:GetHeight()/2 - 40 );
	self.WindowLabelFN:SetSize( self.WindowControl:GetWidth() , 15 );
	self.WindowLabelFN:SetFont( Turbine.UI.Lotro.Font.TrajanPro16 );
	self.WindowLabelFN:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.WindowLabelFN:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
	self.WindowLabelFN:SetForeColor( Turbine.UI.Color( 1, 1, 0 ) );

	ComboBoxOptions = { TitanBar.L.WIot, TitanBar.L.WIiw, TitanBar.L.WIds } --Combobox options
	
	self.ComboBox:SetParent( self.WindowControl );
	self.ComboBox:SetSize( 170, 19 );
	self.ComboBox:SetPosition( self.WindowControl:GetWidth()/2 - self.ComboBox:GetWidth()/2, self.WindowLabelFN:GetTop()+self.WindowLabelFN:GetHeight()+10 );

	self.ComboBox.dropDownWindow:SetParent( self.WindowControl );
	self.ComboBox.dropDownWindow:SetPosition(self.ComboBox:GetLeft(), self.ComboBox:GetTop() + self.ComboBox:GetHeight()+2);
	
	for k,v in pairs(ComboBoxOptions) do self.ComboBox:AddItem(v, k); end

	--[[ Turbine Point box
	TPWCtr = Turbine.UI.Control();
	TPWCtr:SetParent( self.WindowControl );
	TPWCtr:SetPosition( self.WindowListBox:GetLeft(), self.ComboBox:GetTop()+self.ComboBox:GetHeight()+10 );
	TPWCtr:SetZOrder( 2 );
	--TPWCtr:SetBackColor( Color["red"] ); -- debug purpose

	local WIlblTurbinePTS = Turbine.UI.Label();
	WIlblTurbinePTS:SetParent( TPWCtr );
	--WIlblTurbinePTS:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	WIlblTurbinePTS:SetText( L["MTP"] );
	WIlblTurbinePTS:SetPosition( 0, 2 );
	WIlblTurbinePTS:SetSize( WIlblTurbinePTS:GetTextLength() * 7.5, 15 ); --Auto size with text lenght
	WIlblTurbinePTS:SetForeColor( Color["rustedgold"] );
	WIlblTurbinePTS:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	--WIlblTurbinePTS:SetBackColor( Color["red"] ); -- debug purpose

	WItxtTurbinePTS = Turbine.UI.Lotro.TextBox();
	WItxtTurbinePTS:SetParent( TPWCtr );
	WItxtTurbinePTS:SetFont( Turbine.UI.Lotro.Font.TrajanPro14 );
	--WItxtTurbinePTS:SetText( TurbinePTS );
	WItxtTurbinePTS:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
	WItxtTurbinePTS:SetPosition( WIlblTurbinePTS:GetLeft()+WIlblTurbinePTS:GetWidth()+5, WIlblTurbinePTS:GetTop()-2 );
	WItxtTurbinePTS:SetSize( 80, 20 );
	WItxtTurbinePTS:SetMultiline( false );
	if PlayerAlign == 2 then WItxtTurbinePTS:SetBackColor( Color["red"] ); end

	WItxtTurbinePTS.FocusGained = function( sender, args )
		WItxtTurbinePTS:SelectAll();
		WItxtTurbinePTS:SetWantsUpdates( true );
	end

	WItxtTurbinePTS.FocusLost = function( sender, args )
		WItxtTurbinePTS:SetWantsUpdates( false );
	end

	WItxtTurbinePTS.Update = function( sender, args )
		local parsed_text = WItxtTurbinePTS:GetText();

		if tonumber(parsed_text) == nil or string.find(parsed_text,"%.") ~= nil then
			WItxtTurbinePTS:SetText( string.sub( parsed_text, 1, string.len(parsed_text)-1 ) );
			return
		elseif string.len(parsed_text) > 1 and string.sub(parsed_text,1,1) == "0" then
			WItxtTurbinePTS:SetText( string.sub( parsed_text, 2 ) );
			return
		end
	end

	TPWCtr:SetSize( self.WindowListBox:GetWidth(), 20 );
	]]

	self.WindowSaveButton = Turbine.UI.Lotro.Button();
	self.WindowSaveButton:SetParent( self.WindowControl );
	self.WindowSaveButton:SetText( TitanBar.L.PWSave );
	self.WindowSaveButton:SetSize( self.WindowSaveButton:GetTextLength() * 10, 15 ); --Auto size with text lenght
	--self.WindowSaveButton:SetEnabled( true );

	self.WindowSaveButton.Click = function( sender, args )
		self.WindowControl:SetVisible( false );
		self.WindowControl:SetZOrder( 0 );

		SelIndex = self.ComboBox:GetSelection();
		--Where-> 1: On TitanBar / 2: In wallet control tooltip / 3: Don't show
		for v, k in pairs(TitanBar.WalletItemCtr) do
			local wctr = TitanBar.WalletItemCtr[v];
			
			if self.wcur == v then
				wctr.Where = SelIndex;
				settings[wctr.NAME].W = string.format("%.0f", SelIndex);
				if SelIndex == 1 then 
					if not wctr.ShowMe then 
						wctr:ShowHide(); 
						break;
					end
				else 
					if wctr.ShowMe then 
						wctr:ShowHide(); 
						break;
					end 
				end
			end
		end
		SavePluginData();
		--[[

			local parsed_text = WItxtTurbinePTS:GetText();

			if parsed_text == "" then
				WItxtTurbinePTS:SetText( "0" );
				WItxtTurbinePTS:Focus();
				return
			elseif parsed_text == TurbinePTS then
				WItxtTurbinePTS:Focus();
				return
			end
			
			TurbinePTS = WItxtTurbinePTS:GetText();
			if TPWhere == 1 then UpdateTurbinePoints(); end
			SavePlayerTurbinePoints();
		end

		SaveSettings( false );]]
	end

	self:RefreshListBox();
end

function TitanBar.WalletCtr:RefreshListBox()
	self.WindowListBox:ClearItems();
	
	for i=1,#TitanBar.tempTable do
		-- Control of all data
		local Control = Turbine.UI.Control();
		Control:SetParent( self.WindowListBox );
		Control:SetSize( self.WindowListBox:GetWidth(), 20 );
		
		-- Wallet currency name
		local curLbl = Turbine.UI.Label();
		curLbl:SetParent( Control );
		curLbl:SetText( TitanBar.tempTable[i] );
		curLbl:SetSize( self.WindowListBox:GetWidth(), 20 );
		curLbl:SetPosition( 0, 0 );
		curLbl:SetFont( Turbine.UI.Lotro.Font.TrajanPro16 );
		curLbl:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
		curLbl:SetForeColor( Color.nicegold );
		--curLbl:SetBackColor( Color["blue"] ); --debug purpose
		
		curLbl.MouseClick = function( sender, args )
			if ( args.Button == Turbine.UI.MouseButton.Right ) then
				self.wcur = TitanBar.tempTable[i];
				self.WindowLabelFN:SetText( self.wcur );
				--TPWCtr:SetVisible( false );
				self.WindowSaveButton:SetPosition( self.WindowControl:GetWidth()/2 - self.WindowSaveButton:GetWidth()/2, self.ComboBox:GetTop()+self.ComboBox:GetHeight()+10 );
				
				for a,b in pairs(TitanBar.WalletItemCtr) do
					if self.wcur == TitanBar.WalletItemCtr[a].NAME then tw=TitanBar.WalletItemCtr[a].Where; end
				end

				for k, v in pairs(ComboBoxOptions) do if k == tonumber(tw) then self.ComboBox:SetSelection(k); end end

				self.WindowControl:SetVisible( true );
				self.WindowControl:SetZOrder( 2 );
				self.WindowControl:SetBackground( resources.WalletWindowRefresh );
			end
		end

		self.WindowListBox:AddItem( Control );
	end
end

function TitanBar.BaseControl:ShowHide(var)
	if var == nil then
		self.ShowMe = not self.ShowMe;
		settings[self.NAME].V = self.ShowMe;
		settings[self.NAME].W = string.format("%.0f", self.Where);
		SavePluginData();
		tempShowMe = self.ShowMe;
	elseif var == "Show" then
		tempShowMe = true;
	elseif var == "Hide" then
		tempShowMe = false;
	end

	if self.Where == 1 then	
		self.Ctr:SetPosition( self.LocX, self.LocY ); 
	end
	if self.Where ~= 3 then
		if self.Where == 1 then
			self.Lbl:SetText( GetCurrency( self.NAME ) );
			self.Lbl:SetSize( self.Lbl:GetTextLength() * TitanBar.NumMultiplier, TitanBar.CTRHeight ); --Auto size with text lenght
			if TitanBar.Height > 30 then TitanBar.CTRHeight = 30; end --Stop ajusting icon size if TitanBar height is > 30px

			local Y = -1 - ((TitanBar.IconSize - TitanBar.CTRHeight) / 2);
		
			self.Icon:SetStretchMode( 1 );
			self.Icon:SetPosition( self.Lbl:GetLeft() + self.Lbl:GetWidth() + 3, Y );
			self.Ctr:SetSize( self.Icon:GetLeft() + TitanBar.IconSize, TitanBar.CTRHeight );
			self.Icon:SetSize( TitanBar.IconSize, TitanBar.IconSize );
			self.Icon:SetStretchMode( 3 );
		end
	end
	if tempShowMe then
		self.Ctr:SetBackColor( Turbine.UI.Color( self.bcAlpha, self.bcRed, self.bcGreen, self.bcBlue ) );
	end
	self.Ctr:SetVisible( tempShowMe );
	
	-- Add/Remove Callback
	if tempShowMe then
		--tmpCTR = TitanBar.WalletItemCtr[k];
		--PlayerCurrencyHandler[self.NAME] = 
		TitanBar.WalletItemCtr[self.NAME]["handler"]=AddCallback(TitanBar.ItemList[self.NAME]["item"], "QuantityChanged", function(sender, args) UpdateCurrency(self.NAME); end);
	elseif self.Where == 3 then
		RemoveCallback(TitanBar.ItemList[self.NAME]["item"], "QuantityChanged");
	end
end

function TitanBar.WalletCtr:ShowToolTipWin(Width, Height)
	self.ToolTipWin = Turbine.UI.Window();
	self.ToolTipWin:SetZOrder( 1 );
	--_G.ToolTipWin.xOffset = x;
	--_G.ToolTipWin.yOffset = y;
	self.ToolTipWin:SetWidth( 100 );
	self.ToolTipWin:SetVisible( true );

	self.WITTListBox = Turbine.UI.ListBox();
	self.WITTListBox:SetParent( self.ToolTipWin );
	self.WITTListBox:SetZOrder( 1 );
	self.WITTListBox:SetPosition( 20, 17 );
	--WITTListBox:SetWidth( _G.ToolTipWin:GetWidth()-30 );
	self.WITTListBox:SetMaxItemsPerLine( 1 );
	self.WITTListBox:SetOrientation( Turbine.UI.Orientation.Horizontal );
	--WITTListBox:Se0tBackColor( Color["darkgrey"] ); --debug purpose

	self:RefreshWITTListBox();

	self:ApplySkin();
end

function TitanBar.WalletCtr:RefreshWITTListBox()
	self.WITTListBox:ClearItems();
	WITTPosY, totWidth = 0, 0;
	local bFound = false;
	
	for i=1,#TitanBar.tempTable do
		wttcur = TitanBar.tempTable[i];
		
		if wttcur == TitanBar.WalletItemCtr[wttcur].NAME then ttw = TitanBar.WalletItemCtr[wttcur].Where; end
		
		if ttw == 2 then
			WITTPosY = WITTPosY + 32;
			bFound = true;
		
			-- Control of all data
			local WITTCtr = Turbine.UI.Control();
			WITTCtr:SetParent( self.WITTListBox );
			WITTCtr:SetHeight( 32 );
			--WITTCtr:SetBackColor( Color["red"] ); -- Debug purpose
			
			CtrIconCodeIs = TitanBar.WalletItemCtr[wttcur].IconHex;
			CtrQtyIs = GetCurrency( TitanBar.WalletItemCtr[wttcur].NAME );
			
			--[[if wttcur == L["MGSC"] then --Money control
				local wiPosX, tmWidth = 0, 0;
				local wmoney = PlayerAtt:GetMoney();
				DecryptMoney(wmoney);
				local twmoney = { gold, silver, copper };
				--local twmoneyi = { 0x41007e7b, 0x41007e7c, 0x41007e7d }; --gold, silver, copper icon 27x21
				for w = 1, 3 do
					--**v Quantity v**
					local lblQte = Turbine.UI.Label();
					lblQte:SetParent( WITTCtr );
					lblQte:SetPosition( wiPosX+5, 0 );
					lblQte:SetText( twmoney[w] );
					lblQte:SetSize( lblQte:GetTextLength() * NM, WITTCtr:GetHeight() );
					--lblQte:SetForeColor( Color["green"] );
					lblQte:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
					tmWidth = tmWidth + lblQte:GetWidth()+5;
					--lblQte:SetBackColor( Color["red"] ); -- debug purpose
					--**^
					--**v Icon v**
					local ttIcon = Turbine.UI.Control();
					ttIcon:SetParent( WITTCtr );
					ttIcon:SetPosition( lblQte:GetLeft()+lblQte:GetWidth()-2, 5 );
					ttIcon:SetSize( 27, 21 );
					ttIcon:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
					ttIcon:SetBackground( resources.MoneyIcon[w] ); --tonumber(twmoneyi[w]) );
					tmWidth = tmWidth + ttIcon:GetWidth()-2;
					--ttIcon:SetBackColor( Color["blue"] ); -- Debug purpose
					--**^
					wiPosX = wiPosX + (lblQte:GetWidth()+ttIcon:GetWidth()+7);
					tmWidth = tmWidth + 5;
				end
				--** Get width - set tooltip width **--
				if tmWidth > totWidth then totWidth = tmWidth; end
				WITTCtr:SetWidth(totWidth);
				WITTListBox:SetWidth(totWidth);
				_G.ToolTipWin:SetWidth( totWidth+40 );
				--**
			else]] --All other control
				-- Icon
				local ttIcon = Turbine.UI.Control();
				ttIcon:SetParent( WITTCtr );
				ttIcon:SetPosition( 0, 0 );
				ttIcon:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
				ttIcon:SetWidth(32);
				ttIcon:SetBackground( CtrIconCodeIs );
				--ttIcon:SetBackColor( Color["blue"] ); -- Debug purpose
				
				--Quantity
				local lblQte = Turbine.UI.Label();
				lblQte:SetParent( WITTCtr );
				lblQte:SetPosition( 35, 0 );
				lblQte:SetText( CtrQtyIs );
				lblQte:SetSize( lblQte:GetTextLength() * TitanBar.NumMultiplier, WITTCtr:GetHeight() );
				--lblQte:SetForeColor( Color["green"] );
				lblQte:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleLeft );
				--lblQte:SetBackColor( Color.red ); -- debug purpose
				
				-- Get width - set tooltip width
				local tWidth = lblQte:GetWidth() +35;
				if tWidth > totWidth then totWidth = tWidth; end
				WITTCtr:SetWidth(totWidth);
				self.WITTListBox:SetWidth(totWidth);
				self.ToolTipWin:SetWidth( totWidth+40 );
				
				-- Resize Destiny points & Turbine points icon since it's not in 32x32
				--[[if wttcur == L["MDP"] then
					ttIcon:SetSize( 21, 22 );
					ttIcon:SetStretchMode( 1 );
					ttIcon:SetSize( 32, 32 );
					ttIcon:SetStretchMode( 3 );
				elseif wttcur == L["MTP"] then
					ttIcon:SetSize( 30, 32 )
					ttIcon:SetStretchMode( 1 );
					ttIcon:SetSize( 32, 32 );
					ttIcon:SetStretchMode( 3 );
				else ttIcon:SetSize( 32, 32 ); end]]
			--end
			self.WITTListBox:AddItem( WITTCtr );
		end
	end
	if not bFound then --If not showing any control
		WITTPosY = WITTPosY + 32;

		self.ToolTipWin:SetWidth( 300 );
		self.WITTListBox:SetWidth( self.ToolTipWin:GetWidth()-40 );

		local lblName = Turbine.UI.Label();
		lblName:SetParent( self.ToolTipWin );
		lblName:SetText( TitanBar.L.WInc );
		lblName:SetPosition( 0, 0 );
		lblName:SetSize( self.WITTListBox:GetWidth(), 32 );
		lblName:SetForeColor( Color.green );
		lblName:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
		--lblName:SetBackColor( Color["red"] ); -- debug purpose

		self.WITTListBox:AddItem( lblName );
	end

	self.WITTListBox:SetHeight( WITTPosY );
	self.ToolTipWin:SetHeight( WITTPosY + 37 );

	local mouseX, mouseY = Turbine.UI.Display.GetMousePosition();
			
	if self.ToolTipWin:GetWidth() + mouseX + 5 > screenWidth then x = self.ToolTipWin:GetWidth() - 10;
	else x = -5; end
			
	if TitanBar.Top then y = -15;
	else y = self.ToolTipWin:GetHeight() end

	self.ToolTipWin:SetPosition( mouseX - x, mouseY - y);
end

-- Updates text on visible control with new currency
function TitanBar.UpdateCurrency( name )
	if TitanBar.WalletItemCtr[name].ShowMe then
		CurQuantity=TitanBar.ItemList[NAME]["item"]:GetQuantity();
		write("...");
		write("CurQuantity");
		--self.Lbl:SetText( TitanBar.GetCurrency( self.NAME ) );
		self.Lbl:SetText( CurQuantity );
		self.Lbl:SetSize( self.Lbl:GetTextLength() * TitanBar.NumMultiplier, TitanBar.CTRHeight ); --Auto size with text lenght
	
		--if TBHeight > 30 then CTRHeight = 30; end --Stop ajusting icon size if TitanBar height is > 30px

		local Y = -1 - ((TitanBar.IconSize - TitanBar.CTRHeight) / 2);
		
		self.Icon:SetStretchMode( 1 );
		self.Icon:SetPosition( self.Lbl:GetLeft() + self.Lbl:GetWidth() - 2, Y );
		self.Ctr:SetSize( self.Icon:GetLeft() + TitanBar.IconSize, TitanBar.CTRHeight );
		self.Icon:SetSize( TitanBar.IconSize, TitanBar.IconSize );
		self.Icon:SetStretchMode( 3 );
	end
end