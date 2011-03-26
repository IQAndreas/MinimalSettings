package aRenberg.minimalsettings.settings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.settings.common.Setting;
	
	public class StringSetting extends Setting
	{
		public static const STRING:String = "String";
		public static const TEXT:String = "Text";
		public static const WORD:String = "Word";
		
		private static function getDefaultValues(name:String):Object
		{
			switch (name)
			{
				//TODO
				case STRING: 	return { maxLength:int.MAX_VALUE };
				case TEXT: 		return { maxLength:int.MAX_VALUE };
				case WORD: 		return { maxLength:int.MAX_VALUE };
				default: 		return { };
			}
		}
		
		//public static const METADATA_NAMES:Vector.<String> = new Vector.<String>[NUMBER, PERCENT, INT, UINT];
		public static const METADATA_NAMES:Array = [STRING, TEXT, WORD];
		
		
		public function StringSetting(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			var defaults:Object = StringSetting.getDefaultValues(metadata.name);
			_maxLength = metadata.getArgNumeric('max', defaults.maxLength);
		}
		
		private var _maxLength:int;
		//private var _multiline:Boolean;
		
		public function getValue():String
		{
			return String(settings.getProperty(this.targetName));
		}
		
		public function setValue(value:String):void
		{
			if (value.length > _maxLength) { value = value.substr(0, _maxLength); }
			
			settings.setProperty(this.targetName, value);
			this.onChange.call();
		}
	}
}