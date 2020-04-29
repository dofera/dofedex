class dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter implements dofus.graphics.gapi.controls.inventoryviewer.IInventoryFilter
{
	var _nMaximalLevel = null;
	var _aAllowedTypes = null;
	function BigStoreSellFilter(maximalLevel, allowedTypes)
	{
		this._nMaximalLevel = maximalLevel;
		this._aAllowedTypes = allowedTypes;
	}
	function isItemListed(var2)
	{
		if(this._nMaximalLevel != null && var2.level > this._nMaximalLevel)
		{
			return false;
		}
		var var3 = false;
		for(var i in this._aAllowedTypes)
		{
			if(var2.type == Number(this._aAllowedTypes[i]))
			{
				var3 = true;
				break;
			}
		}
		if(!var3)
		{
			return false;
		}
		return true;
	}
}
