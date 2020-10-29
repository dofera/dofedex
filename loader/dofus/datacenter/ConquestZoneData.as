class dofus.datacenter.ConquestZoneData extends dofus.utils.ApiElement
{
	function ConquestZoneData(§\f\x1b§, alignment, fighting, prism, attackable)
	{
		super();
		this._nSubAreaId = var3;
		this._nAlignment = alignment;
		this._bFighting = fighting;
		this._nPrismMap = prism;
		this._bAttackable = attackable;
		this.areaName = _global.API.lang.getMapAreaText(Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a)).n;
	}
	function __get__id()
	{
		return this._nSubAreaId;
	}
	function __get__areaId()
	{
		return Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a);
	}
	function __get__alignment()
	{
		return this._nAlignment;
	}
	function __get__fighting()
	{
		return this._bFighting;
	}
	function __get__prism()
	{
		return this._nPrismMap;
	}
	function __get__attackable()
	{
		return this._bAttackable;
	}
	function isCapturable()
	{
		if(!this._bAttackable)
		{
			return false;
		}
		if(this.alignment == this.api.datacenter.Player.alignment.index)
		{
			return false;
		}
		var var2 = this.getNearZonesList();
		var var3 = this.api.datacenter.Conquest.worldDatas;
		for(var s in var2)
		{
			if(var3.areas.findFirstItem("id",var2[s]).item.alignment == this.api.datacenter.Player.alignment.index)
			{
				while(§§pop() != null)
				{
				}
				return true;
			}
		}
		return false;
	}
	function isVulnerable()
	{
		if(!this._bAttackable)
		{
			return false;
		}
		if(this.alignment != this.api.datacenter.Player.alignment.index)
		{
			return false;
		}
		var var2 = this.getNearZonesList();
		var var3 = this.api.datacenter.Conquest.worldDatas;
		for(var s in var2)
		{
			var var4 = var3.areas.findFirstItem("id",var2[s]).item.alignment;
			if(var4 != this.api.datacenter.Player.alignment.index && var4 > 0)
			{
				return true;
			}
		}
		return false;
	}
	function getNearZonesList()
	{
		return this.api.lang.getMapSubAreaText(this._nSubAreaId).v;
	}
	function toString()
	{
		return "N:" + this.areaName + "/A:" + this.areaId + "/S:" + this.id;
	}
}
