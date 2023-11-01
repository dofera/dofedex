class dofus.datacenter.TutorialWaiting extends dofus.datacenter.TutorialBloc
{
	function TutorialWaiting(sID, §\x1e\x1b\x1b§, §\x12§)
	{
		super(sID,dofus.datacenter.TutorialBloc.TYPE_WAITING);
		this._nTimeout = var4;
		this.setCases(var5);
	}
	function __get__timeout()
	{
		return this._nTimeout != undefined?this._nTimeout:0;
	}
	function __get__cases()
	{
		return this._oCases;
	}
	function setCases(var2)
	{
		this._oCases = new Object();
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			var var5 = var4[0];
			var var6 = var4[1];
			var var7 = var4[2];
			var var8 = new dofus.datacenter.
(var5,var6,var7);
			this._oCases[var5] = var8;
			var3 = var3 + 1;
		}
	}
}
