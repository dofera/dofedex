class dofus.graphics.gapi.ui.BigStoreSearch extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BigStoreSearch";
	var _sDefaultText = "";
	function BigStoreSearch()
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
		var var2 = new Object();
		for(var k in this._aTypes)
		{
			var2[this._aTypes[k]] = true;
		}
		var var3 = this.api.lang.getItemUnics();
		this._aItems = new Array();
		for(var k in var3)
		{
			var var4 = var3[k];
			if(!(var4.ep == undefined || var4.ep > this.api.datacenter.Basics.aks_current_regional_version))
			{
				if(var2[var4.t] && (var4.h != true && var4.l <= this._nMaxLevel))
				{
					var var5 = var4.n;
					this._aItems.push({id:k,name:var5.toUpperCase()});
				}
			}
		}
	}
	function searchItem(var2)
	{
		var var3 = var2.split(" ");
		var var4 = new ank.utils.();
		var var5 = new Object();
		var var6 = 0;
		while(var6 < this._aItems.length)
		{
			var var7 = this._aItems[var6];
			var var8 = this.searchWordsInName(var3,var7.name);
			if(var8)
			{
				var5[var7.id] = true;
			}
			var6 = var6 + 1;
		}
		§§enumerate(var5);
		while((var var0 = §§enumeration()) != null)
		{
			if(var5[k] == true)
			{
				var4.push(new dofus.datacenter.(0,Number(k)));
			}
		}
		this._lstItems.dataProvider = var4;
		this._lblSearchCount.text = var4.length == 0?this.api.lang.getText("NO_BIGSTORE_SEARCH_RESULT"):var4.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",var4 < 2);
		this._btnView.enabled = false;
	}
	function searchWordsInName(var2, var3)
	{
		var var4 = var2.length - 1;
		while(var4 >= 0)
		{
			var var5 = var2[var4];
			var var6 = var3.indexOf(var5);
			if(var6 != -1)
			{
				var3 = var3.substr(0,var6) + var3.substr(var6 + var5.length);
				var4 = var4 - 1;
				continue;
			}
			return false;
		}
		return true;
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
				this.api.network.Exchange.bigStoreSearch(var3.type,var3.unicID);
		}
	}
	function change(var2)
	{
		var var3 = new ank.utils.(this._tiSearch.text).trim().toString();
		if(var3.length >= 2)
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
