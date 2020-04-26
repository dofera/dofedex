class dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter implements dofus.graphics.gapi.controls.inventoryviewer.IInventoryFilter
{
	var _nMaximalLevel = null;
	var _aAllowedTypes = null;
	function BigStoreSellFilter(maximalLevel, allowedTypes)
	{
		this._nMaximalLevel = maximalLevel;
		this._aAllowedTypes = allowedTypes;
	}
	function isItemListed(loc2)
	{
		if(this._nMaximalLevel != null && loc2.level > this._nMaximalLevel)
		{
			return false;
		}
		var loc3 = false;
		loop0:
		for(var i in this._aAllowedTypes)
		{
			if(loc2.type == Number(this._aAllowedTypes[i]))
			{
				loc3 = true;
				while(true)
				{
					if(§§pop() == null)
					{
						break loop0;
					}
				}
			}
			else
			{
				continue;
			}
		}
		if(!loc3)
		{
			return false;
		}
		return true;
	}
}
