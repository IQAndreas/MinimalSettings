package aRenberg.minimalsettings.settings.common
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.MinimalSettings;
	import aRenberg.minimalsettings.settings.MainSettings;
	
	public class Setting extends ReadonlySetting
	{
		public function Setting(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			_onChange = metadata.getArg(Meta.ONCHANGE, null);
		}
		
		
		protected var _onChange:String;
		public function get onChange():Function
		{
			return (_onChange ? settings.getFunction(_onChange) : null) || settings.onChange;
		}
	}
}