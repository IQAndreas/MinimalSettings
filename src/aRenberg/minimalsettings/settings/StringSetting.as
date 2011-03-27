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
				case STRING: 	return { maxChars:int.MAX_VALUE, multiline:false };
				case TEXT: 		return { maxChars:int.MAX_VALUE, multiline:true };
				case WORD: 		return { maxChars:int.MAX_VALUE, multiline:false };
				default: 		return { };
			}
		}
		
		//public static const METADATA_NAMES:Vector.<String> = new Vector.<String>[NUMBER, PERCENT, INT, UINT];
		public static const METADATA_NAMES:Array = [STRING, TEXT, WORD];
		
		
		public function StringSetting(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			var defaults:Object = StringSetting.getDefaultValues(metadata.name);
			_maxChars = metadata.getArgNumeric('max', defaults.maxChars);
			_multiline = Boolean(metadata.getArg('multiline', defaults.multiline));
		}
		
		private var _maxChars:int;
		private var _multiline:Boolean;
		
		public function getValue():String
		{
			return String(settings.getProperty(this.targetName));
		}
		
		public function setValue(value:String):String
		{
			if (!this.readonly)
			{
				if (value.length > _maxChars) { value = value.substr(0, _maxChars); }
				if (!_multiline) 			  { value = value.replace(/[\r\n]+/, ""); }
				
				settings.setProperty(this.targetName, value);
				this.onChange.call();
				
				return value;
			}
			
			//else
			return this.getValue();
		}
	}
}