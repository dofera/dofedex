class dofus.graphics.gapi.controls.ItemSetViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemSetViewer";
	static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
	function ItemSetViewer()
	{
		super();
	}
	function __set__itemSet(var2)
	{
		this.addToQueue({object:this,method:function(var2)
		{
			this._oItemSet = var2;
			if(this.initialized)
			{
				this.updateData();
			}
		},params:[var2]});
		return this.__get__itemSet();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ItemSetViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		var var2 = 1;
		while(var2 <= 8)
		{
			var var3 = this["_ctr" + var2];
			var3.addEventListener("over",this);
			var3.addEventListener("out",this);
			var2 = var2 + 1;
		}
	}
	function initTexts()
	{
		this._lblEffects.text = this.api.lang.getText("ITEMSET_EFFECTS");
		this._lblItems.text = this.api.lang.getText("ITEMSET_EQUIPED_ITEMS");
	}
	function updateData()
	{
		if(this._oItemSet != undefined)
		{
			var var2 = this._oItemSet.items;
			this._winBg.title = this._oItemSet.name;
			var var3 = this._oItemSet.itemCount != undefined?this._oItemSet.itemCount:8;
			var var4 = 0;
			while(var4 < var3)
			{
				var var5 = var2[var4];
				var var6 = this["_ctr" + (var4 + 1)];
				var6._visible = true;
				var6.contentData = var5.item;
				var6.borderRenderer = !var5.isEquiped?"ItemSetViewerItemBorder":"ItemSetViewerItemBorderNone";
				var4 = var4 + 1;
			}
			this._lstEffects.dataProvider = this._oItemSet.effects;
			var var7 = var3 + 1;
			while(var7 <= 8)
			{
				var var8 = this["_ctr" + var7];
				var8._visible = false;
				var7 = var7 + 1;
			}
			this._visible = true;
		}
		else
		{
			ank.utils.Logger.err("[ItemSetViewer] le set n\'est pas défini");
			this._visible = false;
		}
	}
	function click(var2)
	{
		if((var var0 = var2.target._name) === "_btnClose")
		{
			this.dispatchEvent({type:"close"});
		}
	}
	function over(var2)
	{
		switch(var2.target._name)
		{
			default:
				switch(null)
				{
					case "_ctr4":
					case "_ctr5":
					case "_ctr6":
					case "_ctr7":
					case "_ctr8":
				}
			case "_ctr1":
			case "_ctr2":
			case "_ctr3":
		}
		var var3 = var2.target.contentData;
		this.gapi.showTooltip(var3.name,var2.target,-20,undefined,var3.style + "ToolTip");
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
