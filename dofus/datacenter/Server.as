class dofus.datacenter.Server
{
	static var SERVER_OFFLINE = 0;
	static var SERVER_ONLINE = 1;
	static var SERVER_STARTING = 2;
	static var SERVER_CLASSIC = 0;
	static var SERVER_HARDCORE = 1;
	static var SERVER_129 = 3;
	static var SERVER_RETRO = 4;
	static var SERVER_COMMUNITY_INTERNATIONAL = 2;
	function Server(var3, var4, var5, var6)
	{
		this.initialize(var2,var3,var4,var5);
		this._nCharactersCount = 0;
	}
	function __set__id(var2)
	{
		this._nID = var2;
		return this.__get__id();
	}
	function __get__id()
	{
		return this._nID;
	}
	function __set__charactersCount(nCount)
	{
		this._nCharactersCount = nCount;
		return this.__get__charactersCount();
	}
	function __get__charactersCount()
	{
		return this._nCharactersCount;
	}
	function __set__state(var2)
	{
		this._nState = var2;
		return this.__get__state();
	}
	function __get__state()
	{
		return this._nState;
	}
	function __get__stateStr()
	{
		switch(this._nState)
		{
			case dofus.datacenter.Server.SERVER_OFFLINE:
				return this.api.lang.getText("SERVER_OFFLINE");
			case dofus.datacenter.Server.SERVER_ONLINE:
				return this.api.lang.getText("SERVER_ONLINE");
			default:
				if(var0 !== dofus.datacenter.Server.SERVER_STARTING)
				{
					return "";
				}
				return this.api.lang.getText("SERVER_STARTING");
		}
	}
	function __get__stateStrShort()
	{
		if((var var0 = this._nState) !== dofus.datacenter.Server.SERVER_OFFLINE)
		{
			if(var0 !== dofus.datacenter.Server.SERVER_ONLINE)
			{
				if(var0 !== dofus.datacenter.Server.SERVER_STARTING)
				{
					return "";
				}
				return this.api.lang.getText("SERVER_STARTING_SHORT");
			}
			return this.api.lang.getText("SERVER_ONLINE_SHORT");
		}
		return this.api.lang.getText("SERVER_OFFLINE_SHORT");
	}
	function __set__canLog(var2)
	{
		this._bCanLog = var2;
		return this.__get__canLog();
	}
	function __get__canLog()
	{
		return this._bCanLog;
	}
	function __get__label()
	{
		return this.api.lang.getServerInfos(this._nID).n;
	}
	function __get__description()
	{
		return this.api.lang.getServerInfos(this._nID).d;
	}
	function __get__language()
	{
		return this.api.lang.getServerInfos(this._nID).l;
	}
	function __get__population()
	{
		return Number(this.api.lang.getServerInfos(this._nID).p);
	}
	function __get__populationStr()
	{
		return this.api.lang.getServerPopulation(this.population);
	}
	function __get__community()
	{
		return Number(this.api.lang.getServerInfos(this._nID).c);
	}
	function __get__communityStr()
	{
		return this.api.lang.getServerCommunity(this.community);
	}
	function __get__date()
	{
		var var2 = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
		return var2;
	}
	function __get__dateStr()
	{
		var var2 = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
		return org.utils.SimpleDateFormatter.formatDate(var2,this.api.lang.getConfigText("LONG_DATE_FORMAT"),this.api.config.language);
	}
	function __get__type()
	{
		return this.api.lang.getText("SERVER_GAME_TYPE_" + this.api.lang.getServerInfos(this._nID).t);
	}
	function __get__typeNum()
	{
		return this.api.lang.getServerInfos(this._nID).t;
	}
	function getRulesType()
	{
		var var2 = this.typeNum;
		switch(var2)
		{
			case dofus.datacenter.Server.SERVER_129:
			case dofus.datacenter.Server.SERVER_RETRO:
				return dofus.datacenter.Server.SERVER_CLASSIC;
			default:
				return var2;
		}
	}
	function isHardcore()
	{
		return this.typeNum == dofus.datacenter.Server.SERVER_HARDCORE;
	}
	function initialize(var2, var3, var4, var5)
	{
		this.api = _global.API;
		this._nID = var2;
		this._nState = var3;
		this._bCanLog = var5;
		this.completion = var4;
		this.populationWeight = Number(this.api.lang.getServerPopulationWeight(this.population));
	}
	function isAllowed()
	{
		if(this.api.datacenter.Player.isAuthorized)
		{
			return true;
		}
		var var2 = this.api.lang.getServerInfos(this._nID).rlng;
		if(var2 == undefined || (var2.length == undefined || (var2.length == 0 || this.api.config.skipLanguageVerification)))
		{
			return true;
		}
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3].toUpperCase() == this.api.config.language.toUpperCase())
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
}
