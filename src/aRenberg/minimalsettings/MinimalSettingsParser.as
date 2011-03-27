package aRenberg.minimalsettings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;
	import aRenberg.metadata.MetadataParser;
	import aRenberg.metadata.MetadataType;
	import aRenberg.metadata.MetadataUtils;
	import aRenberg.minimalsettings.settings.Action;
	import aRenberg.minimalsettings.settings.BooleanSetting;
	import aRenberg.minimalsettings.settings.EnumSetting;
	import aRenberg.minimalsettings.settings.MainSettings;
	import aRenberg.minimalsettings.settings.NumericSetting;
	import aRenberg.minimalsettings.settings.StringSetting;
	import aRenberg.minimalsettings.settings.common.EnumOption;
	import aRenberg.minimalsettings.settings.common.Setting;

	internal class MinimalSettingsParser
	{
		public function MinimalSettingsParser(minimalSettings:MinimalSettings, target:*)
		{
			this.minimalSettings = minimalSettings;
			
			actions = new Vector.<Action>();
			settings = new Vector.<Setting>();
			options = new Vector.<EnumOption>();
			
			
			_mainSettings = new MainSettings(target);
			this.extractMainSettings(target);
			this.extractOtherSettings(target);
			
			
			_mainSettings.registerActions(actions);
			_mainSettings.registerSettings(settings);
			_mainSettings.registerOptions(options);
			
		}
		
		private var minimalSettings:MinimalSettings;
		
		private var _allMetadata:Vector.<IMetadata>;
		public function get allMetadata():Vector.<IMetadata>
		{ return _allMetadata; }
		
		private var _mainSettings:MainSettings;
		public function get mainSettings():MainSettings
		{ return _mainSettings; }
		
		
		
		
		private var actions:Vector.<Action>;
		private var settings:Vector.<Setting>;
		private var options:Vector.<EnumOption>;
		
		
		private function extractMainSettings(target:*):void
		{
			//Only fills in extra data if it exists
			var parser:MetadataParser = new MetadataParser(true);
			parser.registerHandler(MainSettings.METADATA_NAME, onMainSettings);
			parser.parseObject(target);
		}
		
		private function onMainSettings(metadataXML:XML):IMetadata
		{
			var metadata:IMetadata = MetadataUtils.parse(metadataXML);
			
			if (metadata.targetType == MetadataType.CLASS)
			{
				//Possible error: Duplicate "Settings" tags found - ignore problem!
				_mainSettings.populate(metadata);
				return metadata;
			}
			
			//else
			return null;
		}
		
		
		private function extractOtherSettings(target:*):void
		{
			var parser:MetadataParser = new MetadataParser(true);
			
			this.registerMultipleHandlers(parser, Action.METADATA_NAMES, 			onAction);
			this.registerMultipleHandlers(parser, BooleanSetting.METADATA_NAMES, 	onBooleanSetting);
			this.registerMultipleHandlers(parser, NumericSetting.METADATA_NAMES, 	onNumericSetting);
			this.registerMultipleHandlers(parser, StringSetting.METADATA_NAMES, 	onStringSetting);
			
			parser.registerHandler(EnumSetting.OPTION, onEnumOption);
						
			_allMetadata = parser.parseObject(target);
		}
		
		private function registerMultipleHandlers(parser:MetadataParser, names:Array, handler:Function):void
		{
			for each (var name:String in names)
			{
				parser.registerHandler(name, handler);
			}
		}
		
		
		// The following handlers could be more dynamic...
		
		private function onAction(metadataXML:XML):IMetadata
		{
			var metadata:IMetadata = MetadataUtils.parse(metadataXML);
			
			if (metadata.targetType == MetadataType.METHOD)
			{
				actions.push(new Action(_mainSettings, metadata));
				return metadata;
			}
			
			//else
			return null;
		}
		
		private function onBooleanSetting(metadataXML:XML):IMetadata
		{
			var metadata:IMetadata = MetadataUtils.parse(metadataXML);
			
			if ((metadata.targetType == MetadataType.VARIABLE) || (metadata.targetType == MetadataType.ACCESSOR))
			{
				settings.push(new BooleanSetting(_mainSettings, metadata));
				return metadata;
			}
			
			//else
			return null;
		}
		
		private function onNumericSetting(metadataXML:XML):IMetadata
		{
			var metadata:IMetadata = MetadataUtils.parse(metadataXML);
			
			if ((metadata.targetType == MetadataType.VARIABLE) || (metadata.targetType == MetadataType.ACCESSOR))
			{
				settings.push(new NumericSetting(_mainSettings, metadata));
				return metadata;
			}
			
			//else
			return null;
		}
		
		private function onStringSetting(metadataXML:XML):IMetadata
		{
			var metadata:IMetadata = MetadataUtils.parse(metadataXML);
			
			if ((metadata.targetType == MetadataType.VARIABLE) || (metadata.targetType == MetadataType.ACCESSOR))
			{
				settings.push(new StringSetting(_mainSettings, metadata));
				return metadata;
			}
			
			//else
			return null;
		}
		
		private function onEnumOption(metadataXML:XML):IMetadata
		{
			var metadata:IMetadata = MetadataUtils.parse(metadataXML);
			
			if ((metadata.targetType == MetadataType.VARIABLE) || (metadata.targetType == MetadataType.ACCESSOR))
			{
				options.push(new EnumOption(_mainSettings, metadata));
				return metadata;
			}
			
			//else
			return null;
		}
		
		
		
		
	}
}