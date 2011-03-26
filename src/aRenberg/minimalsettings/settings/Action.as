package aRenberg.minimalsettings.settings
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.minimalsettings.settings.common.Meta;
	import aRenberg.minimalsettings.settings.common.ReadonlySetting;
	
	public class Action extends ReadonlySetting
	{
		public static const ACTION:String = "Action";
		
		//public static const METADATA_NAMES:Vector.<String> = new Vector.<String>[ACTION];
		public static const METADATA_NAMES:Array = [ACTION];
		
		public function Action(settings:MainSettings, metadata:IMetadata)
		{
			super(settings, metadata);
			
			_name = metadata.getArg(Meta.ACTION_NAME, this.targetName);
			_visible = Boolean(metadata.getArg(Meta.ACTION_VISIBLE, true));
			
			//override
			_label = metadata.getArg(Meta.LABEL, _name);
		}
		
		private var _name:String;
		public function get name():String
		{ return _name; }
		
		private var _visible:Boolean;
		public function get visible():Boolean
		{ return _visible; }
		
		
		public function getTargetFunction():Function
		{
			return settings.getFunction(this.targetName, false);
		}
		
		public function call(... args):void
		{
			this.getTargetFunction().call(null, args);
			//settings.getFunction(_name).call();
		}
	}
}