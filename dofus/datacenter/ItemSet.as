class dofus.datacenter.ItemSet extends Object
{
	function ItemSet(loc3, loc4, loc5)
	{
		super();
		this.initialize(loc3,loc4,loc5);
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
	function initialize(loc2, loc3, loc4)
	{
		if(loc3 == undefined)
		{
			loc3 = "";
		}
		if(loc4 == undefined)
		{
			loc4 = [];
		}
		this.api = _global.API;
		this._nID = loc2;
		this.setEffects(loc3);
		this.setItems(loc4);
	}
	function setEffects(loc2)
	{
		this._sEffects = loc2;
		this._aEffects = new Array();
		var loc3 = loc2.split(",");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4].split("#");
			loc5[0] = _global.parseInt(loc5[0],16);
			loc5[1] = loc5[1] != "0"?_global.parseInt(loc5[1],16):undefined;
			loc5[2] = loc5[2] != "0"?_global.parseInt(loc5[2],16):undefined;
			loc5[3] = loc5[3] != "0"?_global.parseInt(loc5[3],16):undefined;
			this._aEffects.push(loc5);
			loc4 = loc4 + 1;
		}
	}
	function setItems(loc2)
	{
		var loc3 = this.api.lang.getItemSetText(this._nID).i;
		this._aItems = new Array();
		var loc4 = new Object();
		for(var k in loc2)
		{
			loc4[loc2[k]] = true;
		}
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = Number(loc3[loc5]);
			if(!_global.isNaN(loc6))
			{
				var loc7 = new dofus.datacenter.(0,loc6,1);
				var loc8 = loc4[loc6] == true;
				this._aItems.push({isEquiped:loc8,item:loc7});
			}
			loc5 = loc5 + 1;
		}
	}
}
