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
	function addBloc(var2)
	{
		this._oBlocs[var2.id] = var2;
	}
	function setData(var2)
	{
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			var var5 = Number(var4[0]);
			if((var var0 = var5) !== dofus.datacenter.TutorialBloc.TYPE_ACTION)
			{
				if(var0 !== dofus.datacenter.TutorialBloc.TYPE_WAITING)
				{
					if(var0 === dofus.datacenter.TutorialBloc.TYPE_IF)
					{
						var var16 = var4[1];
						var var17 = var4[2];
						var var18 = var4[3];
						var var19 = var4[4];
						var var20 = var4[5];
						var var21 = var4[6];
						var var22 = new dofus.datacenter.
(var16,var17,var18,var19,var20,var21);
						this.addBloc(var22);
					}
				}
				else
				{
					var var12 = var4[1];
					var var13 = Number(var4[2]);
					var var14 = var4[3];
					var var15 = new dofus.datacenter.
(var12,var13,var14);
					this.addBloc(var15);
				}
			}
			else
			{
				var var6 = var4[1];
				var var7 = var4[2];
				var var8 = var4[3];
				var var9 = var4[4];
				var var10 = var4[5];
				var var11 = new dofus.datacenter.
(var6,var7,var8,var9,var10);
				this.addBloc(var11);
			}
			var3 = var3 + 1;
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
	function getBloc(var2)
	{
		return this._oBlocs[var2];
	}
}
