import "Turbine.UI";

ReloadTitanBar = Turbine.UI.Control();
ReloadTitanBar:SetWantsUpdates( true );

ReloadTitanBar.Update = function( sender, args )
	ReloadTitanBar:SetWantsUpdates( false );
	Turbine.PluginManager.UnloadScriptState( 'TitanBar2' );
	Turbine.PluginManager.LoadPlugin( 'TitanBar2' );
end