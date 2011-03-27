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
			
			//I know this will totally mess up if the target is writable but not readable.
			//I hate this part. I'll just be stubborn and ignore those possible errors.
			_readonly = !metadata.targetWriteable;
			
			_onChange = metadata.getArg(Meta.ONCHANGE, null);
		}
		
		
		/*protected var storedValue:*;
		protected function updateStoredValue():void
		{
			//Override me plz
		}*/
		
		
		protected var _onChange:String;
		public function get onChange():Function
		{
			return (_onChange ? settings.getFunction(_onChange) : null) || settings.onChange;
		}
	}
}