class dofus.datacenter.Skill extends Object
{
	function Skill(var3, var4, var5, var6, var7)
	{
		super();
		this.initialize(var3,var4,var5,var6,var7);
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
		return new dofus.datacenter.(0,this._oSkillText.i);
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
		var var2 = 0;
		while(var2 < this._oSkillText.cl.length)
		{
			var var3 = this.api.lang.getItemUnicText(this._oSkillText.cl[var2]).ep;
			if(var3 <= this.api.datacenter.Basics.aks_current_regional_version && (var3 != undefined && !_global.isNaN(var3)))
			{
				this._oCraftsList.push(this._oSkillText.cl[var2]);
			}
			var2 = var2 + 1;
		}
		return this._oCraftsList;
	}
	function initialize(var2, var3, var4, var5, var6)
	{
		this.api = _global.API;
		this._nID = var2;
		if(var3 != 0)
		{
			this._nParam1 = var3;
		}
		if(var4 != 0)
		{
			this._nParam2 = var4;
		}
		if(var5 != 0)
		{
			this._nParam3 = var5;
		}
		if(var6 != 0)
		{
			this._nParam4 = var6;
		}
		this._oSkillText = this.api.lang.getSkillText(var2);
		this.skillName = this.description;
	}
	function getState(var2, var3, var4, var5, var6, var7)
	{
		if(this.criterion == undefined || this.criterion.length == 0)
		{
			return "V";
		}
		var var8 = this.criterion.split("?");
		var var9 = var8[0].split("&");
		var var10 = var8[1].split(":");
		var var11 = var10[0];
		var var12 = var10[1];
		var var13 = 0;
		while(var13 < var9.length)
		{
			var var14 = var9[var13];
			var var15 = var14.charAt(0) == "!";
			if(var15)
			{
				var14 = var14.substr(1);
			}
			switch(var14)
			{
				case "J":
					if(var15)
					{
						var2 = !var2;
					}
					if(!var2)
					{
						return var12;
					}
					break;
				case "O":
					if(var15)
					{
						var3 = !var3;
					}
					if(!var3)
					{
						return var12;
					}
					break;
				case "S":
					if(var15)
					{
						var4 = !var4;
					}
					if(!var4)
					{
						return var12;
					}
					break;
				default:
					switch(null)
					{
						case "L":
							if(var15)
							{
								var5 = !var5;
							}
							if(!var5)
							{
								return var12;
							}
							break;
						case "I":
							if(var15)
							{
								var6 = !var6;
							}
							if(!var6)
							{
								return var12;
							}
							break;
						case "N":
							if(var15)
							{
								var7 = !var7;
							}
							if(!var7)
							{
								return var12;
							}
							break;
					}
			}
			var13 = var13 + 1;
		}
		return var11;
	}
}
