class dofus.datacenter.QuestStep extends Object
{
	function QuestStep(var3, var4, var5, var6, var7, var8, var9)
	{
		super();
		this.initialize(var3,var4,var5,var6,var7,var8,var9);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__name()
	{
		var var2 = this.api.lang.getQuestStepText(this._nID).n;
		if(var2 != null && dofus.Constants.DEBUG)
		{
			var2 = var2 + " (" + this._nID + ")";
		}
		return var2;
	}
	function __get__description()
	{
		return this.api.lang.getQuestStepText(this._nID).d;
	}
	function __get__objectives()
	{
		return this._eaObjectives;
	}
	function __get__allSteps()
	{
		var var2 = new ank.utils.();
		var var3 = 0;
		while(var3 < this._aPreviousSteps.length)
		{
			var2.push(new dofus.datacenter.(this._aPreviousSteps[var3],2));
			var3 = var3 + 1;
		}
		var2.push(this);
		var var4 = 0;
		while(var4 < this._aNextSteps.length)
		{
			var2.push(new dofus.datacenter.(this._aNextSteps[var4],0));
			var4 = var4 + 1;
		}
		return var2;
	}
	function __get__rewards()
	{
		var var2 = new ank.utils.();
		var var3 = this.api.lang.getQuestStepText(this._nID).r;
		if(var3[0] != undefined)
		{
			var2.push({iconFile:"UI_QuestXP",label:var3[0]});
		}
		if(var3[1] != undefined)
		{
			var2.push({iconFile:"UI_QuestKamaSymbol",label:var3[1]});
		}
		if(var3[2] != undefined)
		{
			var var4 = var3[2];
			var var5 = 0;
			while(var5 < var4.length)
			{
				var var6 = Number(var4[var5][0]);
				var var7 = var4[var5][1];
				var var8 = new dofus.datacenter.(0,var6,var7);
				var2.push({iconFile:var8.iconFile,label:(var7 == 0?"":"x" + var7 + " ") + var8.name});
				var5 = var5 + 1;
			}
		}
		if(var3[3] != undefined)
		{
			var var9 = var3[3];
			var var10 = 0;
			while(var10 < var9.length)
			{
				var var11 = Number(var9[var10]);
				var2.push({iconFile:dofus.Constants.EMOTES_ICONS_PATH + var11 + ".swf",label:this.api.lang.getEmoteText(var11).n});
				var10 = var10 + 1;
			}
		}
		if(var3[4] != undefined)
		{
			var var12 = var3[4];
			var var13 = 0;
			while(var13 < var12.length)
			{
				var var14 = Number(var12[var13]);
				var var15 = new dofus.datacenter.Job(var14);
				var2.push({iconFile:var15.iconFile,label:var15.name});
				var13 = var13 + 1;
			}
		}
		if(var3[5] != undefined)
		{
			var var16 = var3[5];
			var var17 = 0;
			while(var17 < var16.length)
			{
				var var18 = Number(var16[var17]);
				var var19 = new dofus.datacenter.(var18,1);
				var2.push({iconFile:var19.iconFile,label:var19.name});
				var17 = var17 + 1;
			}
		}
		return var2;
	}
	function __get__dialogID()
	{
		return this._nDialogID;
	}
	function __get__dialogParams()
	{
		return this._aDialogParams;
	}
	function __get__isFinished()
	{
		return this._nState == 2;
	}
	function __get__isCurrent()
	{
		return this._nState == 1;
	}
	function __get__isNotDo()
	{
		return this._nState == 0;
	}
	function __get__hasPrevious()
	{
		return true;
	}
	function __get__hasNext()
	{
		return true;
	}
	function initialize(var2, var3, var4, var5, var6, var7, var8)
	{
		this.api = _global.API;
		this._nID = var2;
		this._nState = var3;
		this._eaObjectives = var4;
		this._aPreviousSteps = var5;
		this._aNextSteps = var6;
		this._nDialogID = var7;
		this._aDialogParams = var8;
	}
}
