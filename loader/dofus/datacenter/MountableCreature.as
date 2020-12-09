class dofus.datacenter.MountableCreature
{
	function MountableCreature(§\x1e\x12\f§, §\x05\t§)
	{
		this.initialize(var2,var3);
	}
	function __get__gfxFile()
	{
		return this._sGfxFile;
	}
	function initialize(§\x1e\x12\f§, §\x05\t§)
	{
		this._sGfxFile = var2;
		this._nGfxID = var3;
		mx.events.EventDispatcher.initialize(this);
	}
}
