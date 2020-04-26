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
	function Server(loc3, loc4, loc5, loc6)
	{
		this.initialize(loc2,loc3,loc4,loc5);
		this._nCharactersCount = 0;
	}
	function __set__id(loc2)
	{
		this._nID = loc2;
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
	function __set__state(loc2)
	{
		this._nState = loc2;
		return this.__get__state();
	}
	function __get__state()
	{
		return this._nState;
	}
	function __get__stateStr()
	{
		if((var loc0 = this._nState) !== dofus.datacenter.Server.SERVER_OFFLINE)
		{
			if(loc0 !== dofus.datacenter.Server.SERVER_ONLINE)
			{
				if(loc0 !== dofus.datacenter.Server.SERVER_STARTING)
				{
					return "";
				}
				return this.api.lang.getText("SERVER_STARTING");
			}
			return this.api.lang.getText("SERVER_ONLINE");
		}
		return this.api.lang.getText("SERVER_OFFLINE");
	}
	function __get__stateStrShort()
	{
		if((var loc0 = this._nState) !== dofus.datacenter.Server.SERVER_OFFLINE)
		{
			if(loc0 !== dofus.datacenter.Server.SERVER_ONLINE)
			{
				if(loc0 !== dofus.datacenter.Server.SERVER_STARTING)
				{
					return "";
				}
				return this.api.lang.getText("SERVER_STARTING_SHORT");
			}
			return this.api.lang.getText("SERVER_ONLINE_SHORT");
		}
		return this.api.lang.getText("SERVER_OFFLINE_SHORT");
	}
	function __set__canLog(loc2)
	{
		this._bCanLog = loc2;
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
		var loc2 = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
		return loc2;
	}
	function __get__dateStr()
	{
		var loc2 = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
		return org.utils.SimpleDateFormatter.formatDate(loc2,this.api.lang.getConfigText("LONG_DATE_FORMAT"),this.api.config.language);
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
		var loc2 = this.typeNum;
		switch(loc2)
		{
			case dofus.datacenter.Server.SERVER_129:
			case dofus.datacenter.Server.SERVER_RETRO:
				return dofus.datacenter.Server.SERVER_CLASSIC;
			default:
				return loc2;
		}
	}
	function isHardcore()
	{
		return this.typeNum == dofus.datacenter.Server.SERVER_HARDCORE;
	}
	function initialize(loc2, loc3, loc4, loc5)
	{
		this.api = _global.API;
		this._nID = loc2;
		this._nState = loc3;
		this._bCanLog = loc5;
		this.completion = loc4;
		this.populationWeight = Number(this.api.lang.getServerPopulationWeight(this.population));
	}
	function isAllowed()
	{
		if(this.api.datacenter.Player.isAuthorized)
		{
			return true;
		}
		var loc2 = this.api.lang.getServerInfos(this._nID).rlng;
		if(loc2 == undefined || (loc2.length == undefined || (loc2.length == 0 || this.api.config.skipLanguageVerification)))
		{
			return true;
		}
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3].toUpperCase() == this.api.config.language.toUpperCase())
			{
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
}
