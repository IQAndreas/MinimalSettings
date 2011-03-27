package aRenberg.minimalsettings.settings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.settings.common.Setting;
	
	public class BooleanSetting extends Setting
	{
		public static const BOOLEAN:String = "Boolean";
		
		//public static const METADATA_NAMES:Vector.<String> = new Vector.<String>[BOOLEAN];
		public static const METADATA_NAMES:Array = [BOOLEAN];
		
		public function BooleanSetting(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
		}
		
		public function getValue():Boolean
		{
			return Boolean(settings.getProperty(this.targetName));
		}
		
		public function setValue(value:Boolean):Boolean
		{
			if (!this.readonly)
			{
				settings.setProperty(this.targetName, value);
				this.onChange.call(); //Even call "onChange" if the new value is not different?
				return value;
			}
			
			//else
			return this.getValue();
		}
	}
}