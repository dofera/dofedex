class dofus.graphics.gapi.controls.craftviewer.CraftViewerCraftItem extends ank.gapi.core.UIBasicComponent
{
	function CraftViewerCraftItem()
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
		this._oItem = loc4;
		if(loc2)
		{
			this._ctrItemIcon.contentData = loc4.craftItem;
			this._ctrItemIcon._visible = true;
			this._lblItemName.text = loc4.craftItem.name + " (" + this._mcList._parent.api.lang.getText("LEVEL_SMALL") + " " + loc4.craftItem.level + ")";
			if((var loc0 = loc4.difficulty) !== 1)
			{
				switch(null)
				{
					case 2:
						this._lblItemName.styleName = "GreenLeftSmallBoldLabel";
						break;
					case 3:
						this._lblItemName.styleName = "RedLeftSmallBoldLabel";
				}
			}
			else
			{
				this._lblItemName.styleName = "DarkGrayLeftSmallLabel";
			}
			this._mcTooltip.onRollOver = function()
			{
				this._parent.onTooltipRollOver();
			};
			this._mcTooltip.onRollOut = function()
			{
				this._parent.onTooltipRollOut();
			};
			this._mcTooltip.onRelease = function()
			{
				this._parent.click({target:{_name:"_lblItemIcon"}});
			};
			if(loc4.skill != undefined)
			{
				this._lblSkill.text = "(" + loc4.skill.description + " " + this._mcList._parent.api.lang.getText("ON") + " " + loc4.skill.interactiveObject + ")";
			}
			var loc5 = loc4.items;
			var loc6 = loc5.length;
			var loc7 = 0;
			while(loc7 < loc6)
			{
				var loc8 = loc5[loc7];
				this["_ctr" + loc7]._visible = true;
				this["_ctr" + loc7].contentData = loc8;
				this["_lblPlus" + loc7]._visible = true;
				loc7 = loc7 + 1;
			}
			var loc9 = loc6;
			while(loc9 < 8)
			{
				this["_ctr" + loc9]._visible = false;
				this["_lblPlus" + loc9]._visible = false;
				loc9 = loc9 + 1;
			}
		}
		else if(this._lblItemName.text != undefined)
		{
			this._ctrItemIcon.contentData = "";
			this._ctrItemIcon._visible = false;
			this._lblItemName.text = "";
			this._lblSkill.text = "";
			var loc10 = 0;
			while(loc10 < 8)
			{
				this["_ctr" + loc10]._visible = false;
				this["_lblPlus" + loc10]._visible = false;
				loc10 = loc10 + 1;
			}
		}
	}
	function init()
	{
		super.init(false);
		this._ctrItemIcon._visible = false;
		var loc3 = 0;
		while(loc3 < 8)
		{
			this["_ctr" + loc3]._visible = this["_lblPlus" + loc3]._visible = false;
			loc3 = loc3 + 1;
		}
		this.addToQueue({object:this,method:this.addListeners});
	}
	function size()
	{
		super.size();
	}
	function addListeners()
	{
		var loc2 = 0;
		while(loc2 < 8)
		{
			this["_ctr" + loc2].addEventListener("over",this);
			this["_ctr" + loc2].addEventListener("out",this);
			this["_ctr" + loc2].addEventListener("click",this);
			loc2 = loc2 + 1;
		}
		this._ctrItemIcon.addEventListener("click",this);
	}
	function setContainerContentData(loc2, loc3)
	{
		this["_ctr" + loc2].contentData = loc3;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_ctrItemIcon":
			case "_lblItemIcon":
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && this._oItem != undefined)
				{
					this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(this._oItem.craftItem,"","=");
					var loc3 = 0;
					while(loc3 < this._oItem.items.length)
					{
						var loc4 = this._oItem.items[loc3];
						this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(loc4,loc4.Quantity + "x",loc3 >= this._oItem.items.length - 1?"":"+");
						loc3 = loc3 + 1;
					}
				}
				else
				{
					this._mcList._parent.craftItem(this._ctrItemIcon.contentData);
				}
				break;
			default:
				var loc5 = loc2.target.contentData;
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc5 != undefined)
				{
					this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(loc5);
					break;
				}
				this._mcList._parent.craftItem(loc5);
				break;
		}
	}
	function onTooltipRollOver()
	{
		var loc2 = "";
		switch(this._oItem.difficulty)
		{
			case 1:
				loc2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY1");
				break;
			case 2:
				loc2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY2");
				break;
			default:
				if(loc0 !== 3)
				{
					break;
				}
				loc2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY3");
				break;
		}
		this._mcList._parent.gapi.showTooltip(loc2,this._mcTooltip,15);
	}
	function onTooltipRollOut()
	{
		this._mcList._parent.gapi.hideTooltip();
	}
	function over(loc2)
	{
		var loc3 = loc2.target.contentData;
		this._mcList._parent.gapi.showTooltip("x" + loc3.Quantity + " - " + loc3.name,loc2.target,-20);
	}
	function out(loc2)
	{
		this._mcList._parent.gapi.hideTooltip();
	}
}
