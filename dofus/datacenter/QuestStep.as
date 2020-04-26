class dofus.datacenter.QuestStep extends Object
{
	function QuestStep(loc3, loc4, loc5, loc6, loc7, loc8, loc9)
	{
		super();
		this.initialize(loc3,loc4,loc5,loc6,loc7,loc8,loc9);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__name()
	{
		return this.api.lang.getQuestStepText(this._nID).n;
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
		var loc2 = new ank.utils.();
		var loc3 = 0;
		while(loc3 < this._aPreviousSteps.length)
		{
			loc2.push(new dofus.datacenter.(this._aPreviousSteps[loc3],2));
			loc3 = loc3 + 1;
		}
		loc2.push(this);
		var loc4 = 0;
		while(loc4 < this._aNextSteps.length)
		{
			loc2.push(new dofus.datacenter.(this._aNextSteps[loc4],0));
			loc4 = loc4 + 1;
		}
		return loc2;
	}
	function __get__rewards()
	{
		var loc2 = new ank.utils.();
		var loc3 = this.api.lang.getQuestStepText(this._nID).r;
		if(loc3[0] != undefined)
		{
			loc2.push({iconFile:"UI_QuestXP",label:loc3[0]});
		}
		if(loc3[1] != undefined)
		{
			loc2.push({iconFile:"UI_QuestKamaSymbol",label:loc3[1]});
		}
		if(loc3[2] != undefined)
		{
			var loc4 = loc3[2];
			var loc5 = 0;
			while(loc5 < loc4.length)
			{
				var loc6 = Number(loc4[loc5][0]);
				var loc7 = loc4[loc5][1];
				var loc8 = new dofus.datacenter.(0,loc6,loc7);
				loc2.push({iconFile:loc8.iconFile,label:(loc7 == 0?"":"x" + loc7 + " ") + loc8.name});
				loc5 = loc5 + 1;
			}
		}
		if(loc3[3] != undefined)
		{
			var loc9 = loc3[3];
			var loc10 = 0;
			while(loc10 < loc9.length)
			{
				var loc11 = Number(loc9[loc10]);
				loc2.push({iconFile:dofus.Constants.EMOTES_ICONS_PATH + loc11 + ".swf",label:this.api.lang.getEmoteText(loc11).n});
				loc10 = loc10 + 1;
			}
		}
		if(loc3[4] != undefined)
		{
			var loc12 = loc3[4];
			var loc13 = 0;
			while(loc13 < loc12.length)
			{
				var loc14 = Number(loc12[loc13]);
				var loc15 = new dofus.datacenter.Job(loc14);
				loc2.push({iconFile:loc15.iconFile,label:loc15.name});
				loc13 = loc13 + 1;
			}
		}
		if(loc3[5] != undefined)
		{
			var loc16 = loc3[5];
			var loc17 = 0;
			while(loc17 < loc16.length)
			{
				var loc18 = Number(loc16[loc17]);
				var loc19 = new dofus.datacenter.(loc18,1);
				loc2.push({iconFile:loc19.iconFile,label:loc19.name});
				loc17 = loc17 + 1;
			}
		}
		return loc2;
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
	function initialize(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		this.api = _global.API;
		this._nID = loc2;
		this._nState = loc3;
		this._eaObjectives = loc4;
		this._aPreviousSteps = loc5;
		this._aNextSteps = loc6;
		this._nDialogID = loc7;
		this._aDialogParams = loc8;
	}
}
