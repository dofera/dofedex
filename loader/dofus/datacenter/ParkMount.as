class dofus.datacenter.ParkMount extends dofus.datacenter.PlayableCharacter
{
	function ParkMount(sID, clipClass, §\x1e\x11\x1c§, §\x13\x05§, §\x10\x1d§, gfxID, nModelID)
	{
		super();
		this.initialize(sID,clipClass,var5,var6,var7,gfxID);
		this.modelID = nModelID;
		this._lang = _global.API.lang.getMountText(nModelID);
	}
	function __get__color1()
	{
		return this._lang.c1;
	}
	function __get__color2()
	{
		return this._lang.c2;
	}
	function __get__color3()
	{
		return this._lang.c3;
	}
	function __get__modelName()
	{
		return this._lang.n;
	}
}
