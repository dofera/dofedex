class dofus.datacenter.House extends Object
{
	static var GUILDSHARE_VISIBLE_GUILD_BRIEF = 1;
	static var GUILDSHARE_DOORSIGN_GUILD = 2;
	static var GUILDSHARE_DOORSIGN_OTHERS = 4;
	static var GUILDSHARE_ALLOWDOOR_GUILD = 8;
	static var GUILDSHARE_FORBIDDOOR_OTHERS = 16;
	static var GUILDSHARE_ALLOWCHESTS_GUILD = 32;
	static var GUILDSHARE_FORBIDCHESTS_OTHERS = 64;
	static var GUILDSHARE_TELEPORT = 128;
	static var GUILDSHARE_RESPAWN = 256;
	var _bLocalOwner = false;
	var _sOwnerName = new String();
	var _sGuildName = new String();
	var _bForSale = false;
	var _bLocked = false;
	var _bShared = false;
	function House(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__name()
	{
		return this.api.lang.fetchString(this._sName);
	}
	function __get__description()
	{
		return this.api.lang.fetchString(this._sDescription);
	}
	function __set__price(loc2)
	{
		this._nPrice = Number(loc2);
		return this.__get__price();
	}
	function __get__price()
	{
		return this._nPrice;
	}
	function __set__localOwner(loc2)
	{
		this._bLocalOwner = loc2;
		return this.__get__localOwner();
	}
	function __get__localOwner()
	{
		return this._bLocalOwner;
	}
	function __set__ownerName(loc2)
	{
		this._sOwnerName = loc2;
		return this.__get__ownerName();
	}
	function __get__ownerName()
	{
		if(typeof this._sOwnerName == "string")
		{
			if(this._sOwnerName.length > 0)
			{
				return this._sOwnerName;
			}
		}
		return null;
	}
	function __set__guildName(loc2)
	{
		this._sGuildName = loc2;
		this.dispatchEvent({type:"guild",value:this});
		return this.__get__guildName();
	}
	function __get__guildName()
	{
		if(typeof this._sGuildName == "string")
		{
			if(this._sGuildName.length > 0)
			{
				return this._sGuildName;
			}
		}
		return null;
	}
	function __set__guildEmblem(loc2)
	{
		this._oGuildEmblem = loc2;
		this.dispatchEvent({type:"guild",value:this});
		return this.__get__guildEmblem();
	}
	function __get__guildEmblem()
	{
		return this._oGuildEmblem;
	}
	function __set__guildRights(loc2)
	{
		this._nGuildRights = Number(loc2);
		this.dispatchEvent({type:"guild",value:this});
		return this.__get__guildRights();
	}
	function __get__guildRights()
	{
		return this._nGuildRights;
	}
	function __set__isForSale(loc2)
	{
		this._bForSale = loc2;
		this.dispatchEvent({type:"forsale",value:loc2});
		return this.__get__isForSale();
	}
	function __get__isForSale()
	{
		return this._bForSale;
	}
	function __set__isLocked(loc2)
	{
		this._bLocked = loc2;
		this.dispatchEvent({type:"locked",value:loc2});
		return this.__get__isLocked();
	}
	function __get__isLocked()
	{
		return this._bLocked;
	}
	function __set__isShared(loc2)
	{
		this._bShared = loc2;
		this.dispatchEvent({type:"shared",value:loc2});
		return this.__get__isShared();
	}
	function __get__isShared()
	{
		return this._bShared;
	}
	function __set__coords(loc2)
	{
		this._pCoords = loc2;
		return this.__get__coords();
	}
	function __get__coords()
	{
		return this._pCoords;
	}
	function __set__skills(loc2)
	{
		this._aSkills = loc2;
		return this.__get__skills();
	}
	function __get__skills()
	{
		return this._aSkills;
	}
	function initialize(loc2)
	{
		this.api = _global.API;
		mx.events.EventDispatcher.initialize(this);
		this._nID = loc2;
		var loc3 = this.api.lang.getHouseText(loc2);
		this._sName = loc3.n;
		this._sDescription = loc3.d;
	}
	function hasRight(loc2)
	{
		return (this._nGuildRights & loc2) == loc2;
	}
	function getHumanReadableRightsList()
	{
		var loc2 = new ank.utils.();
		var loc3 = 1;
		while(loc3 < 8192)
		{
			if(this.hasRight(loc3))
			{
				loc2.push({id:loc3,label:this.api.lang.getText("GUILD_HOUSE_RIGHT_" + loc3)});
			}
			loc3 = loc3 * 2;
		}
		return loc2;
	}
}
