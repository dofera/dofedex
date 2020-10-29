class dofus.datacenter.MountableCreature
{
	function MountableCreature(var3, var4)
	{
		this.initialize(var2,var3);
	}
	function __get__gfxFile()
	{
		return this._sGfxFile;
	}
	function initialize(var2, var3)
	{
		this._sGfxFile = var2;
		this._nGfxID = var3;
		mx.events.EventDispatcher.initialize(this);
	}
}
