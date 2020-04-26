class dofus.graphics.gapi.controls.ItemSetViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemSetViewer";
	static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
	function ItemSetViewer()
	{
		super();
	}
	function __set__itemSet(loc2)
	{
		this.addToQueue({object:this,method:function(loc2)
		{
			this._oItemSet = loc2;
			if(this.initialized)
			{
				this.updateData();
			}
		},params:[loc2]});
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
		var loc2 = 1;
		while(loc2 <= 8)
		{
			var loc3 = this["_ctr" + loc2];
			loc3.addEventListener("over",this);
			loc3.addEventListener("out",this);
			loc2 = loc2 + 1;
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
			var loc2 = this._oItemSet.items;
			this._winBg.title = this._oItemSet.name;
			var loc3 = this._oItemSet.itemCount != undefined?this._oItemSet.itemCount:8;
			var loc4 = 0;
			while(loc4 < loc3)
			{
				var loc5 = loc2[loc4];
				var loc6 = this["_ctr" + (loc4 + 1)];
				loc6._visible = true;
				loc6.contentData = loc5.item;
				loc6.borderRenderer = !loc5.isEquiped?"ItemSetViewerItemBorder":"ItemSetViewerItemBorderNone";
				loc4 = loc4 + 1;
			}
			this._lstEffects.dataProvider = this._oItemSet.effects;
			var loc7 = loc3 + 1;
			while(loc7 <= 8)
			{
				var loc8 = this["_ctr" + loc7];
				loc8._visible = false;
				loc7 = loc7 + 1;
			}
			this._visible = true;
		}
		else
		{
			ank.utils.Logger.err("[ItemSetViewer] le set n\'est pas défini");
			this._visible = false;
		}
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnClose")
		{
			this.dispatchEvent({type:"close"});
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
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
		var loc3 = loc2.target.contentData;
		this.gapi.showTooltip(loc3.name,loc2.target,-20,undefined,loc3.style + "ToolTip");
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
