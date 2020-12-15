class dofus.datacenter.Job extends Object
{
	function Job(§\x04\x12§, §\x0f\x15§, options)
	{
		super();
		this.initialize(var3,var4,options);
	}
	function __set__options(var2)
	{
		this._oOptions = var2;
		this.dispatchEvent({type:"optionsChanged",value:var2});
		return this.__get__options();
	}
	function __get__options()
	{
		return this._oOptions;
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__name()
	{
		return this._oJobText.n;
	}
	function __get__description()
	{
		return this._oJobText.d;
	}
	function __get__iconFile()
	{
		return dofus.Constants.JOBS_ICONS_PATH + this._oJobText.g + ".swf";
	}
	function __get__skills()
	{
		return this._eaSkills;
	}
	function __get__crafts()
	{
		return this._eaCrafts;
	}
	function __set__level(var2)
	{
		this._nLevel = var2;
		return this.__get__level();
	}
	function __get__level()
	{
		return this._nLevel;
	}
	function __set__xpMin(var2)
	{
		this._nXPmin = var2;
		return this.__get__xpMin();
	}
	function __get__xpMin()
	{
		return this._nXPmin;
	}
	function __set__xp(var2)
	{
		this._nXP = var2;
		if(this.api.datacenter.Player.currentJobID == this.id)
		{
			var var3 = (dofus.graphics.gapi.ui.Banner)this.api.ui.getUIComponent("Banner");
			if(var3 != undefined && this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "xpcurrentjob")
			{
				dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(var3);
			}
		}
		return this.__get__xp();
	}
	function __get__xp()
	{
		return this._nXP;
	}
	function __set__xpMax(var2)
	{
		this._nXPmax = var2;
		return this.__get__xpMax();
	}
	function __get__xpMax()
	{
		return this._nXPmax <= Math.pow(10,17)?this._nXPmax:this._nXP;
	}
	function __get__specializationOf()
	{
		return this._oJobText.s;
	}
	function initialize(§\x04\x12§, §\x0f\x15§, options)
	{
		eval(mx).events.EventDispatcher.initialize(this);
		this.api = _global.API;
		this._nID = var2;
		this._eaSkills = var3;
		this._oOptions = options;
		this._oJobText = this.api.lang.getJobText(var2);
		if(!_global.isNaN(var3.length))
		{
			this._eaCrafts = new ank.utils.();
			var var5 = new ank.utils.();
			var var6 = 0;
			while(var6 < var3.length)
			{
				var var7 = var5.findFirstItem("id",var3[var6].id);
				if(var7.index == -1)
				{
					var5.push(var3[var6]);
				}
				else if(var7.item.param1 < var3[var6].param1)
				{
					var5[var7.index] = var3[var6];
				}
				var6 = var6 + 1;
			}
			var var8 = 0;
			while(var8 < var5.length)
			{
				var var9 = var5[var8];
				var var10 = var9.craftsList;
				if(var10 != undefined)
				{
					var var11 = 0;
					while(var11 < var10.length)
					{
						var var12 = var10[var11];
						var var13 = new dofus.datacenter.Craft(var12,var9);
						if(var13.itemsCount <= var9.param1)
						{
							this._eaCrafts.push(var13);
						}
						var11 = var11 + 1;
					}
				}
				this._eaCrafts.sortOn("name");
				var8 = var8 + 1;
			}
		}
	}
	function getMaxSkillSlot()
	{
		var var2 = -1;
		var var3 = 0;
		while(var3 < this._eaSkills.length)
		{
			var var4 = this._eaSkills[var3];
			if(var4.param1 > var2)
			{
				var2 = var4.param1;
			}
			var3 = var3 + 1;
		}
		return var2;
	}
}
