class ank.utils.Logger
{
	static var LC = new LocalConnection();
	static var MAX_LOG_COUNT = 50;
	static var MAX_LOG_SIZE = 300;
	static var _instance = new ank.utils.();
	function Logger()
	{
		this._logs = new Array();
		this._errors = new Array();
		ank.utils.Logger.LC.connect("loggerIn");
		ank.utils.Logger.LC.getLogs = function()
		{
			ank.utils.Logger.LC.send("loggerOut","log",ank.utils.Logger.logs);
		};
		ank.utils.Logger.LC.getErrors = function()
		{
			ank.utils.Logger.LC.send("loggerOut","err",ank.utils.Logger.errors);
		};
	}
	static function log(loc2, loc3)
	{
		ank.utils.Logger.LC.send("loggerOut","log",loc2);
		if(loc2.length < ank.utils.Logger.MAX_LOG_SIZE)
		{
			ank.utils.Logger._instance._logs.push(loc3 != undefined?loc3 + " :\n" + loc2:loc2);
		}
		if(ank.utils.Logger._instance._logs.length > ank.utils.Logger.MAX_LOG_COUNT)
		{
			ank.utils.Logger._instance._logs.shift();
		}
	}
	static function err(loc2)
	{
		loc2 = "ERROR : " + loc2;
		ank.utils.Logger.LC.send("loggerOut","err",loc2);
		ank.utils.Logger._instance._errors.push(loc2);
	}
	static function __get__logs()
	{
		return ank.utils.Logger._instance._logs.join("\n");
	}
	static function __get__errors()
	{
		return ank.utils.Logger._instance._errors.join("\n");
	}
}
