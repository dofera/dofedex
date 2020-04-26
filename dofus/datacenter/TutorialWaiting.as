class dofus.datacenter.TutorialWaiting extends dofus.datacenter.TutorialBloc
{
	function TutorialWaiting(sID, §\x1e\x1d\x10§, §\x12§)
	{
		super(sID,dofus.datacenter.TutorialBloc.TYPE_WAITING);
		this._nTimeout = loc4;
		this.setCases(loc5);
	}
	function __get__timeout()
	{
		return this._nTimeout != undefined?this._nTimeout:0;
	}
	function __get__cases()
	{
		return this._oCases;
	}
	function setCases(loc2)
	{
		this._oCases = new Object();
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			var loc4 = loc2[loc3];
			var loc5 = loc4[0];
			var loc6 = loc4[1];
			var loc7 = loc4[2];
			var loc8 = new dofus.datacenter.(loc5,loc6,loc7);
			this._oCases[loc5] = loc8;
			loc3 = loc3 + 1;
		}
	}
}
