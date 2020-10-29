class dofus.managers.StreamingDisplayManager extends dofus.utils.ApiElement
{
	static var DEFAULT_DISPLAY = 19;
	static var DOWNLOAD_DISPLAY = [21,22,23,24,25];
	static var TRIGGERING_MAPS = new Array();
	function StreamingDisplayManager()
	{
		super();
		this.initConfiguration();
	}
	static function getInstance()
	{
		if(dofus.managers.StreamingDisplayManager._self == null)
		{
			dofus.managers.StreamingDisplayManager._self = new dofus.managers.StreamingDisplayManager();
		}
		return dofus.managers.StreamingDisplayManager._self;
	}
	function displayAdvice(var2)
	{
		getURL("FSCommand:" add "display",var2);
		var var3 = this.getDisplaysSharedObject();
		if(var3.data["display" + var2] == undefined)
		{
			var3.data["display" + var2] = 1;
		}
		else
		{
			var3.data["display" + var2] = var3.data["display" + var2] + 1;
		}
		var3.flush();
	}
	function displayAdviceMax(var2, var3)
	{
		if(this.getDisplaysSharedObject().data["display" + var2] == undefined || this.getDisplaysSharedObject().data["display" + var2] < var3)
		{
			this.displayAdvice(var2);
		}
	}
	function getMapDisplay(var2)
	{
		if(dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[var2] != undefined)
		{
			if(this.getDisplaysSharedObject().data["display" + dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[var2]] == 1)
			{
				return this.getDefaultDisplay(this.getPlayTime());
			}
			return dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[var2];
		}
		return this.getDefaultDisplay(this.getPlayTime());
	}
	function getPlayTime()
	{
		return getTimer() / 1000;
	}
	function getDefaultDisplay(var2)
	{
		if(var2 < 1200)
		{
			return dofus.managers.StreamingDisplayManager.DEFAULT_DISPLAY;
		}
		return dofus.managers.StreamingDisplayManager.DOWNLOAD_DISPLAY[Math.floor((var2 - 1200) / 300) % dofus.managers.StreamingDisplayManager.DOWNLOAD_DISPLAY.length];
	}
	function initConfiguration()
	{
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10300] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10284] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10299] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10285] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10298] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10276] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10283] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10294] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10292] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10279] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10296] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10289] = 1;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10305] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10321] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10322] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10323] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10324] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10325] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10326] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10327] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10328] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10329] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10330] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10331] = 2;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10273] = 4;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10337] = 3;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10258] = 3;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10295] = 5;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10288] = 6;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10290] = 6;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10287] = 6;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10345] = 6;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10346] = 6;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10344] = 6;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10297] = 14;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10349] = 14;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10317] = 14;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10304] = 14;
		dofus.managers.StreamingDisplayManager.TRIGGERING_MAPS[10318] = 26;
	}
	function getDisplaysSharedObject()
	{
		if(this._soDisplays == undefined && this.api.datacenter.Player.Name)
		{
			this._soDisplays = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_DISPLAYS_NAME + this.api.datacenter.Player.Name);
		}
		return this._soDisplays;
	}
	function onNicknameChoice()
	{
		this.displayAdvice(16);
	}
	function onCharacterCreation()
	{
		this.displayAdvice(17);
	}
	function onCharacterChoice()
	{
		this.displayAdvice(18);
	}
	function onFightStart()
	{
		this.displayAdviceMax(7,2);
	}
	function onFightStartEnd()
	{
		this.displayAdviceMax(8,2);
	}
	function onFightEnd()
	{
		if(this.api.datacenter.Player.LP < this.api.datacenter.Player.LPmax)
		{
			this.displayAdviceMax(12,2);
		}
		else
		{
			this.displayAdvice(this.getMapDisplay(this._nCurrentMap));
		}
	}
	function onNewInterface(var2)
	{
		_global.clearInterval(this._nNewInterfaceTimer);
		this._nNewInterfaceTimer = _global.setInterval(this,"newInterface",200,var2);
	}
	function newInterface(var2)
	{
		_global.clearInterval(this._nNewInterfaceTimer);
		switch(var2)
		{
			case "Inventory":
				this.displayAdviceMax(9,2);
				break;
			case "Spells":
				this.displayAdviceMax(10,2);
				break;
			case "StatsJob":
				this.displayAdviceMax(11,2);
		}
	}
	function onInterfaceClose(instanceName)
	{
		_global.clearInterval(this._nNewInterfaceTimer);
		switch(instanceName)
		{
			case "Inventory":
			case "Spells":
			case "StatsJob":
				this.displayAdvice(this.getMapDisplay(this._nCurrentMap));
		}
	}
	function onLevelGain()
	{
		this.displayAdviceMax(13,2);
	}
	function onNewMap(var2)
	{
		this._nCurrentMap = var2;
		this.displayAdvice(this.getMapDisplay(var2));
	}
}
