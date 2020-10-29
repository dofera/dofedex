class ank.utils.Logger
{
	static var LC = new LocalConnection();
	static var MAX_LOG_COUNT = 50;
	static var MAX_LOG_SIZE = 300;
	static var _instance = new ank.utils.();
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
	static function log(var2, var3)
	{
		ank.utils.Logger.LC.send("loggerOut","log",var2);
		if(var2.length < ank.utils.Logger.MAX_LOG_SIZE)
		{
			ank.utils.Logger._instance._logs.push(var3 != undefined?var3 + " :\n" + var2:var2);
		}
		if(ank.utils.Logger._instance._logs.length > ank.utils.Logger.MAX_LOG_COUNT)
		{
			ank.utils.Logger._instance._logs.shift();
		}
	}
	static function err(var2)
	{
		var2 = "ERROR : " + var2;
		ank.utils.Logger.LC.send("loggerOut","err",var2);
		ank.utils.Logger._instance._errors.push(var2);
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
