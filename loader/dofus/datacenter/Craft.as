class dofus.datacenter.Craft extends Object
{
	function Craft(var2, var3)
	{
		super();
		this.initialize(var3,var4);
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
	function initialize(var2, var3)
	{
		this.api = _global.API;
		this._oSkill = var3;
		this._oCraftItem = new dofus.datacenter.(0,var2,1);
		this.name = this._oCraftItem.name;
		var var4 = this.api.lang.getCraftText(var2);
		this._aItems = new Array();
		if(!_global.isNaN(var4.length))
		{
			var var5 = 0;
			while(var5 < var4.length)
			{
				var var6 = new dofus.datacenter.(0,var4[var5][0],var4[var5][1]);
				this._aItems.push(var6);
				var5 = var5 + 1;
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
