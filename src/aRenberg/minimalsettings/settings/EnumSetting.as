package aRenberg.minimalsettings.settings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.settings.common.EnumOption;
	import aRenberg.minimalsettings.settings.common.Setting;
	
	/**
	 * The class will not work properly if the EnumOption instance changes it's
	 * "value" property after instantiation. Why? Because! It shouldn't change anyway!
	 */ 
	public class EnumSetting extends Setting
	{
		public static const OPTION:String = "Option";
		
		public static const METADATA_NAMES:Array = [OPTION];

		public function EnumSetting(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			options = new Vector.<EnumOption>();
			allowedValues = new Vector.<Object>();
		}
		
		//As of right now, there is no way to add an option other than by Metadata
		protected var options:Vector.<EnumOption>;
		protected var allowedValues:Vector.<Object>;
		public function registerOption(option:EnumOption):void
		{
			if (option)
			{
				options.push(option);
				allowedValues.push(option.value);
			}
		}
		
		
		public function getValue():*
		{
			//Check if the current value is one of the allowed options?
			return settings.getProperty(this.targetName);
		}
		
		public function setValue(value:*):*
		{
			if (!this.readonly && (allowedValues.indexOf(value) > -1))
			{
				settings.setProperty(this.targetName, value);
				this.onChange.call();
				
				return value;
			}
			
			//else
			return this.getValue();
		}
		
	}
}