TitanBar.BaseControl = class(Turbine.Object);

-- Constructor and init
function TitanBar.BaseControl:Constructor(init)
	Turbine.Object.Constructor( self );
	
	-- init control
	self.IconHex = init.Icon;
	self.ToolTip = init.ToolTip;
	self.NAME = init.NAME;
	self.IsControl = true;
	
	--load settings
	self:LoadSettings();
	
	--set control
	self.Ctr = Turbine.UI.Control()
	self.Ctr:SetParent( TitanBar.Window );
	self.Ctr:SetMouseVisible( false );
	self.Ctr:SetZOrder( 2 );
	self.Ctr:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.Ctr:SetBackColor( Turbine.UI.Color( self.bcAlpha, self.bcRed, self.bcGreen, self.bcBlue ) );
	self.Ctr:SetVisible( self.ShowMe ); --if where = titanbar else tooltip
	self.Ctr:SetPosition( self.LocX, self.LocY );
	
	--set icon
	self.Icon = Turbine.UI.Control();
	self.Icon:SetParent( self.Ctr );
	self.Icon:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	self.Icon:SetSize( 32, 32 );
	self.Icon:SetBackground( self.IconHex );
  
	--set label
	self.Lbl = Turbine.UI.Label();
	self.Lbl:SetParent( self.Ctr );
	self.Lbl:SetFont( TBFont );
	self.Lbl:SetPosition( 0, 0 );
	self.Lbl:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Lbl:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
	
	-- Movement functions
	self.Icon.MouseMove = function( sender, args )
		self.Lbl.MouseMove( sender, args );
		TitanBar.Window.MouseMove();
		if self.dragging then self.MoveCtr(sender, args, self); end
	end

	self.Icon.MouseLeave = function( sender, args )
		self.Lbl.MouseLeave( sender, args );
	end

	self.Icon.MouseClick = function( sender, args )
		self.Lbl.MouseClick( sender, args );
	end

	self.Icon.MouseDown = function( sender, args )
		self.Lbl.MouseDown( sender, args );
	end

	self.Icon.MouseUp = function( sender, args )
		self.Lbl.MouseUp( sender, args );
	end
  
	self.Lbl.MouseMove = function( sender, args )
		self.Lbl.MouseLeave( sender, args );
		TitanBar.Window.MouseMove();
		if self.dragging then
			self.MoveCtr(sender, args, self);
		else
			local Tot = string.len(self.ToolTip);--:GetTextLength();
			H=round(Tot/40)*15+50;
			self:ShowToolTipWin(0,H);
		end
	end

	self.Lbl.MouseLeave = function( sender, args )
		self:ResetToolTipWin();
	end

	self.Lbl.MouseClick = function( sender, args )
		TitanBar.Window.MouseMove();
		if ( args.Button == Turbine.UI.MouseButton.Left ) then
			if not self.WasDrag then
				--show window
				self:ShowWindow();
			end
		elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
			self:ShowMenu();
		end
		self.WasDrag = false;
	end

	self.Lbl.MouseDown = function( sender, args )
		if ( args.Button == Turbine.UI.MouseButton.Left ) then
			self.Ctr:SetZOrder( 3 );
			self.dragStartX = args.X;
			self.dragStartY = args.Y;
			self.dragging = true;
		end
	end

	self.Lbl.MouseUp = function( sender, args )
		self.Ctr:SetZOrder( 2 );
		self.dragging = false;
		self.LocX = self.Ctr:GetLeft();
		settings[self.NAME].X = string.format("%.0f", self.LocX);
		self.LocY = self.Ctr:GetTop();
		settings[self.NAME].Y = string.format("%.0f", self.LocY);
		SavePluginData();
	end
end

-- Show/Hide control
function TitanBar.BaseControl:ShowHide()
	self.ShowMe = not self.ShowMe;
	settings[self.NAME].V = self.ShowMe;
	SavePluginData();
	if self.ShowMe then
		--ImportCtr( "BI" );
		self.Ctr:SetBackColor( Turbine.UI.Color( self.bcAlpha, self.bcRed, self.bcGreen, self.bcBlue ) );
	else
		--RemoveCallback(backpack, "ItemAdded");
		--RemoveCallback(backpack, "ItemRemoved");
		--if _G.frmBI then wBI:Close(); end
	end
	self.Ctr:SetVisible( self.ShowMe );
	write(self.NAME);
	self.MenuOpt:SetChecked( self.ShowMe );
end

-- Load control settings
function TitanBar.BaseControl:LoadSettings()
	if Locale == "en" then	tA, tR, tG, tB, tX, tY, tW = 0.3, 0.3, 0.3, 0.3, 0, 0, 3;
	else tA, tR, tG, tB, tX, tY, tW = "0,3", "0,3", "0,3", "0,3", "0", "0", "3"; end --Default alpha, red, green, blue, X, Y pos of control, Show where
	tL, tT = 100, 100; --Default position of control window
	
	--if settings[self.NAME] == nil then settings[self.NAME]  = {}; end
		
	if settings[self.NAME] == nil then settings[self.NAME] = {}; end
	if settings[self.NAME].V == nil then settings[self.NAME].V = false; end
	if settings[self.NAME].A == nil then settings[self.NAME].A = string.format("%.3f", tA); end
	if settings[self.NAME].R == nil then settings[self.NAME].R = string.format("%.3f", tR); end
	if settings[self.NAME].G == nil then settings[self.NAME].G = string.format("%.3f", tG); end
	if settings[self.NAME].B == nil then settings[self.NAME].B = string.format("%.3f", tB); end
	if settings[self.NAME].X == nil then settings[self.NAME].X = string.format("%.0f", tX); end
	if settings[self.NAME].Y == nil then settings[self.NAME].Y = string.format("%.0f", tY); end
	if settings[self.NAME].W == nil then settings[self.NAME].W = string.format("%.0f", tW); end
	if settings[self.NAME].L == nil then settings[self.NAME].L = string.format("%.0f", tL); end
	if settings[self.NAME].T == nil then settings[self.NAME].T = string.format("%.0f", tT); end
	
	self.ShowMe = settings[self.NAME].V;
	
	self.bcAlpha = tonumber(settings[self.NAME].A);
	self.bcRed = tonumber(settings[self.NAME].R);
	self.bcGreen = tonumber(settings[self.NAME].G);
	self.bcBlue = tonumber(settings[self.NAME].B);
	self.LocX = tonumber(settings[self.NAME].X);
	self.LocY = tonumber(settings[self.NAME].Y);
	self.Where = tonumber(settings[self.NAME].W);
	self.Left = tonumber(settings[self.NAME].L);
	self.Top = tonumber(settings[self.NAME].T);
	--if self.Where == 3 and self.ShowMe then self.Where = 1; settings[self.NAME].W = string.format("%.0f", self.Where); end --Remove after Oct, 15th 2013
		
	SavePluginData();
end

-- Add control to main TitanBar right-click menu
function TitanBar.BaseControl:AddMenuItem()
	--local opt_line = Turbine.UI.MenuItem("---------------------------------------------", false);
	--local opt_empty = Turbine.UI.MenuItem("", false);
	
	self.MenuOpt = Turbine.UI.MenuItem(self.NAME);
	self.MenuOpt:SetChecked( self.ShowMe );
	self.MenuOpt.Click = function( sender, args ) 
		self:ShowHide(); 
		self.MenuOpt:SetChecked( self.ShowMe );
		TitanBarMenu:ShowMenuAt(mouseXPos, mouseYPos); 
	end
	TitanBarMenu.items:Add(self.MenuOpt);
end

-- Move the control  
function TitanBar.BaseControl.MoveCtr(sender, args, self)
	local CtrLocX = self.Ctr:GetLeft();
	local CtrWidth = self.Ctr:GetWidth();
	CtrLocX = CtrLocX + ( args.X - self.dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = self.Ctr:GetTop();
	local CtrHeight = self.Ctr:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - self.dragStartY );
	if CtrLocY + CtrHeight > TitanBar.Window:GetHeight() then CtrLocY = TitanBar.Window:GetHeight() - CtrHeight; end
	if CtrLocY < 0 then CtrLocY = 0; end
	self.Ctr:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end
  
-- Show the ToolTip for control
function TitanBar.BaseControl:ShowToolTipWin(Width, Height)
    local bblTo, x, y, w = "left", -5, -15, 0; 
	local mouseX, mouseY = Turbine.UI.Display.GetMousePosition();
	
	if Width == nil or Width == 0 then
		w = 310;
		if Locale == "fr" then w = 315;
		elseif Locale == "de" then
			if ToShow == "DI" then w = 225; 
			else w = 305; end
		end
	else
		w = Width;
	end
  
    if w + mouseX > screenWidth then bblTo = "right"; x = w - 10; end
	
	if Height == nil or Height == 0 then
		h = 65;
	else
		h = Height;
	end
	
	if not TitanBar.Top then y = h; end
	
	--createToolTipWin( x, y, w, h, bblTo, self.ToolTip, _G.L["EIt2"], _G.L["EIt3"] );
    local txt = {"text1", "text2"}--, "text3"};
	self.ToolTipWin = Turbine.UI.Window();
	self.ToolTipWin:SetSize( w, h );
	self.ToolTipWin:SetZOrder( 1 );
	--ToolTipWin.xOffset = x;
	--ToolTipWin.yOffset = y;
	
	self:ApplySkin();

	lblheader = Turbine.UI.Label();
	lblheader:SetParent( self.ToolTipWin );
	lblheader:SetPosition( 40, 7 ); --10
	lblheader:SetSize( w-80, h-14 );
	--lblheader:SetForeColor( Turbine.UI.Color( 0, 1, 0 ) );--Color.green
	lblheader:SetForeColor( Color.green );
	lblheader:SetFont(Turbine.UI.Lotro.Font.Verdana16);
	lblheader:SetText( self.NAME );
	
	local lbltext = Turbine.UI.Label();
	lbltext:SetParent( self.ToolTipWin );
	lbltext:SetPosition( 40, 25 ); --10
	lbltext:SetSize( w-80, h-15 );
	--lbltext:SetForeColor( Turbine.UI.Color( 1, 1, 1 ) );--Color["white"]
	lbltext:SetForeColor( Color.white );
	lbltext:SetFont(Turbine.UI.Lotro.Font.Verdana14);
	lbltext:SetText( self.ToolTip );
	
	--[[for i = 1, #txt do
		local lbltext = Turbine.UI.Label();
		lbltext:SetParent( self.ToolTipWin );
		lbltext:SetPosition( 40, YPos ); --10
		lbltext:SetSize( w, 15 );
		lbltext:SetForeColor( Turbine.UI.Color( 1, 1, 1 ) );--Color["white"]
		lbltext:SetFont(Turbine.UI.Lotro.Font.Verdana14);
		lbltext:SetText( txt[i] );
		YPos = YPos + 15;
	end]]
	
	self.ToolTipWin:SetPosition( mouseX - x, mouseY - y);
	self.ToolTipWin:SetVisible( true );
  end
  
-- Show right-click control menu
function TitanBar.BaseControl:ShowMenu()
	--local L = TitanBar.L
	-- Apply TitanBar background to... menu
--[[	local ATBBMenu = Turbine.UI.MenuItem( TitanBar.L.MTBBG );
	ATBBMenu.Items = ATBBMenu:GetItems();

	local ATBBMenu1 = Turbine.UI.MenuItem( TitanBar.L.MTBBGC);
	ATBBMenu1.Click = function( sender, args ) BGColor( "match", "this", self ); end
	ATBBMenu.Items:Add( ATBBMenu1 );

	local ATBBMenu2 = Turbine.UI.MenuItem( TitanBar.L.MTBBGAC );
	ATBBMenu2.Click = function( sender, args ) BGColor( "match", "ctr", self ); end
	ATBBMenu.Items:Add( ATBBMenu2 );


	-- Reset back color of... menu
	local RBGMenu = Turbine.UI.MenuItem( TitanBar.L.MCRBG );
	RBGMenu.Items = RBGMenu:GetItems();

	local RBGMenu1 = Turbine.UI.MenuItem( TitanBar.L.MTBBGC );
	RBGMenu1.Click = function( sender, args ) BGColor( "reset", "this", self ); end
	RBGMenu.Items:Add( RBGMenu1 );

	local RBGMenu2 = Turbine.UI.MenuItem( TitanBar.L.MTBBGAC );
	RBGMenu2.Click = function( sender, args ) BGColor( "reset", "ctr", self ); end
	RBGMenu.Items:Add( RBGMenu2 );

	local RBGMenu3 = Turbine.UI.MenuItem( TitanBar.L.MCABTA );
	RBGMenu3.Click = function( sender, args ) BGColor( "reset", "all", self ); end
	RBGMenu.Items:Add( RBGMenu3 );


	-- Apply control back color to ... menu
	local ABGTMenu = Turbine.UI.MenuItem( TitanBar.L.MCABT );
	ABGTMenu.Items = ABGTMenu:GetItems();

	local ABGTMenu1 = Turbine.UI.MenuItem( TitanBar.L.MCABTA );
	ABGTMenu1.Click = function( sender, args ) BGColor( "apply", "all", self ); end
	ABGTMenu.Items:Add( ABGTMenu1 );

	local ABGTMenu2 = Turbine.UI.MenuItem( TitanBar.L.MTBBGAC );
	ABGTMenu2.Click = function( sender, args ) BGColor("apply", "ctr", self); end
	ABGTMenu.Items:Add( ABGTMenu2 );

	local ABGTMenu3 = Turbine.UI.MenuItem( TitanBar.L.MCABTTB );
	ABGTMenu3.Click = function( sender, args ) BGColor( "apply", "TitanBar", self ); end
	ABGTMenu.Items:Add( ABGTMenu3 );
]]

	-- Unload ... menu
	local UnloadMenu = Turbine.UI.MenuItem( TitanBar.L.MCU );
	UnloadMenu.Items = UnloadMenu:GetItems();

	local UnloadMenu1 = Turbine.UI.MenuItem( TitanBar.L.MTBBGC ); -- unload this control
	UnloadMenu1.Click = function( sender, args ) self:UnloadControl(); end
	UnloadMenu.Items:Add( UnloadMenu1 );

	local UnloadMenu2 = Turbine.UI.MenuItem( TitanBar.L.MTBBGAC ); -- unload all controls
	UnloadMenu2.Click = function( sender, args ) UnloadAllControls(); end
	UnloadMenu.Items:Add( UnloadMenu2 );


	ControlMenu = Turbine.UI.ContextMenu();
	ControlMenu.items = ControlMenu:GetItems();
--[[
	local option_line = Turbine.UI.MenuItem("-------------------------------------------", false);
	local option_empty = Turbine.UI.MenuItem("", false);

	local option_Background = Turbine.UI.MenuItem( TitanBar.L.MCBG );
	option_Background.Click = function( sender, args ) self:SetBackgroundColor(); end


	ControlMenu.items:Add(option_Background);]]
	--ControlMenu.items:Add(ATBBMenu);
	--ControlMenu.items:Add(RBGMenu);
	--ControlMenu.items:Add(ABGTMenu);
	ControlMenu.items:Add(UnloadMenu);
	ControlMenu:ShowMenu();
end

-- Set previously selected background color of control
function TitanBar.BaseControl:BGColor()
	if self.ShowMe then self.Ctr:SetBackColor( Turbine.UI.Color( self.BCAlpha, self.bcRed, self.bcGreen, self.bcBlue ) ); end
	SavePluginData();
	TitanBar.Window.MouseLeave();
end

-- Unload control from TitanBar
function TitanBar.BaseControl:UnloadControl()
	if self.ShowMe then 
		self:ShowHide();
		if self.IsWalletItem then
			self.Where = 3;
		else
			self.MenuOpt:SetChecked( false );
		end
	end
	TitanBar.Window.MouseLeave();
end
	
-- Remove ToolTip for control from screen
function TitanBar.BaseControl:ResetToolTipWin()
	if self.ToolTipWin ~= nil then
		self.ToolTipWin:SetVisible( false );
		self.ToolTipWin = nil;
	end
end

-- Apply borders to the various control windows
function TitanBar.BaseControl:ApplySkin() --Tooltip skin
	local topLeftCorner = Turbine.UI.Control();
	topLeftCorner:SetParent( self.ToolTipWin );
	topLeftCorner:SetPosition( 0, 0 );
	topLeftCorner:SetSize( 36, 36 );
	topLeftCorner:SetBackground( resources.Box.TopLeft );
	
	local TopBar = Turbine.UI.Control();
	TopBar:SetParent( self.ToolTipWin );
	TopBar:SetPosition( 36, 0 );
	TopBar:SetSize( self.ToolTipWin:GetWidth() - 36, 37 );
	TopBar:SetBackground( resources.Box.Top )
	
	local topRightCorner = Turbine.UI.Control();
	topRightCorner:SetParent( self.ToolTipWin );
	topRightCorner:SetPosition( self.ToolTipWin:GetWidth() - 36, 0 );
	topRightCorner:SetSize( 36, 36 );
	topRightCorner:SetBackground( resources.Box.TopRight );
	
	local midLeft = Turbine.UI.Control();
	midLeft:SetParent( self.ToolTipWin );
	midLeft:SetPosition( 0, 36 );
	midLeft:SetSize( 36, self.ToolTipWin:GetHeight() - 36 );
	midLeft:SetBackground( resources.Box.MidLeft );
	
	local MidMid = Turbine.UI.Control();
	MidMid:SetParent( self.ToolTipWin );
	MidMid:SetPosition( 36, 36 );
	MidMid:SetSize( self.ToolTipWin:GetWidth() - 36, self.ToolTipWin:GetHeight() - 36 );
	MidMid:SetBackground( resources.Box.Middle ); 
	
	local midRight = Turbine.UI.Control();
	midRight:SetParent( self.ToolTipWin );
	midRight:SetPosition( self.ToolTipWin:GetWidth() - 36, 36 );
	midRight:SetSize( 36, self.ToolTipWin:GetHeight() - 36 );
	midRight:SetBackground( resources.Box.MidRight );
	
	local botLeftCorner = Turbine.UI.Control();
	botLeftCorner:SetParent( self.ToolTipWin );
	botLeftCorner:SetPosition( 0, self.ToolTipWin:GetHeight() - 36 );
	botLeftCorner:SetSize( 36, 36 );
	botLeftCorner:SetBackground( resources.Box.BottomLeft ); 
	
	local BotBar = Turbine.UI.Control();
	BotBar:SetParent( self.ToolTipWin );
	BotBar:SetPosition( 36, self.ToolTipWin:GetHeight() - 36 );
	BotBar:SetSize( self.ToolTipWin:GetWidth() - 36, 36 );
	BotBar:SetBackground( resources.Box.Bottom );
	
	local botRightCorner = Turbine.UI.Control();
	botRightCorner:SetParent( self.ToolTipWin );
	botRightCorner:SetPosition( self.ToolTipWin:GetWidth() - 36, self.ToolTipWin:GetHeight() - 36 );
	botRightCorner:SetSize( 36, 36 );
	botRightCorner:SetBackground( resources.Box.BottomRight );
end

-- Empty function to show the control window. Real function is in class for the control itself.
function TitanBar.BaseControl:ShowWindow()
	--write("ShowWindow");
end

-- Shows window to change background color of control
function TitanBar.BaseControl:SetBackgroundColor()
	--sFrom = _G.sFromCtr;
	curColor = {};
	local bClick = false;
	
	-- Set some window stuff
	local wBackground = Turbine.UI.Lotro.Window();
	wBackground.Opacity = 1;
	wBackground:SetText( TitanBar.L.BWTitle );
	wBackground:SetSize( 400, 210 );
	wBackground:SetPosition( settings.Background.Left, settings.Background.Top );
	wBackground:SetVisible( true );
	wBackground:SetWantsKeyEvents( true );
	
	-- Check box - label
	local SetToAllCtr = Turbine.UI.Lotro.CheckBox();
	SetToAllCtr:SetParent( wBackground );
	SetToAllCtr:SetPosition( 40, wBackground:GetHeight() - 70 );
	SetToAllCtr:SetText( TitanBar.L.BWApply );
	SetToAllCtr:SetSize( SetToAllCtr:GetTextLength() * 8, 30 );
	SetToAllCtr:SetVisible( true );
	SetToAllCtr:SetChecked( settings.Background.ToAll );
	SetToAllCtr:SetForeColor( Color.rustedgold );

	SetToAllCtr.CheckedChanged = function( sender, args )
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		settings.Background.A = settings.Background.ToAll;
		SavePluginData();
	end

	-- Currently set color - label
	local CurSetColorLbl = Turbine.UI.Label();
	CurSetColorLbl:SetParent( wBackground );
	CurSetColorLbl:SetPosition( 305, 35 );
	CurSetColorLbl:SetSize( 80, 30 );
	CurSetColorLbl:SetText( TitanBar.L.BWCurSetColor );
	CurSetColorLbl:SetVisible( true );
	CurSetColorLbl:SetForeColor( Color.rustedgold );
	
	-- Currently Selected color - box
	curSelColorBorder = Turbine.UI.Label();
	curSelColorBorder:SetParent( wBackground );
	curSelColorBorder:SetSize( 73, 73 );
	curSelColorBorder:SetPosition( 305, 60 );
	curSelColorBorder:SetBackColor( Color.white );

	curSelColor = Turbine.UI.Label();
	curSelColor:SetParent( curSelColorBorder );
	curSelColor:SetSize( 71, 71 );
	curSelColor:SetPosition( 1, 1 );
	
	-- Set backcolor window setting to currently control color
	curSelAlpha = self.bcAlpha; 
	curSelRed = self.bcRed; 
	curSelGreen = self.bcGreen; 
	curSelBlue = self.bcBlue;

	--curAlpha, curColor.R, curColor.G, curColor.B = curSelAlpha, curSelRed, curSelGreen, curSelBlue;
	curSelColor:SetBackColor( Turbine.UI.Color( curSelAlpha, curSelRed, curSelGreen, curSelBlue ) );
	
	-- Save button
	local buttonSave = Turbine.UI.Lotro.Button();
	buttonSave:SetParent( wBackground );
	buttonSave:SetText( TitanBar.L.BWSave );
	buttonSave:SetSize( buttonSave:GetTextLength() * 10, 15 ); --Auto size with text lenght
	buttonSave:SetPosition( wBackground:GetWidth() - buttonSave:GetWidth() - 15 , wBackground:GetHeight() - 34 );
	buttonSave:SetVisible( true );

	buttonSave.Click = function( sender, args )
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		settings.Background.A = SetToAllCtr:IsChecked();
		
		self:UpdateBCvariable();
		
		ChangeColor(curSelColor:GetBackColor());
		SavePluginData();
	end
	
	-- Create alpha label and slider.
	local alphalabel = Turbine.UI.Label();
	alphalabel:SetParent( wBackground );
	alphalabel:SetText( TitanBar.L.BWAlpha .. " @ " .. ( curSelAlpha * 100 ) .. "%" );
	alphalabel:SetPosition( 40, 40 );
	alphalabel:SetSize( 242, 10 );
	alphalabel:SetBackColor( Color.black );
	alphalabel:SetTextAlignment( Turbine.UI.ContentAlignment.TopCenter );
	
	local alphaScrollBar = Turbine.UI.Lotro.ScrollBar();
	alphaScrollBar:SetParent( alphalabel );
	alphaScrollBar:SetPosition( 0, 0 );
	alphaScrollBar:SetSize( 242, 10 );
	alphaScrollBar:SetMinimum( 0 );
	alphaScrollBar:SetMaximum( 100 );
	alphaScrollBar:SetValue( curSelAlpha * 100);
	
	alphaScrollBar.ValueChanged = function(sender, args)
		curAlpha = alphaScrollBar:GetValue() / 100;
		alphalabel:SetText( TitanBar.L.BWAlpha .. " @ " .. ( curAlpha * 100 ) .. "%" );
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		if bClick then ChangeColor(Turbine.UI.Color( curAlpha, curSelRed, curSelGreen, curSelBlue ));
		else ChangeColor(Turbine.UI.Color( curAlpha, curColor.R, curColor.G, curColor.B )); end
		curSelColor:SetBackColor( Turbine.UI.Color( curAlpha, curSelRed, curSelGreen, curSelBlue ) )
	end
	
	-- Default button
	local buttonDefault = Turbine.UI.Lotro.Button();
	buttonDefault:SetParent( wBackground );
	buttonDefault:SetPosition( 23, wBackground:GetHeight() - 34 );
	buttonDefault:SetText( TitanBar.L.BWDef );
	buttonDefault:SetSize( buttonDefault:GetTextLength() * 10, 15 ); --Auto size with text lenght
	buttonDefault:SetVisible( true );

	buttonDefault.Click = function(sender, args)
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		alphaScrollBar:SetValue( 30 );
		curSelAlpha = ( 0.3 );
		curSelRed = ( 0.3 );
		curSelGreen = ( 0.3 );
		curSelBlue = ( 0.3 );
		curSelColor:SetBackColor( Turbine.UI.Color( curSelAlpha, curSelRed, curSelGreen, curSelBlue ) );
		ChangeColor(curSelColor:GetBackColor());
		bClick = true;
	end
	
	-- Black button
	local buttonBlack = Turbine.UI.Lotro.Button();
	buttonBlack:SetParent( wBackground );
	buttonBlack:SetPosition( buttonDefault:GetLeft() + buttonDefault:GetWidth() + 5, wBackground:GetHeight() - 34 );
	buttonBlack:SetText( TitanBar.L.BWBlack );
	buttonBlack:SetSize( buttonBlack:GetTextLength() * 10, 15 ); --Auto size with text lenght
	buttonBlack:SetVisible( true );

	buttonBlack.Click = function(sender, args)
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		alphaScrollBar:SetValue ( 100 );
		curSelAlpha = ( 1 );
		curSelRed = ( 0 );
		curSelGreen = ( 0 );
		curSelBlue = ( 0 );
		curSelColor:SetBackColor( Turbine.UI.Color( curSelAlpha, curSelRed, curSelGreen, curSelBlue ) );
		ChangeColor(curSelColor:GetBackColor());
		bClick = true;
	end
	
	-- Transparent button
	local buttonTrans = Turbine.UI.Lotro.Button();
	buttonTrans:SetParent( wBackground );
	buttonTrans:SetPosition( buttonBlack:GetLeft() + buttonBlack:GetWidth() + 5, wBackground:GetHeight() - 34 );
	buttonTrans:SetText( TitanBar.L.BWTrans );
	buttonTrans:SetSize( buttonTrans:GetTextLength() * 10, 15 ); --Auto size with text lenght
	buttonTrans:SetVisible( true );

	buttonTrans.Click = function(sender, args)
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		alphaScrollBar:SetValue ( 0 );
		curSelAlpha = ( 0 );
		curSelRed = ( 0 );
		curSelGreen = ( 0 );
		curSelBlue = ( 0 );
		curSelColor:SetBackColor( Turbine.UI.Color( curSelAlpha, curSelRed, curSelGreen, curSelBlue ) );
		ChangeColor(curSelColor:GetBackColor());
		bClick = true;
	end
	
	-- Create Colour Picker window/border.
	ColourPickerBorder = Turbine.UI.Label();
	ColourPickerBorder:SetParent( wBackground );
	ColourPickerBorder:SetPosition( 40, 60 );
	ColourPickerBorder:SetSize( 242, 73 );
	ColourPickerBorder:SetBackColor( Turbine.UI.Color( 1, .2, .2, .2  ) );
	ColourPickerBorder:SetVisible( true );
	
	-- Create Colour Picker.
	ColourPicker = Turbine.UI.Label();
	ColourPicker:SetParent( ColourPickerBorder );
	ColourPicker:SetPosition( 1, 1 );
	ColourPicker:SetSize( 240, 71 );
	ColourPicker:SetBackground( resources.Picker );

	ColourPicker.GetColorFromCoord = function( sender, X, Y )
		-- Controls the visibility of the cursor window
		local blockXvalue = (round(ColourPicker:GetWidth()/3));
		local blockYvalue = (round(ColourPicker:GetHeight()/2));

		curColor = Turbine.UI.Color();
		local myX = X;
		local myY = Y;
		local curRed = 0;
		local curGreen = 0;
		local curBlue = 0;

		if (myX >= 0) and (myX < blockXvalue) then

			-- First color block = red to green
			curRed = 100-((100/blockXvalue)*myX);
			curGreen = (100/blockXvalue)*myX;
			curBlue = 0;

		elseif (myX >= blockXvalue) and (myX < (2*blockXvalue)) then

			-- Second color block = green to blue
			curRed = 0;
			curGreen = 100-((100/blockXvalue)*(myX - blockXvalue));
			curBlue = (100/blockXvalue)*(myX - blockXvalue);

		elseif (myX >= (2*blockXvalue)) then

			-- Third color block = blue to red
			curRed = (100/blockXvalue)*(myX - 2*blockXvalue);
			curGreen = 0;
			curBlue = 100-((100/blockXvalue)*(myX - 2*blockXvalue));

		end

		if myY <= blockYvalue then

			-- In the top block, so fade from black to full color
			curRed = curRed * (myY/blockYvalue);
			curGreen = curGreen * (myY/blockYvalue);
			curBlue = curBlue * (myY/blockYvalue);

		else

			-- In the bottom block, so fade from full color to white
			curRed = curRed + ((myY - blockYvalue) * ((100 - curRed)/(blockYvalue)));
			curGreen = curGreen + ((myY - blockYvalue) * ((100 - curGreen)/(blockYvalue)));
			curBlue = curBlue + ((myY - blockYvalue) * ((100 - curBlue)/(blockYvalue)));

		end

		curColor.A = curAlpha;
		curColor.R = (1/100) * curRed;
		curColor.G = (1/100) * curGreen;
		curColor.B = (1/100) * curBlue;

		return curColor;
	end

	ColourPicker.MouseMove = function( sender, args )
		mColor = ColourPicker:GetColorFromCoord( args.X, args.Y );
		settings.Background.ToAll = SetToAllCtr:IsChecked();
		ChangeColor(mColor);
	end
	
	ColourPicker.MouseClick = function( sender, args )
		curSelRed = curColor.R;
		curSelGreen = curColor.G;
		curSelBlue = curColor.B;
		curSelColor:SetBackColor( mColor );
		bClick = true;
	end
	
	wBackground.KeyDown = function( sender, args )
		if ( args.Action == Turbine.UI.Lotro.Action.Escape ) then
			wBackground:Close();
		elseif ( args.Action == 268435635 ) or ( args.Action == 268435579 ) then -- Hide if F12 key is press or reposition UI
			wBackground:SetVisible( not wBackground:IsVisible() );
		end
	end

	wBackground.MouseUp = function( sender, args )
		settings.Background.L = string.format("%.0f", wBackground:GetLeft());
		settings.Background.T = string.format("%.0f", wBackground:GetTop());
		settings.Background.Left, settings.Background.Top = wBackground:GetPosition();
		SavePluginData();
	end

	wBackground.Closing = function( sender, args )
		wBackground:SetWantsKeyEvents( false );
		TitanBar.Window.MouseLeave();
		settings.Background.ToAll = SetToAllCtr:IsChecked();

		self:UpdateBCvariable();
		
		ChangeColor(curSelColor:GetBackColor());
		wBackground = nil;
		option_backcolor:SetEnabled( true );
	end
end

-- Helper function for BaseControl:SetBackgroundColor()
function TitanBar.BaseControl:UpdateBCvariable()
	self.bcAlpha = curAlpha;
	settings[self.NAME].A = curAlpha;
	self.bcRed = curSelRed;
	settings[self.NAME].R = curSelRed;
	self.bcGreen = curSelGreen;
	settings[self.NAME].G = curSelGreen;
	self.bcRed = curSelRed;
	settings[self.NAME].B = curSelBlue;	
end

-- Changes size of control
function TitanBar.BaseControl:ChangeWidth( newWidth )
	-- TODO
end