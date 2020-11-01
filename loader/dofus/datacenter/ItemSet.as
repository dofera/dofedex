class dofus.datacenter.ItemSet extends Object
{
	function ItemSet(var2, var3, var4)
	{
		super();
		this.initialize(var3,var4,var5);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__name()
	{
		return this.api.lang.getItemSetText(this._nID).n;
	}
	function __get__description()
	{
		return this.api.lang.getItemSetText(this._nID).d;
	}
	function __get__itemCount()
	{
		return this._aItems.length;
	}
	function __get__items()
	{
		return this._aItems;
	}
	function __get__effects()
	{
		return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects);
	}
	function initialize(var2, var3, var4)
	{
		if(var3 == undefined)
		{
			var3 = "";
		}
		if(var4 == undefined)
		{
			var4 = [];
		}
		this.api = _global.API;
		this._nID = var2;
		this.setEffects(var3);
		this.setItems(var4);
	}
	function setEffects(var2)
	{
		this._sEffects = var2;
		this._aEffects = new Array();
		var var3 = var2.split(",");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].split("#");
			var5[0] = _global.parseInt(var5[0],16);
			var5[1] = var5[1] != "0"?_global.parseInt(var5[1],16):undefined;
			var5[2] = var5[2] != "0"?_global.parseInt(var5[2],16):undefined;
			var5[3] = var5[3] != "0"?_global.parseInt(var5[3],16):undefined;
			this._aEffects.push(var5);
			var4 = var4 + 1;
		}
	}
	function setItems(var2)
	{
		var var3 = this.api.lang.getItemSetText(this._nID).i;
		this._aItems = new Array();
		var var4 = new Object();
		for(var k in var2)
		{
			var4[var2[k]] = true;
		}
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = Number(var3[var5]);
			if(!_global.isNaN(var6))
			{
				var var7 = new dofus.datacenter.(0,var6,1);
				var var8 = var4[var6] == true;
				this._aItems.push({isEquiped:var8,item:var7});
			}
			var5 = var5 + 1;
		}
	}
}
