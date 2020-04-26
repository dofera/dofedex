class ank.utils.CyclicTimer extends Object
{
	static var _aFunctions = new Array();
	static var _nInterval = 40;
	static var _bPlaying = false;
	static var _api = _global.API;
	static var _oCyclicTimer = new ank.utils.();
	function CyclicTimer()
	{
		super();
	}
	static function __get__interval()
	{
		return ank.utils.CyclicTimer._nInterval;
	}
	static function addFunction(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		var loc9 = new Object();
		loc9.objRef = loc2;
		loc9.objFn = loc3;
		loc9.fn = loc4;
		loc9.params = loc5;
		loc9.objFnEnd = loc6;
		loc9.fnEnd = loc7;
		loc9.paramsEnd = loc8;
		ank.utils.CyclicTimer._aFunctions.push(loc9);
		ank.utils.CyclicTimer.play();
	}
	static function removeFunction(loc2)
	{
		var loc3 = ank.utils.CyclicTimer._aFunctions.length - 1;
		while(loc3 >= 0)
		{
			var loc4 = ank.utils.CyclicTimer._aFunctions[loc3];
			if(loc2 == loc4.objRef)
			{
				ank.utils.CyclicTimer._aFunctions.splice(loc3,1);
			}
			loc3 = loc3 - 1;
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
		var loc2 = ank.utils.CyclicTimer._aFunctions.length - 1;
		while(loc2 >= 0)
		{
			var loc3 = ank.utils.CyclicTimer._aFunctions[loc2];
			if(!loc3.fn.apply(loc3.objFn,loc3.params))
			{
				ank.utils.CyclicTimer.onFunctionEnd(loc2,loc3);
			}
			loc2 = loc2 - 1;
		}
		if(ank.utils.CyclicTimer._aFunctions.length != 0)
		{
			if(dofus.Constants.DOUBLEFRAMERATE)
			{
				if(ank.utils.CyclicTimer._api.electron.enabled)
				{
					var loc4 = 2;
				}
				else
				{
					loc4 = ank.utils.CyclicTimer._nInterval / 2;
				}
			}
			else
			{
				loc4 = ank.utils.CyclicTimer._nInterval;
			}
			ank.utils.Timer.setTimer(ank.utils.CyclicTimer._oCyclicTimer,"cyclicTimer",ank.utils.CyclicTimer,ank.utils.CyclicTimer.doCycle,loc4);
		}
		else
		{
			ank.utils.CyclicTimer.stop();
		}
	}
	static function onFunctionEnd(loc2, loc3)
	{
		loc3.fnEnd.apply(loc3.objFnEnd,loc3.paramsEnd);
		ank.utils.CyclicTimer._aFunctions.splice(loc2,1);
	}
}
