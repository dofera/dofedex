class dofus.datacenter.Skill extends Object
{
	function Skill(loc3, loc4, loc5, loc6, loc7)
	{
		super();
		this.initialize(loc3,loc4,loc5,loc6,loc7);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__description()
	{
		return this._oSkillText.d;
	}
	function __get__job()
	{
		return this._oSkillText.j;
	}
	function __get__criterion()
	{
		return this._oSkillText.c;
	}
	function __get__item()
	{
		if(this._oSkillText.i == undefined)
		{
			return null;
		}
		return new dofus.datacenter.(0,this._oSkillText.i);
	}
	function __get__interactiveObject()
	{
		return this.api.lang.getInteractiveObjectDataText(this._oSkillText.io).n;
	}
	function __get__param1()
	{
		return this._nParam1;
	}
	function __get__param2()
	{
		return this._nParam2;
	}
	function __get__param3()
	{
		return this._nParam3;
	}
	function __get__param4()
	{
		return this._nParam4;
	}
	function __get__craftsList()
	{
		if(this._oCraftsList instanceof Array)
		{
			return this._oCraftsList;
		}
		this._oCraftsList = new Array();
		var loc2 = 0;
		while(loc2 < this._oSkillText.cl.length)
		{
			var loc3 = this.api.lang.getItemUnicText(this._oSkillText.cl[loc2]).ep;
			if(loc3 <= this.api.datacenter.Basics.aks_current_regional_version && (loc3 != undefined && !_global.isNaN(loc3)))
			{
				this._oCraftsList.push(this._oSkillText.cl[loc2]);
			}
			loc2 = loc2 + 1;
		}
		return this._oCraftsList;
	}
	function initialize(loc2, loc3, loc4, loc5, loc6)
	{
		this.api = _global.API;
		this._nID = loc2;
		if(loc3 != 0)
		{
			this._nParam1 = loc3;
		}
		if(loc4 != 0)
		{
			this._nParam2 = loc4;
		}
		if(loc5 != 0)
		{
			this._nParam3 = loc5;
		}
		if(loc6 != 0)
		{
			this._nParam4 = loc6;
		}
		this._oSkillText = this.api.lang.getSkillText(loc2);
		this.skillName = this.description;
	}
	function getState(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		if(this.criterion == undefined || this.criterion.length == 0)
		{
			return "V";
		}
		var loc8 = this.criterion.split("?");
		var loc9 = loc8[0].split("&");
		var loc10 = loc8[1].split(":");
		var loc11 = loc10[0];
		var loc12 = loc10[1];
		var loc13 = 0;
		while(loc13 < loc9.length)
		{
			var loc14 = loc9[loc13];
			var loc15 = loc14.charAt(0) == "!";
			if(loc15)
			{
				loc14 = loc14.substr(1);
			}
			switch(loc14)
			{
				case "J":
					if(loc15)
					{
						loc2 = !loc2;
					}
					if(!loc2)
					{
						return loc12;
					}
					break;
				case "O":
					if(loc15)
					{
						loc3 = !loc3;
					}
					if(!loc3)
					{
						return loc12;
					}
					break;
				default:
					switch(null)
					{
						case "S":
							if(loc15)
							{
								loc4 = !loc4;
							}
							if(!loc4)
							{
								return loc12;
							}
							break;
						case "L":
							if(loc15)
							{
								loc5 = !loc5;
							}
							if(!loc5)
							{
								return loc12;
							}
							break;
						case "I":
							if(loc15)
							{
								loc6 = !loc6;
							}
							if(!loc6)
							{
								return loc12;
							}
							break;
						case "N":
							if(loc15)
							{
								loc7 = !loc7;
							}
							if(!loc7)
							{
								return loc12;
							}
							break;
					}
			}
			loc13 = loc13 + 1;
		}
		return loc11;
	}
}
