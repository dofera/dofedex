class dofus.datacenter.MountableCreature
{
	function MountableCreature(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function __get__gfxFile()
	{
		return this._sGfxFile;
	}
	function initialize(loc2, loc3)
	{
		this._sGfxFile = loc2;
		this._nGfxID = loc3;
		eval("\n\x0b").events.EventDispatcher.initialize(this);
	}
}
