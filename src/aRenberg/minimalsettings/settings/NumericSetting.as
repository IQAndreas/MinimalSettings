package aRenberg.minimalsettings.settings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.settings.common.Setting;
	
	public class NumericSetting extends Setting
	{
		public static const NUMBER:String = "Number";
		public static const PERCENT:String = "Percent";
		public static const INT:String = "int";
		public static const UINT:String = "uint";
		
		private static function getDefaultValues(name:String):Object
		{
			switch (name)
			{
				case NUMBER: 	return {minValue:Number.MIN_VALUE, 	maxValue:Number.MAX_VALUE, 	step:1, 	roundedValues:false};
				case PERCENT: 	return {minValue:0, 				maxValue:Number.MAX_VALUE, 	step:0.05, 	roundedValues:false};
				case INT: 		return {minValue:int.MIN_VALUE, 	maxValue:int.MAX_VALUE, 	step:1, 	roundedValues:true};
				case UINT: 		return {minValue:uint.MIN_VALUE, 	maxValue:uint.MAX_VALUE, 	step:1, 	roundedValues:true};
				default: 		return { };
			}
		}
		
		//public static const METADATA_NAMES:Vector.<String> = new Vector.<String>[NUMBER, PERCENT, INT, UINT];
		public static const METADATA_NAMES:Array = [NUMBER, PERCENT, INT, UINT];
		
		
		public function NumericSetting(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			var defaults:Object = NumericSetting.getDefaultValues(metadata.name);
			_minValue = metadata.getArgNumeric('min', defaults.minValue);
			_maxValue = metadata.getArgNumeric('max', defaults.maxValue);
			_step = metadata.getArgNumeric('step', defaults.step);
			
			//_minValue = metadata.getArg('round', defaults.roundedValues);
			_roundedValues = Boolean(defaults.roundedValues);
		}
		
		private var _minValue:Number;
		public function get minValue():Number
		{ return _minValue; }
		
		private var _maxValue:Number;
		public function get maxValue():Number 
		{ return _maxValue; }
		
		private var _step:Number;
		public function get step():Number
		{ return _step; }
		
		//It doesn't actually round them, it "int"s them... Should I change this name to clarify that?
		private var _roundedValues:Boolean;
		public function get roundedValues():Boolean
		{ return _roundedValues; }
		
		
		public function getValue():Number
		{
			return Number(settings.getProperty(this.targetName));
		}
		
		public function setValue(value:Number):void
		{
			if (_roundedValues) { value = int(value); }
			
			if (value > _maxValue) { value = _maxValue; }
			if (value < _minValue) { value = _minValue; }
			
			settings.setProperty(this.targetName, value);
			this.onChange.call();
		}
	}
}