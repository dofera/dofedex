class ank.utils.CyclicTimer extends Object
{
	static var _aFunctions = new Array();
	static var _nInterval = 40;
	static var _bPlaying = false;
	static var _api = _global.API;
	static var _oCyclicTimer = new ank.utils.();
	function CyclicTimer()
	{
		super();
	}
	static function __get__interval()
	{
		return ank.utils.CyclicTimer._nInterval;
	}
	static function addFunction(var2, var3, var4, var5, var6, var7, var8)
	{
		var var9 = new Object();
		var9.objRef = var2;
		var9.objFn = var3;
		var9.fn = var4;
		var9.params = var5;
		var9.objFnEnd = var6;
		var9.fnEnd = var7;
		var9.paramsEnd = var8;
		ank.utils.CyclicTimer._aFunctions.push(var9);
		ank.utils.CyclicTimer.play();
	}
	static function removeFunction(var2)
	{
		var var3 = ank.utils.CyclicTimer._aFunctions.length - 1;
		while(var3 >= 0)
		{
			var var4 = ank.utils.CyclicTimer._aFunctions[var3];
			if(var2 == var4.objRef)
			{
				ank.utils.CyclicTimer._aFunctions.splice(var3,1);
			}
			var3 = var3 - 1;
		}
	}
	static function clear()
	{
		ank.utils.CyclicTimer.stop();
		ank.utils.CyclicTimer._aFunctions = new Array();
	}
	static function play()
	{
		if(ank.utils.CyclicTimer._bPlaying)
		{
			return undefined;
		}
		ank.utils.CyclicTimer._bPlaying = true;
		ank.utils.CyclicTimer.doCycle();
	}
	static function stop()
	{
		ank.utils.CyclicTimer._bPlaying = false;
	}
	static function getInstance()
	{
		return ank.utils.CyclicTimer._oCyclicTimer;
	}
	static function doCycle()
	{
		var var2 = ank.utils.CyclicTimer._aFunctions.length - 1;
		while(var2 >= 0)
		{
			var var3 = ank.utils.CyclicTimer._aFunctions[var2];
			if(!var3.fn.apply(var3.objFn,var3.params))
			{
				ank.utils.CyclicTimer.onFunctionEnd(var2,var3);
			}
			var2 = var2 - 1;
		}
		if(ank.utils.CyclicTimer._aFunctions.length != 0)
		{
			if(dofus.Constants.DOUBLEFRAMERATE)
			{
				if(ank.utils.CyclicTimer._api.electron.enabled)
				{
					var var4 = 2;
				}
				else
				{
					var4 = ank.utils.CyclicTimer._nInterval / 2;
				}
			}
			else
			{
				var4 = ank.utils.CyclicTimer._nInterval;
			}
			ank.utils.Timer.setTimer(ank.utils.CyclicTimer._oCyclicTimer,"cyclicTimer",ank.utils.CyclicTimer,ank.utils.CyclicTimer.doCycle,var4);
		}
		else
		{
			ank.utils.CyclicTimer.stop();
		}
	}
	static function onFunctionEnd(var2, var3)
	{
		var3.fnEnd.apply(var3.objFnEnd,var3.paramsEnd);
		ank.utils.CyclicTimer._aFunctions.splice(var2,1);
	}
}
