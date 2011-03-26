package aRenberg.minimalsettings
{
	import aRenberg.metadata.MetadataParser;
	import aRenberg.minimalsettings.settings.MainSettings;
	import aRenberg.utils.nullFunction;
	
	public class MinimalSettings
	{
		public function MinimalSettings(target:*)
		{
			if (!target)
			{
				//TODO: Error message - target requried
				throw new Error();
			}
			if (target is Class)
			{
				//TODO: Error message
				throw new Error();
			}
			
			_target = target;
			_parser = new MinimalSettingsParser(this, target);
			_mainSettings = _parser.mainSettings;
		}
		
		private var _target:*;
		public function get target():*
		{ return _target; }
		
		private var _parser:MinimalSettingsParser;
		//private function get parser():MinimalSettingsParser
		//{ return _parser; }
		
		private var _mainSettings:MainSettings;
		public function get mainSettings():MainSettings
		{ return _mainSettings; }
		
		
		
		
		
		
		/*public function getFunction(name:String, allowActions:Boolean = true):Function
		{
			return _parser.mainSettings.getFunction(name, true);
			_parser.mainSettings.
		}*/
	}
}