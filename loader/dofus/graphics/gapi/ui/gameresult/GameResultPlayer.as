class dofus.graphics.gapi.ui.gameresult.GameResultPlayer extends ank.gapi.core.UIBasicComponent
{
	function GameResultPlayer()
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
		this._oItems = var4;
		if(var2)
		{
			switch(var4.type)
			{
				default:
					if(var0 === "player")
					{
						break;
					}
				case "monster":
				case "taxcollector":
			}
			this._lblName.text = var4.name;
			if(_global.isNaN(var4.xp))
			{
				this._pbXP._visible = false;
			}
			else
			{
				this._pbXP._visible = true;
				this._pbXP.minimum = var4.minxp;
				this._pbXP.maximum = var4.maxxp;
				this._pbXP.value = var4.xp;
			}
			this._lblWinXP.text = !_global.isNaN(var4.winxp)?var4.winxp:"";
			this._lblGuildXP.text = !_global.isNaN(var4.guildxp)?var4.guildxp:"";
			this._lblMountXP.text = !_global.isNaN(var4.mountxp)?var4.mountxp:"";
			this._lblKama.text = !_global.isNaN(var4.kama)?var4.kama:"";
			this._lblLevel.text = var4.level;
			this._mcDeadHead._visible = var4.bDead;
			this.createEmptyMovieClip("_mcItems",10);
			var var5 = false;
			var4.items.sortOn(["_itemLevel","_itemName"],Array.DESCENDING | Array.NUMERIC);
			var var6 = var4.items.length;
			while((var6 = var6 - 1) >= 0)
			{
				var var7 = this._mcItemPlacer._x + 24 * var6;
				if(var7 < this._mcItemPlacer._x + this._mcItemPlacer._width)
				{
					var var8 = var4.items[var6];
					var var9 = this._mcItems.attachMovie("Container","_ctrItem" + var6,var6,{_x:var7,_y:this._mcItemPlacer._y + 1});
					var9.setSize(18,18);
					var9.addEventListener("over",this);
					var9.addEventListener("out",this);
					var9.addEventListener("click",this);
					var9.enabled = true;
					var9.margin = 0;
					var9.contentData = var8;
				}
				else
				{
					var5 = true;
				}
			}
			this._ldrAllDrop._visible = var5;
		}
		else if(this._lblName.text != undefined)
		{
			this._pbXP._visible = false;
			this._lblName.text = "";
			this._pbXP.minimum = 0;
			this._pbXP.maximum = 100;
			this._pbXP.value = random(99);
			this._lblWinXP.text = "";
			this._lblKama.text = "";
			this._mcDeadHead._visible = false;
			this._mcItems.removeMovieClip();
			this._ldrAllDrop._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcItemPlacer._alpha = 0;
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
		this._pbXP.enabled = true;
		this._pbXP.addEventListener("over",this);
		this._pbXP.addEventListener("out",this);
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
			case this._pbXP:
				this._mcList.gapi.showTooltip(this._oItems.xp + " / " + this._oItems.maxxp,var2.target,20);
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
