class dofus.graphics.gapi.ui.InventorySearch extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "InventorySearch";
	static var MIN_SEARCH_CHAR = 2;
	var _sDefaultText = "";
	function InventorySearch()
	{
		super();
	}
	function __set__types(var2)
	{
		this._aTypes = var2;
		return this.__get__types();
	}
	function __set__maxLevel(var2)
	{
		this._nMaxLevel = var2;
		return this.__get__maxLevel();
	}
	function __set__defaultSearch(var2)
	{
		this._sDefaultText = var2;
		return this.__get__defaultSearch();
	}
	function __set__oParent(var2)
	{
		this._oParent = var2;
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
		var var2 = new Object();
		for(var k in this._aTypes)
		{
			var2[this._aTypes[k]] = true;
		}
		var var3 = this._oDataProvider;
		this._aItems = new Array();
		for(var k in var3)
		{
			var var4 = var3[k].name;
			var var5 = var3[k].unicID;
			this._aItems.push({id:var5,name:var4.toUpperCase()});
		}
	}
	function searchItem(var2)
	{
		var var3 = var2.split(" ");
		var var4 = new ank.utils.();
		var var5 = new Object();
		var var6 = 0;
		var var7 = 0;
		while(var7 < this._aItems.length)
		{
			var var8 = this._aItems[var7];
			var var9 = this.searchWordsInName(var3,var8.name,var6);
			if(var9 != 0)
			{
				var5[var8.id] = var9;
				var6 = var9;
			}
			var7 = var7 + 1;
		}
		for(var k in var5)
		{
			if(var5[k] >= var6)
			{
				var4.push(new dofus.datacenter.(0,Number(k)));
			}
		}
		this._lstItems.dataProvider = var4;
		this._lblSearchCount.text = var4.length != 0?var4.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",var4 < 2):this.api.lang.getText("NO_INVENTORY_SEARCH_RESULT");
		this._btnView.enabled = false;
	}
	function searchWordsInName(var2, var3, var4)
	{
		var var5 = 0;
		var var6 = var2.length;
		while(var6 >= 0)
		{
			var var7 = var2[var6];
			if(var3.indexOf(var7) != -1)
			{
				var5 = var5 + 1;
			}
			else if(var5 + var6 < var4)
			{
				return 0;
			}
			var6 = var6 - 1;
		}
		return var5;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnView":
				var var3 = this._lstItems.selectedItem;
				this.dispatchEvent({type:"select",value:var3.unicID});
				this.callClose();
		}
	}
	function change(var2)
	{
		var var3 = new ank.utils.(this._tiSearch.text).trim().toString();
		if(var3.length >= dofus.graphics.gapi.ui.InventorySearch.MIN_SEARCH_CHAR)
		{
			this.searchItem(var3.toUpperCase());
		}
		else
		{
			this._lstItems.dataProvider = new ank.utils.();
			if(this._lblSearchCount.text != undefined)
			{
				this._lblSearchCount.text = "";
			}
		}
		this._oParent.defaultSearch = this._tiSearch.text;
	}
	function itemSelected(var2)
	{
		this._btnView.enabled = true;
	}
}
