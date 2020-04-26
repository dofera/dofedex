class dofus.datacenter.Craft extends Object
{
	function Craft(loc3, loc4)
	{
		super();
		this.initialize(loc3,loc4);
	}
	function __get__skill()
	{
		return this._oSkill;
	}
	function __get__craftItem()
	{
		return this._oCraftItem;
	}
	function __get__items()
	{
		return this._aItems;
	}
	function __get__itemsCount()
	{
		return this._aItems.length;
	}
	function __get__craftLevel()
	{
		return this.craftItem.level;
	}
	function __get__difficulty()
	{
		return this._nDifficulty;
	}
	function initialize(loc2, loc3)
	{
		this.api = _global.API;
		this._oSkill = loc3;
		this._oCraftItem = new dofus.datacenter.(0,loc2,1);
		this.name = this._oCraftItem.name;
		var loc4 = this.api.lang.getCraftText(loc2);
		this._aItems = new Array();
		if(!_global.isNaN(loc4.length))
		{
			var loc5 = 0;
			while(loc5 < loc4.length)
			{
				var loc6 = new dofus.datacenter.(0,loc4[loc5][0],loc4[loc5][1]);
				this._aItems.push(loc6);
				loc5 = loc5 + 1;
			}
		}
		if(this._aItems.length < Number(this._oSkill.param1) - 4)
		{
			this._nDifficulty = 1;
		}
		else if(this._aItems.length < Number(this._oSkill.param1) - 2)
		{
			this._nDifficulty = 2;
		}
		else
		{
			this._nDifficulty = 3;
		}
	}
}
