package aRenberg.minimalsettings.settings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.settings.common.EnumOption;
	import aRenberg.minimalsettings.settings.common.Meta;
	import aRenberg.minimalsettings.settings.common.Setting;
	import aRenberg.utils.nullFunction;
	
	import flash.utils.getQualifiedClassName;
	
	public class MainSettings // extends ReadonlySetting
	{
		public static const METADATA_NAME:String = 'Settings';

		public function MainSettings(target:*)
		{
			this.target = target;
			//this.metadata = metadata;
			
			//Strip out the package name from the label
			_label = "Settings - " + getQualifiedClassName(target).replace(/^([^:]*::)/, "");
			_onChangeName = null;
			
			actions = new Object();
			settings = new Vector.<Setting>();
			enums = new Object();
		}
		
		public function populate(metadata:IMetadata):void
		{
			//Fills in additional data if it is missing
			_label = metadata.getArg(Meta.LABEL, _label);
			_onChangeName = metadata.getArg(Meta.MAIN_ONCHANGE, _onChangeName);
		}
		
		private var target:*;
		//private var metadata:IMetadata;
		
		
		private var _label:String;
		public function get label():String
		{ return _label; }
		
		private var _onChangeName:String;
		public function get onChangeName():String
		{ return _onChangeName; }
		
		public function get onChange():Function
		{
			return (_onChangeName ? this.getFunction(_onChangeName, true) : nullFunction);
		}
		
		
		private var actions:Object;
		public function registerActions(actionsVector:Vector.<Action>):void
		{
			for each (var action:Action in actionsVector)
			{
				//TODO: Warn if duplicate actions?
				actions[action.name] = action.targetName;
			}
		}
		
		private var settings:Vector.<Setting>;
		public function registerSettings(settingsVector:Vector.<Setting>):void
		{
			//A quick "settingsVector.concat()" will do the exact same thing
			/*for each (var setting:Setting in settingsVector)
			{
				settings.push(setting);
			}*/
			settings = settingsVector;
		}
		
		private var enums:Object;
		public function registerOptions(optionsVector:Vector.<EnumOption>):void
		{
			//Group by "targetName"
			for each (var option:EnumOption in optionsVector)
			{
				var enum:EnumSetting = enums[option.targetName] || option.buildEnumSetting();
				enum.registerOption(option);
			}
		}
		
		
		public function getAction(name:String):String
		{
			return actions[name] || null;
		}
		
		public function getFunction(name:String, allowActions:Boolean = true):Function
		{
			if (allowActions)
			{
				var alias:String = this.getAction(name);
				if (alias) { name = alias; }
			}
			
			//Retrieve the actual function based on name
			var func:Function = this.getProperty(name) as Function;
			
			//May return null
			return func;
		}
		
		public function getSetting(targetName:String):Setting
		{
			for each (var setting:Setting in settings)
			{
				if (setting.targetName == targetName)
				{
					return setting;
				}
			}
			
			return null;
		}
		
		
		public function getProperty(name:String):*
		{
			//Can this throw an error even though target is loosely typed?
			return target[name];
		}
		
		public function setProperty(name:String, value:*):void
		{
			if (target.hasOwnProperty(name))
			{
				try
				{
					//May throw an error?
					target[name] = value;
				}
				catch (e:Error)
				{
					//TODO: Better error handling
					trace("Error setting property:", e);
				}
			}
		}
		
		
	}
}