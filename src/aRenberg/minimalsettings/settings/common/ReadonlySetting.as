package aRenberg.minimalsettings.settings.common
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;
	import aRenberg.minimalsettings.settings.MainSettings;

	public class ReadonlySetting
	{
		public function ReadonlySetting(settings:MainSettings, metadata:IMetadata)
		{
			this.settings = settings;
			this.metadata = metadata;
			
			_targetName = metadata.targetName;
			
			_label = metadata.getArg(Meta.LABEL, this.targetName);
		}
		
		protected var settings:MainSettings;
		protected var metadata:IMetadata;
		
		
		private var _targetName:String;
		public function get targetName():String
		{ return _targetName; }
		
		
		protected var _label:String;
		public function get label():String
		{ return _label; }
		
		
	}
}