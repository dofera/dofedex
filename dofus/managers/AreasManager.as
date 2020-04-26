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
	function initialize(loc2)
	{
		super.initialize(loc3);
		this._oAreasCoords = new Object();
		this._oSubAreasCoords = new Object();
		var loc4 = this.api.lang.getAllMapsInfos();
		for(var loc5 in loc4)
		{
			var loc6 = this.api.lang.getMapSubAreaText(loc5.sa).a;
			var loc7 = this.api.lang.getMapAreaText(loc6).sua;
			var loc8 = loc7 + "_" + loc5.x + "_" + loc5.y;
			if(this._oAreasCoords[loc8] == undefined)
			{
				this._oAreasCoords[loc8] = loc6;
				this._oSubAreasCoords[loc8] = loc5.sa;
			}
		}
	}
	function getAreaIDFromCoordinates(loc2, loc3, loc4)
	{
		if(loc4 == undefined)
		{
			loc4 = 0;
		}
		return this._oAreasCoords[loc4 + "_" + loc2 + "_" + loc3];
	}
	function getSubAreaIDFromCoordinates(loc2, loc3, loc4)
	{
		if(loc4 == undefined)
		{
			loc4 = 0;
		}
		return this._oSubAreasCoords[loc4 + "_" + loc2 + "_" + loc3];
	}
}
