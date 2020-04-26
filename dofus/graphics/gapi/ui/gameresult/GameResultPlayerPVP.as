class dofus.graphics.gapi.ui.gameresult.GameResultPlayerPVP extends ank.gapi.core.UIBasicComponent
{
	function GameResultPlayerPVP()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		loc4.items.sortOn("_itemLevel",Array.DESCENDING | Array.NUMERIC);
		this._oItems = loc4;
		var loc5 = this._mcList._parent.api;
		if(loc2)
		{
			if((var loc0 = loc4.type) !== "monster")
			{
				switch(null)
				{
					case "taxcollector":
					case "player":
				}
			}
			this._lblName.text = loc4.name;
			if(loc4.rank == 0 && !loc5.datacenter.Basics.aks_current_server.isHardcore())
			{
				this._pbHonour._visible = false;
				this._lblWinHonour._visible = false;
				this._pbDisgrace._visible = false;
				this._lblWinDisgrace._visible = false;
				this._lblRank._visible = false;
			}
			else
			{
				this._pbHonour._visible = true;
				this._pbDisgrace._visible = true;
				this._lblWinDisgrace._visible = true;
				this._lblWinHonour._visible = true;
				this._lblRank._visible = true;
				if(loc5.datacenter.Basics.aks_current_server.isHardcore())
				{
					if(_global.isNaN(loc4.minxp))
					{
						this._pbDisgrace._visible = false;
					}
					this._pbDisgrace.minimum = loc4.minxp;
					this._pbDisgrace.maximum = loc4.maxxp;
					this._pbDisgrace.value = loc4.xp;
				}
				else
				{
					this._pbDisgrace.minimum = loc4.mindisgrace;
					this._pbDisgrace.maximum = loc4.maxdisgrace;
					this._pbDisgrace.value = loc4.disgrace;
				}
				this._pbHonour.minimum = loc4.minhonour;
				this._pbHonour.maximum = loc4.maxhonour;
				this._pbHonour.value = loc4.honour;
			}
			this._lblWinHonour.text = !_global.isNaN(loc4.winhonour)?loc4.winhonour:"";
			if(!loc5.datacenter.Basics.aks_current_server.isHardcore())
			{
				this._lblWinDisgrace.text = !_global.isNaN(loc4.windisgrace)?loc4.windisgrace:"";
			}
			else
			{
				this._lblWinDisgrace.text = !_global.isNaN(loc4.winxp)?loc4.winxp:"";
			}
			this._lblRank.text = !_global.isNaN(loc4.rank)?loc4.rank:"";
			this._lblKama.text = !_global.isNaN(loc4.kama)?loc4.kama:"";
			this._lblLevel.text = loc4.level;
			this._mcDeadHead._visible = loc4.bDead;
			this.createEmptyMovieClip("_mcItems",10);
			var loc6 = false;
			var loc7 = loc4.items.length;
			while((loc7 = loc7 - 1) >= 0)
			{
				var loc8 = this._mcItemPlacer._x + 24 * loc7;
				if(loc8 < this._mcItemPlacer._x + this._mcItemPlacer._width)
				{
					var loc9 = loc4.items[loc7];
					var loc10 = this._mcItems.attachMovie("Container","_ctrItem" + loc7,loc7,{_x:loc8,_y:this._mcItemPlacer._y + 1});
					loc10.setSize(18,18);
					loc10.addEventListener("over",this);
					loc10.addEventListener("out",this);
					loc10.addEventListener("click",this);
					loc10.enabled = true;
					loc10.margin = 0;
					loc10.contentData = loc9;
				}
				else
				{
					loc6 = true;
				}
			}
			this._ldrAllDrop._visible = loc6;
		}
		else if(this._lblName.text != undefined)
		{
			this._pbHonour._visible = false;
			this._lblName.text = "";
			this._pbHonour.minimum = 0;
			this._pbHonour.maximum = 100;
			this._pbHonour.value = 0;
			this._pbDisgrace.minimum = 0;
			this._pbDisgrace.maximum = 100;
			this._pbDisgrace.value = 0;
			this._lblWinHonour.text = "";
			this._lblWinDisgrace.text = "";
			this._lblKama.text = "";
			this._mcDeadHead._visible = false;
			this._mcItems.removeMovieClip();
		}
	}
	function init()
	{
		super.init(false);
		this._mcItemPlacer._visible = false;
		this._pbHonour._visible = false;
		this._mcDeadHead._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
	}
	function size()
	{
		super.size();
	}
	function addListeners()
	{
		var loc2 = this;
		this._ldrAllDrop.onRollOver = function()
		{
			this._parent.over({target:this});
		};
		this._ldrAllDrop.onRollOut = function()
		{
			this._parent.out({target:this});
		};
		this._pbHonour.enabled = true;
		this._pbHonour.addEventListener("over",this);
		this._pbHonour.addEventListener("out",this);
		this._pbDisgrace.enabled = true;
		this._pbDisgrace.addEventListener("over",this);
		this._pbDisgrace.addEventListener("out",this);
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._ldrAllDrop:
				var loc3 = this._oItems.items;
				var loc4 = "";
				var loc5 = 0;
				while(loc5 < loc3.length)
				{
					var loc6 = loc3[loc5];
					if(loc5 > 0)
					{
						loc4 = loc4 + "\n";
					}
					loc4 = loc4 + (loc6.Quantity + " x " + loc6.name);
					loc5 = loc5 + 1;
				}
				if(loc4 != "")
				{
					this._mcList.gapi.showTooltip(loc4,loc2.target,30);
				}
				break;
			case this._pbHonour:
			case this._pbDisgrace:
				this._mcList.gapi.showTooltip(loc2.target.value + " / " + loc2.target.maximum,loc2.target,20);
				break;
			default:
				var loc7 = loc2.target.contentData;
				var loc8 = loc7.style + "ToolTip";
				this._mcList.gapi.showTooltip(loc7.Quantity + " x " + loc7.name,loc2.target,20,undefined,loc8);
		}
	}
	function out(loc2)
	{
		this._mcList.gapi.hideTooltip();
	}
	function click(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc3 != undefined)
		{
			this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(loc3);
		}
	}
}
