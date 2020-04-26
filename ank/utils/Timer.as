class ank.utils.Timer extends Object
{
	static var _nTimerIndex = 0;
	static var _oIDs = new Object();
	static var _tTimer = new ank.utils.();
	function Timer()
	{
		super();
	}
	static function setTimer(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		ank.utils.Timer.garbageCollector();
		var loc9 = ank.utils.Timer.getNextTimerIndex();
		var loc10 = _global.setInterval(ank.utils.Timer.getInstance(),"onTimer",loc6,loc9,loc2,loc3,loc4,loc5,loc7);
		loc2.__ANKTIMERID__ = loc10;
		loc2.__ANKTIMERREPEAT__ = loc8;
		if(ank.utils.Timer._oIDs[loc3] == undefined)
		{
			ank.utils.Timer._oIDs[loc3] = new Object();
		}
		ank.utils.Timer._oIDs[loc3][loc9] = new Array(loc2,loc10,loc3);
	}
	static function clear(loc2)
	{
		if(loc2 != undefined)
		{
			var loc3 = ank.utils.Timer._oIDs[loc2];
			§§enumerate(loc3);
			while((var loc0 = §§enumeration()) != null)
			{
				ank.utils.Timer.removeTimer(loc3[k][0],loc2,loc3[k][1]);
			}
		}
		else
		{
			for(var loc4 in ank.utils.Timer._oIDs)
			{
				§§enumerate(loc4);
				while((var loc0 = §§enumeration()) != null)
				{
					ank.utils.Timer.removeTimer(loc4[kk][0],loc4[kk][2],loc4[kk][1]);
				}
			}
		}
		ank.utils.Timer.garbageCollector();
	}
	static function clean()
	{
		ank.utils.Timer.garbageCollector();
	}
	static function removeTimer(loc2, loc3, loc4)
	{
		if(loc4 == undefined)
		{
			if(loc2 == undefined)
			{
				return undefined;
			}
			if(loc2.__ANKTIMERID__ == undefined)
			{
				return undefined;
			}
			var loc5 = loc2.__ANKTIMERID__;
		}
		else
		{
			loc5 = ank.utils.Timer._oIDs[loc3][loc4][1];
		}
		_global.clearInterval(loc5);
		delete register2.__ANKTIMERID__;
		delete ank.utils.Timer._oIDs[loc3].register4;
	}
	static function getInstance()
	{
		return ank.utils.Timer._tTimer;
	}
	static function garbageCollector()
	{
		for(var k in ank.utils.Timer._oIDs)
		{
			var loc2 = ank.utils.Timer._oIDs[k];
			for(var kk in loc2)
			{
				var loc3 = loc2[kk];
				if(loc3[0] == undefined || (typeof loc3[0] == "movieclip" && loc3[0]._name == undefined || loc3[0].__ANKTIMERID__ != loc3[1]))
				{
					_global.clearInterval(loc3[1]);
					delete register2.kk;
				}
			}
		}
	}
	static function getTimersCount()
	{
		var loc2 = 0;
		for(var k in ank.utils.Timer._oIDs)
		{
			var loc3 = ank.utils.Timer._oIDs[k];
			for(var kk in loc3)
			{
				loc2 = loc2 + 1;
			}
		}
		return loc2;
	}
	static function getNextTimerIndex()
	{
		return ank.utils.Timer._nTimerIndex++;
	}
	function onTimer(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		if(loc3 == undefined)
		{
			ank.utils.Timer.removeTimer(undefined,loc4,loc2);
			return undefined;
		}
		if(loc3.__ANKTIMERID__ == undefined)
		{
			ank.utils.Timer.removeTimer(undefined,loc4,loc2);
			return undefined;
		}
		if(!loc3.__ANKTIMERREPEAT__)
		{
			ank.utils.Timer.removeTimer(loc3,loc4,loc2);
			delete register3.__ANKTIMERID__;
		}
		loc6.apply(loc5,loc7);
		ank.utils.Timer.garbageCollector();
	}
}
