class dofus.graphics.gapi.ui.gameresult.GameResultPlayerPVP extends ank.gapi.core.UIBasicComponent
{
	function GameResultPlayerPVP()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		var4.items.sortOn("_itemLevel",Array.DESCENDING | Array.NUMERIC);
		this._oItems = var4;
		var var5 = this._mcList._parent.api;
		if(var2)
		{
			if((var var0 = var4.type) !== "monster")
			{
				switch(null)
				{
					case "taxcollector":
					case "player":
				}
			}
			this._lblName.text = var4.name;
			if(var4.rank == 0 && !var5.datacenter.Basics.aks_current_server.isHardcore())
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
				if(var5.datacenter.Basics.aks_current_server.isHardcore())
				{
					if(_global.isNaN(var4.minxp))
					{
						this._pbDisgrace._visible = false;
					}
					this._pbDisgrace.minimum = var4.minxp;
					this._pbDisgrace.maximum = var4.maxxp;
					this._pbDisgrace.value = var4.xp;
				}
				else
				{
					this._pbDisgrace.minimum = var4.mindisgrace;
					this._pbDisgrace.maximum = var4.maxdisgrace;
					this._pbDisgrace.value = var4.disgrace;
				}
				this._pbHonour.minimum = var4.minhonour;
				this._pbHonour.maximum = var4.maxhonour;
				this._pbHonour.value = var4.honour;
			}
			this._lblWinHonour.text = !_global.isNaN(var4.winhonour)?var4.winhonour:"";
			if(!var5.datacenter.Basics.aks_current_server.isHardcore())
			{
				this._lblWinDisgrace.text = !_global.isNaN(var4.windisgrace)?var4.windisgrace:"";
			}
			else
			{
				this._lblWinDisgrace.text = !_global.isNaN(var4.winxp)?var4.winxp:"";
			}
			this._lblRank.text = !_global.isNaN(var4.rank)?var4.rank:"";
			this._lblKama.text = !_global.isNaN(var4.kama)?var4.kama:"";
			this._lblLevel.text = var4.level;
			this._mcDeadHead._visible = var4.bDead;
			this.createEmptyMovieClip("_mcItems",10);
			var var6 = false;
			var var7 = var4.items.length;
			while((var7 = var7 - 1) >= 0)
			{
				var var8 = this._mcItemPlacer._x + 24 * var7;
				if(var8 < this._mcItemPlacer._x + this._mcItemPlacer._width)
				{
					var var9 = var4.items[var7];
					var var10 = this._mcItems.attachMovie("Container","_ctrItem" + var7,var7,{_x:var8,_y:this._mcItemPlacer._y + 1});
					var10.setSize(18,18);
					var10.addEventListener("over",this);
					var10.addEventListener("out",this);
					var10.addEventListener("click",this);
					var10.enabled = true;
					var10.margin = 0;
					var10.contentData = var9;
				}
				else
				{
					var6 = true;
				}
			}
			this._ldrAllDrop._visible = var6;
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
		var var2 = this;
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
	function over(var2)
	{
		switch(var2.target)
		{
			case this._ldrAllDrop:
				var var3 = this._oItems.items;
				var var4 = "";
				var var5 = 0;
				while(var5 < var3.length)
				{
					var var6 = var3[var5];
					if(var5 > 0)
					{
						var4 = var4 + "\n";
					}
					var4 = var4 + (var6.Quantity + " x " + var6.name);
					var5 = var5 + 1;
				}
				if(var4 != "")
				{
					this._mcList.gapi.showTooltip(var4,var2.target,30);
				}
				break;
			case this._pbHonour:
			case this._pbDisgrace:
				this._mcList.gapi.showTooltip(var2.target.value + " / " + var2.target.maximum,var2.target,20);
				break;
			default:
				var var7 = var2.target.contentData;
				var var8 = var7.style + "ToolTip";
				this._mcList.gapi.showTooltip(var7.Quantity + " x " + var7.name,var2.target,20,undefined,var8);
		}
	}
	function out(var2)
	{
		this._mcList.gapi.hideTooltip();
	}
	function click(var2)
	{
		var var3 = var2.target.contentData;
		if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && var3 != undefined)
		{
			this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(var3);
		}
	}
}
