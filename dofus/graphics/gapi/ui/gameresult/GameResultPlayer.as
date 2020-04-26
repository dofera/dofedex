class dofus.graphics.gapi.ui.gameresult.GameResultPlayer extends ank.gapi.core.UIBasicComponent
{
	function GameResultPlayer()
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
		this._oItems = loc4;
		if(loc2)
		{
			switch(loc4.type)
			{
				default:
					if(loc0 === "player")
					{
						break;
					}
				case "monster":
				case "taxcollector":
			}
			this._lblName.text = loc4.name;
			if(_global.isNaN(loc4.xp))
			{
				this._pbXP._visible = false;
			}
			else
			{
				this._pbXP._visible = true;
				this._pbXP.minimum = loc4.minxp;
				this._pbXP.maximum = loc4.maxxp;
				this._pbXP.value = loc4.xp;
			}
			this._lblWinXP.text = !_global.isNaN(loc4.winxp)?loc4.winxp:"";
			this._lblGuildXP.text = !_global.isNaN(loc4.guildxp)?loc4.guildxp:"";
			this._lblMountXP.text = !_global.isNaN(loc4.mountxp)?loc4.mountxp:"";
			this._lblKama.text = !_global.isNaN(loc4.kama)?loc4.kama:"";
			this._lblLevel.text = loc4.level;
			this._mcDeadHead._visible = loc4.bDead;
			this.createEmptyMovieClip("_mcItems",10);
			var loc5 = false;
			loc4.items.sortOn(["_itemLevel","_itemName"],Array.DESCENDING | Array.NUMERIC);
			var loc6 = loc4.items.length;
			while((loc6 = loc6 - 1) >= 0)
			{
				var loc7 = this._mcItemPlacer._x + 24 * loc6;
				if(loc7 < this._mcItemPlacer._x + this._mcItemPlacer._width)
				{
					var loc8 = loc4.items[loc6];
					var loc9 = this._mcItems.attachMovie("Container","_ctrItem" + loc6,loc6,{_x:loc7,_y:this._mcItemPlacer._y + 1});
					loc9.setSize(18,18);
					loc9.addEventListener("over",this);
					loc9.addEventListener("out",this);
					loc9.addEventListener("click",this);
					loc9.enabled = true;
					loc9.margin = 0;
					loc9.contentData = loc8;
				}
				else
				{
					loc5 = true;
				}
			}
			this._ldrAllDrop._visible = loc5;
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
		var loc2 = this;
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
			case this._pbXP:
				this._mcList.gapi.showTooltip(this._oItems.xp + " / " + this._oItems.maxxp,loc2.target,20);
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
