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
	function initialize(var2)
	{
		super.initialize(var3);
		this._oAreasCoords = new Object();
		this._oSubAreasCoords = new Object();
		var var4 = this.api.lang.getAllMapsInfos();
		for(var var5 in var4)
		{
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
	function getAreaIDFromCoordinates(var2, var3, var4)
	{
		if(var4 == undefined)
		{
			var4 = 0;
		}
		return this._oAreasCoords[var4 + "_" + var2 + "_" + var3];
	}
	function getSubAreaIDFromCoordinates(var2, var3, var4)
	{
		if(var4 == undefined)
		{
			var4 = 0;
		}
		return this._oSubAreasCoords[var4 + "_" + var2 + "_" + var3];
	}
}
