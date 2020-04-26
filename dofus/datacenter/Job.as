class dofus.datacenter.Job extends Object
{
	function Job(§\x06\x02§, §\x10\x15§, options)
	{
		super();
		this.initialize(loc3,loc4,options);
	}
	function __set__options(loc2)
	{
		this._oOptions = loc2;
		this.dispatchEvent({type:"optionsChanged",value:loc2});
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
	function __set__level(loc2)
	{
		this._nLevel = loc2;
		return this.__get__level();
	}
	function __get__level()
	{
		return this._nLevel;
	}
	function __set__xpMin(loc2)
	{
		this._nXPmin = loc2;
		return this.__get__xpMin();
	}
	function __get__xpMin()
	{
		return this._nXPmin;
	}
	function __set__xp(loc2)
	{
		this._nXP = loc2;
		if(this.api.datacenter.Player.currentJobID == this.id)
		{
			var loc3 = this.api.ui.getUIComponent("Banner");
			if(loc3 != undefined && this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "xpcurrentjob")
			{
				loc3.showGaugeMode();
			}
		}
		return this.__get__xp();
	}
	function __get__xp()
	{
		return this._nXP;
	}
	function __set__xpMax(loc2)
	{
		this._nXPmax = loc2;
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
	function initialize(§\x06\x02§, §\x10\x15§, options)
	{
		mx.events.EventDispatcher.initialize(this);
		this.api = _global.API;
		this._nID = loc2;
		this._eaSkills = loc3;
		this._oOptions = options;
		this._oJobText = this.api.lang.getJobText(loc2);
		if(!_global.isNaN(loc3.length))
		{
			this._eaCrafts = new ank.utils.();
			var loc5 = new ank.utils.();
			var loc6 = 0;
			while(loc6 < loc3.length)
			{
				var loc7 = loc5.findFirstItem("id",loc3[loc6].id);
				if(loc7.index == -1)
				{
					loc5.push(loc3[loc6]);
				}
				else if(loc7.item.param1 < loc3[loc6].param1)
				{
					loc5[loc7.index] = loc3[loc6];
				}
				loc6 = loc6 + 1;
			}
			var loc8 = 0;
			while(loc8 < loc5.length)
			{
				var loc9 = loc5[loc8];
				var loc10 = loc9.craftsList;
				if(loc10 != undefined)
				{
					var loc11 = 0;
					while(loc11 < loc10.length)
					{
						var loc12 = loc10[loc11];
						var loc13 = new dofus.datacenter.Craft(loc12,loc9);
						if(loc13.itemsCount <= loc9.param1)
						{
							this._eaCrafts.push(loc13);
						}
						loc11 = loc11 + 1;
					}
				}
				this._eaCrafts.sortOn("name");
				loc8 = loc8 + 1;
			}
		}
	}
	function getMaxSkillSlot()
	{
		var loc2 = -1;
		var loc3 = 0;
		while(loc3 < this._eaSkills.length)
		{
			var loc4 = this._eaSkills[loc3];
			if(loc4.param1 > loc2)
			{
				loc2 = loc4.param1;
			}
			loc3 = loc3 + 1;
		}
		return loc2;
	}
}
