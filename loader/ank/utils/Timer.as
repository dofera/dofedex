class ank.utils.Timer extends Object
{
	static var _nTimerIndex = 0;
	static var _oIDs = new Object();
	static var _tTimer = new ank.utils.();
	function Timer()
	{
		super();
	}
	static function setTimer(§\n\x01§, §\x1e\x11\x04§, §\n\x13§, §\x0e\x1a§, §\x04\x14§, §\x1e\x02§, §\x16\n§)
	{
		ank.utils.Timer.garbageCollector();
		var var9 = ank.utils.Timer.getNextTimerIndex();
		var var10 = _global.setInterval(ank.utils.Timer.getInstance(),"onTimer",var6,var9,var2,var3,var4,var5,var7);
		var2.__ANKTIMERID__ = var10;
		var2.__ANKTIMERREPEAT__ = var8;
		if(ank.utils.Timer._oIDs[var3] == undefined)
		{
			ank.utils.Timer._oIDs[var3] = new Object();
		}
		ank.utils.Timer._oIDs[var3][var9] = new Array(var2,var10,var3);
	}
	static function clear(§\x1e\x11\x04§)
	{
		if(var2 != undefined)
		{
			var var3 = ank.utils.Timer._oIDs[var2];
			for(var k in var3)
			{
				ank.utils.Timer.removeTimer(var3[k][0],var2,var3[k][1]);
			}
		}
		else
		{
			for(var k in ank.utils.Timer._oIDs)
			{
				var var4 = ank.utils.Timer._oIDs[k];
				for(var kk in var4)
				{
					ank.utils.Timer.removeTimer(var4[kk][0],var4[kk][2],var4[kk][1]);
				}
			}
		}
		ank.utils.Timer.garbageCollector();
	}
	static function clean()
	{
		ank.utils.Timer.garbageCollector();
	}
	static function removeTimer(§\n\x01§, §\x1e\x11\x04§, §\x1e\x1c\t§)
	{
		if(var4 == undefined)
		{
			if(var2 == undefined)
			{
				return undefined;
			}
			if(var2.__ANKTIMERID__ == undefined)
			{
				return undefined;
			}
			var var5 = var2.__ANKTIMERID__;
		}
		else
		{
			var5 = ank.utils.Timer._oIDs[var3][var4][1];
		}
		_global.clearInterval(var5);
		delete register2.__ANKTIMERID__;
		delete ank.utils.Timer._oIDs[var3].register4;
	}
	static function getInstance()
	{
		return ank.utils.Timer._tTimer;
	}
	static function garbageCollector()
	{
		for(var k in ank.utils.Timer._oIDs)
		{
			var var2 = ank.utils.Timer._oIDs[k];
			for(var kk in var2)
			{
				var var3 = var2[kk];
				if(var3[0] == undefined || (typeof var3[0] == "movieclip" && var3[0]._name == undefined || var3[0].__ANKTIMERID__ != var3[1]))
				{
					_global.clearInterval(var3[1]);
					delete register2.kk;
				}
			}
		}
	}
	static function getTimersCount()
	{
		var var2 = 0;
		for(var k in ank.utils.Timer._oIDs)
		{
			var var3 = ank.utils.Timer._oIDs[k];
			for(var kk in var3)
			{
				var2 = var2 + 1;
			}
		}
		return var2;
	}
	static function getNextTimerIndex()
	{
		return ank.utils.Timer._nTimerIndex++;
	}
	function onTimer(§\x1e\x1c\t§, §\n\x01§, §\x1e\x11\x04§, §\n\x13§, §\x0e\x1a§, §\x1e\x02§)
	{
		if(var3 == undefined)
		{
			ank.utils.Timer.removeTimer(undefined,var4,var2);
			return undefined;
		}
		if(var3.__ANKTIMERID__ == undefined)
		{
			ank.utils.Timer.removeTimer(undefined,var4,var2);
			return undefined;
		}
		if(!var3.__ANKTIMERREPEAT__)
		{
			ank.utils.Timer.removeTimer(var3,var4,var2);
			delete register3.__ANKTIMERID__;
		}
		var6.apply(var5,var7);
		ank.utils.Timer.garbageCollector();
	}
}
