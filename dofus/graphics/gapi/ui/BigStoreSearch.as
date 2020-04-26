class dofus.graphics.gapi.ui.BigStoreSearch extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BigStoreSearch";
	var _sDefaultText = "";
	function BigStoreSearch()
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
		super.init(false,dofus.graphics.gapi.ui.BigStoreSearch.CLASS_NAME);
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
		this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_ITEM_NAME");
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
		var loc3 = this.api.lang.getItemUnics();
		this._aItems = new Array();
		for(var k in loc3)
		{
			var loc4 = loc3[k];
			if(!(loc4.ep == undefined || loc4.ep > this.api.datacenter.Basics.aks_current_regional_version))
			{
				if(loc2[loc4.t] && (loc4.h != true && loc4.l <= this._nMaxLevel))
				{
					var loc5 = loc4.n;
					this._aItems.push({id:k,name:loc5.toUpperCase()});
				}
			}
		}
	}
	function searchItem(loc2)
	{
		var loc3 = loc2.split(" ");
		var loc4 = new ank.utils.();
		var loc5 = new Object();
		var loc6 = 0;
		while(loc6 < this._aItems.length)
		{
			var loc7 = this._aItems[loc6];
			var loc8 = this.searchWordsInName(loc3,loc7.name);
			if(loc8)
			{
				loc5[loc7.id] = true;
			}
			loc6 = loc6 + 1;
		}
		for(var k in loc5)
		{
			if(loc5[k] == true)
			{
				loc4.push(new dofus.datacenter.(0,Number(k)));
			}
		}
		this._lstItems.dataProvider = loc4;
		this._lblSearchCount.text = loc4.length == 0?this.api.lang.getText("NO_BIGSTORE_SEARCH_RESULT"):loc4.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",loc4 < 2);
		this._btnView.enabled = false;
	}
	function searchWordsInName(loc2, loc3)
	{
		var loc4 = loc2.length - 1;
		while(loc4 >= 0)
		{
			var loc5 = loc2[loc4];
			var loc6 = loc3.indexOf(loc5);
			if(loc6 != -1)
			{
				loc3 = loc3.substr(0,loc6) + loc3.substr(loc6 + loc5.length);
				loc4 = loc4 - 1;
				continue;
			}
			return false;
		}
		return true;
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
				this.api.network.Exchange.bigStoreSearch(loc3.type,loc3.unicID);
		}
	}
	function change(loc2)
	{
		var loc3 = new ank.utils.(this._tiSearch.text).trim().toString();
		if(loc3.length >= 2)
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
