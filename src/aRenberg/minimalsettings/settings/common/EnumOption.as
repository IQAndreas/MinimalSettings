package aRenberg.minimalsettings.settings.common
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;
	import aRenberg.minimalsettings.settings.EnumSetting;
	import aRenberg.minimalsettings.settings.MainSettings;

	public class EnumOption extends ReadonlySetting
	{
		public function EnumOption(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			_value = metadata.getArg(Meta.ENUM_VALUE, undefined);
			if (_value == undefined) { /* THROW ERROR! */ }
		}
		
		//Type as String or untyped?
		protected var _value:*;
		public function get value():*
		{ return _value; }
		
		
		public function buildEnumSetting():EnumSetting
		{
			//This allows access to the "settings" and "metadata" properties
			// when constructing an EnumSetting without needing to publicly
			// expose those properties. 
			//Is this a bad idea or a smooth move?
			return new EnumSetting(this.settings, this.metadata);
		}
		
	}
}