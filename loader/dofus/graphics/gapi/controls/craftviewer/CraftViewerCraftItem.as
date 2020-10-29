class dofus.graphics.gapi.controls.craftviewer.CraftViewerCraftItem extends ank.gapi.core.UIBasicComponent
{
	function CraftViewerCraftItem()
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
		this._oItem = var4;
		if(var2)
		{
			this._ctrItemIcon.contentData = var4.craftItem;
			this._ctrItemIcon._visible = true;
			this._lblItemName.text = var4.craftItem.name + " (" + this._mcList._parent.api.lang.getText("LEVEL_SMALL") + " " + var4.craftItem.level + ")";
			switch(var4.difficulty)
			{
				case 1:
					this._lblItemName.styleName = "DarkGrayLeftSmallLabel";
					break;
				case 2:
					this._lblItemName.styleName = "GreenLeftSmallBoldLabel";
					break;
				case 3:
					this._lblItemName.styleName = "RedLeftSmallBoldLabel";
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
			if(var4.skill != undefined)
			{
				this._lblSkill.text = "(" + var4.skill.description + " " + this._mcList._parent.api.lang.getText("ON") + " " + var4.skill.interactiveObject + ")";
			}
			var var5 = var4.items;
			var var6 = var5.length;
			var var7 = 0;
			while(var7 < var6)
			{
				var var8 = var5[var7];
				this["_ctr" + var7]._visible = true;
				this["_ctr" + var7].contentData = var8;
				this["_lblPlus" + var7]._visible = true;
				var7 = var7 + 1;
			}
			var var9 = var6;
			while(var9 < 8)
			{
				this["_ctr" + var9]._visible = false;
				this["_lblPlus" + var9]._visible = false;
				var9 = var9 + 1;
			}
		}
		else if(this._lblItemName.text != undefined)
		{
			this._ctrItemIcon.contentData = "";
			this._ctrItemIcon._visible = false;
			this._lblItemName.text = "";
			this._lblSkill.text = "";
			var var10 = 0;
			while(var10 < 8)
			{
				this["_ctr" + var10]._visible = false;
				this["_lblPlus" + var10]._visible = false;
				var10 = var10 + 1;
			}
		}
	}
	function init()
	{
		super.init(false);
		this._ctrItemIcon._visible = false;
		var var3 = 0;
		while(var3 < 8)
		{
			this["_ctr" + var3]._visible = this["_lblPlus" + var3]._visible = false;
			var3 = var3 + 1;
		}
		this.addToQueue({object:this,method:this.addListeners});
	}
	function size()
	{
		super.size();
	}
	function addListeners()
	{
		var var2 = 0;
		while(var2 < 8)
		{
			this["_ctr" + var2].addEventListener("over",this);
			this["_ctr" + var2].addEventListener("out",this);
			this["_ctr" + var2].addEventListener("click",this);
			var2 = var2 + 1;
		}
		this._ctrItemIcon.addEventListener("click",this);
	}
	function setContainerContentData(var2, var3)
	{
		this["_ctr" + var2].contentData = var3;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_ctrItemIcon":
			case "_lblItemIcon":
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && this._oItem != undefined)
				{
					this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(this._oItem.craftItem,"","=");
					var var3 = 0;
					while(var3 < this._oItem.items.length)
					{
						var var4 = this._oItem.items[var3];
						this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(var4,var4.Quantity + "x",var3 >= this._oItem.items.length - 1?"":"+");
						var3 = var3 + 1;
					}
				}
				else
				{
					this._mcList._parent.craftItem(this._ctrItemIcon.contentData);
				}
				break;
			default:
				var var5 = var2.target.contentData;
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && var5 != undefined)
				{
					this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(var5);
					break;
				}
				this._mcList._parent.craftItem(var5);
				break;
		}
	}
	function onTooltipRollOver()
	{
		var var2 = "";
		switch(this._oItem.difficulty)
		{
			case 1:
				var2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY1");
				break;
			case 2:
				var2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY2");
				break;
			default:
				if(var0 !== 3)
				{
					break;
				}
				var2 = this._mcList._parent.gapi.api.lang.getText("CRAFT_DIFFICULTY3");
				break;
		}
		this._mcList._parent.gapi.showTooltip(var2,this._mcTooltip,15);
	}
	function onTooltipRollOut()
	{
		this._mcList._parent.gapi.hideTooltip();
	}
	function over(var2)
	{
		var var3 = var2.target.contentData;
		this._mcList._parent.gapi.showTooltip("x" + var3.Quantity + " - " + var3.name,var2.target,-20);
	}
	function out(var2)
	{
		this._mcList._parent.gapi.hideTooltip();
	}
}
