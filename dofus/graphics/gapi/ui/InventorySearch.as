class dofus.graphics.gapi.ui.InventorySearch extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "InventorySearch";
	static var MIN_SEARCH_CHAR = 2;
	var _sDefaultText = "";
	function InventorySearch()
	{
		super();
	}
	function __set__types(loc2)
	{
		this._aTypes = loc2;
		return this.__get__types();
	}
	function __set__maxLevel(loc2)
	{
		this._nMaxLevel = loc2;
		return this.__get__maxLevel();
	}
	function __set__defaultSearch(loc2)
	{
		this._sDefaultText = loc2;
		return this.__get__defaultSearch();
	}
	function __set__oParent(loc2)
	{
		this._oParent = loc2;
		return this.__get__oParent();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.InventorySearch.CLASS_NAME);
	}
	function callClose()
	{
		this.gapi.hideTooltip();
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.generateIndexes();
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnView.addEventListener("click",this);
		this._tiSearch.addEventListener("change",this);
		this._lstItems.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("BIGSTORE_SEARCH");
		this._lblSearch.text = this.api.lang.getText("INVENTORY_SEARCH_ITEM_NAME",[dofus.graphics.gapi.ui.InventorySearch.MIN_SEARCH_CHAR]);
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnView.label = this.api.lang.getText("BIGSTORE_SEARCH_VIEW");
		this._tiSearch.text = this._sDefaultText;
		this._tiSearch.setFocus();
	}
	function generateIndexes()
	{
		var loc2 = new Object();
		for(var k in this._aTypes)
		{
			loc2[this._aTypes[k]] = true;
		}
		var loc3 = this._oDataProvider;
		this._aItems = new Array();
		for(var k in loc3)
		{
			var loc4 = loc3[k].name;
			var loc5 = loc3[k].unicID;
			this._aItems.push({id:loc5,name:loc4.toUpperCase()});
		}
	}
	function searchItem(loc2)
	{
		var loc3 = loc2.split(" ");
		var loc4 = new ank.utils.();
		var loc5 = new Object();
		var loc6 = 0;
		var loc7 = 0;
		while(loc7 < this._aItems.length)
		{
			var loc8 = this._aItems[loc7];
			var loc9 = this.searchWordsInName(loc3,loc8.name,loc6);
			if(loc9 != 0)
			{
				loc5[loc8.id] = loc9;
				loc6 = loc9;
			}
			loc7 = loc7 + 1;
		}
		for(var k in loc5)
		{
			if(loc5[k] >= loc6)
			{
				loc4.push(new dofus.datacenter.(0,Number(k)));
			}
		}
		this._lstItems.dataProvider = loc4;
		this._lblSearchCount.text = loc4.length != 0?loc4.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",loc4 < 2):this.api.lang.getText("NO_INVENTORY_SEARCH_RESULT");
		this._btnView.enabled = false;
	}
	function searchWordsInName(loc2, loc3, loc4)
	{
		var loc5 = 0;
		var loc6 = loc2.length;
		while(loc6 >= 0)
		{
			var loc7 = loc2[loc6];
			if(loc3.indexOf(loc7) != -1)
			{
				loc5 = loc5 + 1;
			}
			else if(loc5 + loc6 < loc4)
			{
				return 0;
			}
			loc6 = loc6 - 1;
		}
		return loc5;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnView":
				var loc3 = this._lstItems.selectedItem;
				this.dispatchEvent({type:"select",value:loc3.unicID});
				this.callClose();
		}
	}
	function change(loc2)
	{
		var loc3 = new ank.utils.(this._tiSearch.text).trim().toString();
		if(loc3.length >= dofus.graphics.gapi.ui.InventorySearch.MIN_SEARCH_CHAR)
		{
			this.searchItem(loc3.toUpperCase());
		}
		else
		{
			this._lstItems.dataProvider = new ank.utils.();
			if(this._lblSearchCount.text != undefined)
			{
				this._lblSearchCount.text = "";
			}
		}
		this._oParent.defaultSearch = this._tiSearch.text;
	}
	function itemSelected(loc2)
	{
		this._btnView.enabled = true;
	}
}
