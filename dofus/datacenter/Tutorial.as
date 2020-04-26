class dofus.datacenter.Tutorial extends Object
{
	static var NORMAL_BLOC = 0;
	static var EXIT_BLOC = 1;
	function Tutorial(mcData)
	{
		super();
		this._oBlocs = new Object();
		this.setData(mcData.actions);
		this._sRootBlocID = mcData.rootBlocID;
		this._sRootExitBlocID = mcData.rootExitBlocID;
		this._bCanCancel = mcData.canCancel != undefined?mcData.canCancel:true;
	}
	function __get__canCancel()
	{
		return this._bCanCancel;
	}
	function addBloc(loc2)
	{
		this._oBlocs[loc2.id] = loc2;
	}
	function setData(loc2)
	{
		var loc3 = 0;
		for(; loc3 < loc2.length; loc3 = loc3 + 1)
		{
			var loc4 = loc2[loc3];
			var loc5 = Number(loc4[0]);
			if((var loc0 = loc5) !== dofus.datacenter.TutorialBloc.TYPE_ACTION)
			{
				switch(null)
				{
					case dofus.datacenter.TutorialBloc.TYPE_WAITING:
						var loc12 = loc4[1];
						var loc13 = Number(loc4[2]);
						var loc14 = loc4[3];
						var loc15 = new dofus.datacenter.(loc12,loc13,loc14);
						this.addBloc(loc15);
					case dofus.datacenter.TutorialBloc.TYPE_IF:
						var loc16 = loc4[1];
						var loc17 = loc4[2];
						var loc18 = loc4[3];
						var loc19 = loc4[4];
						var loc20 = loc4[5];
						var loc21 = loc4[6];
						var loc22 = new dofus.datacenter.(loc16,loc17,loc18,loc19,loc20,loc21);
						this.addBloc(loc22);
					default:
						continue;
				}
			}
			else
			{
				var loc6 = loc4[1];
				var loc7 = loc4[2];
				var loc8 = loc4[3];
				var loc9 = loc4[4];
				var loc10 = loc4[5];
				var loc11 = new dofus.datacenter.(loc6,loc7,loc8,loc9,loc10);
				this.addBloc(loc11);
			}
		}
	}
	function getRootBloc()
	{
		return this._oBlocs[this._sRootBlocID];
	}
	function getRootExitBloc()
	{
		return this._oBlocs[this._sRootExitBlocID];
	}
	function getBloc(loc2)
	{
		return this._oBlocs[loc2];
	}
}
