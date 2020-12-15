class dofus.managers.AreasManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	function AreasManager()
	{
		super();
		dofus.managers.AreasManager._sSelf = this;
	}
	static function getInstance()
	{
		return dofus.managers.AreasManager._sSelf;
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI);
		this._oAreasCoords = new Object();
		this._oSubAreasCoords = new Object();
		var var4 = this.api.lang.getAllMapsInfos();
		for(var k in var4)
		{
			var var5 = var4[k];
			var var6 = this.api.lang.getMapSubAreaText(var5.sa).a;
			var var7 = this.api.lang.getMapAreaText(var6).sua;
			var var8 = var7 + "_" + var5.x + "_" + var5.y;
			if(this._oAreasCoords[var8] == undefined)
			{
				this._oAreasCoords[var8] = var6;
				this._oSubAreasCoords[var8] = var5.sa;
			}
		}
	}
	function getAreaIDFromCoordinates(nX, nY, §\x1e\x1c\x12§)
	{
		if(var4 == undefined)
		{
			var4 = 0;
		}
		return this._oAreasCoords[var4 + "_" + nX + "_" + nY];
	}
	function getSubAreaIDFromCoordinates(nX, nY, §\x1e\x1c\x12§)
	{
		if(var4 == undefined)
		{
			var4 = 0;
		}
		return this._oSubAreasCoords[var4 + "_" + nX + "_" + nY];
	}
}
