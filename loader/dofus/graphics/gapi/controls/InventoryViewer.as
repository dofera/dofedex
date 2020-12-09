class dofus.graphics.gapi.controls.InventoryViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "InventoryViewer";
	static var FILTER_ID_EQUIPEMENT = 0;
	static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	static var FILTER_ID_NONEQUIPEMENT = 1;
	static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	static var FILTER_ID_RESSOURECES = 2;
	static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	var _bAutoFilter = true;
	var _bFilterAtStart = true;
	var _nSelectedTypeID = 0;
	var _nLastProviderLen = 0;
	var _nLastFilterID = -1;
	function InventoryViewer()
	{
		super();
	}
	function __set__dataProvider(§\x10\x14§)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		if(this.initialized)
		{
			this.modelChanged();
		}
		return this.__get__dataProvider();
	}
	function __get__dataProvider()
	{
		return this._eaDataProvider;
	}
	function __set__kamasProvider(§\x1e\x19\n§)
	{
		var2.removeEventListener("kamaChanged",this);
		this._oKamasProvider = var2;
		var2.addEventListener("kamaChanged",this);
		if(this.initialized)
		{
			this.kamaChanged();
		}
		return this.__get__kamasProvider();
	}
	function __set__autoFilter(§\x1c\f§)
	{
		this._bAutoFilter = var2;
		return this.__get__autoFilter();
	}
	function __set__filterAtStart(§\x1a\t§)
	{
		this._bFilterAtStart = var2;
		return this.__get__filterAtStart();
	}
	function __get__currentFilterID()
	{
		return this._nCurrentFilterID;
	}
	function __get__customInventoryFilter()
	{
		return this._iifFilter;
	}
	function __set__customInventoryFilter(§\r\x05§)
	{
		this._iifFilter = var2;
		if(this.initialized)
		{
			this.modelChanged();
		}
		return this.__get__customInventoryFilter();
	}
	function __get__selectedItem()
	{
		return this._oDataViewer.selectedIndex;
	}
	function setFilter(§\x05\x10§)
	{
		if(var2 == this._nCurrentFilterID)
		{
			return undefined;
		}
		if((var var0 = var2) !== dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT)
		{
			if(var0 !== dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT)
			{
				if(var0 === dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES)
				{
					this.click({target:this._btnFilterRessoureces});
					this._btnFilterRessoureces.selected = true;
				}
			}
			else
			{
				this.click({target:this._btnFilterNonEquipement});
				this._btnFilterNonEquipement.selected = true;
			}
		}
		else
		{
			this.click({target:this._btnFilterEquipement});
			this._btnFilterEquipement.selected = true;
		}
	}
	function createChildren()
	{
		if(this._bFilterAtStart)
		{
			if(this._bAutoFilter)
			{
				this.addToQueue({object:this,method:this.setPreferedFilter});
			}
			else
			{
				this.addToQueue({object:this,method:this.setFilter,params:[this.getDefaultFilter()]});
			}
		}
	}
	function addListeners()
	{
		this._btnFilterEquipement.addEventListener("click",this);
		this._btnFilterNonEquipement.addEventListener("click",this);
		this._btnFilterRessoureces.addEventListener("click",this);
		this._btnMoreChoice.addEventListener("click",this);
		this._btnFilterEquipement.addEventListener("over",this);
		this._btnFilterNonEquipement.addEventListener("over",this);
		this._btnFilterRessoureces.addEventListener("over",this);
		this._btnMoreChoice.addEventListener("over",this);
		this._btnFilterEquipement.addEventListener("out",this);
		this._btnFilterNonEquipement.addEventListener("out",this);
		this._btnFilterRessoureces.addEventListener("out",this);
		this._btnMoreChoice.addEventListener("out",this);
		this._cbTypes.addEventListener("itemSelected",this);
	}
	function getDefaultFilter()
	{
		return dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT;
	}
	function setPreferedFilter()
	{
		var var2 = new Array({count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT},{count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT},{count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES});
		for(var k in this._eaDataProvider)
		{
			var var3 = this._eaDataProvider[k].superType;
			if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT[var3])
			{
				var2[0].count++;
			}
			if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT[var3])
			{
				var2[1].count++;
			}
			if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES[var3])
			{
				var2[2].count++;
			}
		}
		var2.sortOn("count");
		this.setFilter(var2[2].id);
	}
	function updateData()
	{
		var var2 = this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name];
		this._nSelectedTypeID = var2 != undefined?var2:0;
		var var3 = new ank.utils.
();
		var var4 = new ank.utils.
();
		var var5 = new Object();
		for(var k in this._eaDataProvider)
		{
			var var6 = this._eaDataProvider[k];
			var var7 = var6.position;
			if(var7 == -1 && this._aSelectedSuperTypes[var6.superType])
			{
				if(var6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					if(this._iifFilter == null || this._iifFilter == undefined || this._iifFilter.isItemListed(var6))
					{
						var3.push(var6);
					}
				}
				var var8 = var6.type;
				if(var5[var8] != true)
				{
					var4.push({label:this.api.lang.getItemTypeText(var8).n,id:var8});
					var5[var8] = true;
				}
			}
		}
		var4.sortOn("label");
		var4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = var4;
		this.setType(this._nSelectedTypeID);
		this._oDataViewer.dataProvider = var3;
		this.sortInventory(this._sCurrentSort);
	}
	function setType(§\x1e\x1c\x02§)
	{
		var var3 = this._cbTypes.dataProvider;
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var3[var4].id == var2)
			{
				this._cbTypes.selectedIndex = var4;
				return undefined;
			}
			var4 = var4 + 1;
		}
		this._nSelectedTypeID = 0;
		this._cbTypes.selectedIndex = this._nSelectedTypeID;
	}
	function showSearch()
	{
		var var2 = this.gapi.loadUIComponent("InventorySearch","InventorySearch",{_oDataProvider:this._oDataViewer.dataProvider});
		var2.addEventListener("select",this);
	}
	function sortInventory(§\x1e\x12\x19§)
	{
		if(!var2)
		{
			return undefined;
		}
		this._oDataViewer.dataProvider.sortOn(var2,Array.NUMERIC);
		this._sCurrentSort = var2;
		this._nLastProviderLen = this._oDataViewer.dataProvider.length;
		this._nLastFilterID = this._nCurrentFilterID;
		this._oDataViewer.modelChanged();
	}
	function modelChanged()
	{
		this.updateData();
	}
	function kamaChanged(§\x1e\x19\x18§)
	{
		if(var2.value == undefined)
		{
			this._lblKama.text = "0";
		}
		else
		{
			this._lblKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		}
	}
	function click(§\x1e\x19\x18§)
	{
		if(var2.target == this._btnMoreChoice)
		{
			var var3 = this.api.ui.createPopupMenu();
			var3.addItem(this.api.lang.getText("INVENTORY_SEARCH"),this,this.showSearch);
			var3.addItem(this.api.lang.getText("INVENTORY_DATE_SORT"),this,this.sortInventory,["_itemDateId"]);
			var3.addItem(this.api.lang.getText("INVENTORY_NAME_SORT"),this,this.sortInventory,["_itemName"]);
			var3.addItem(this.api.lang.getText("INVENTORY_TYPE_SORT"),this,this.sortInventory,["_itemType"]);
			var3.addItem(this.api.lang.getText("INVENTORY_LEVEL_SORT"),this,this.sortInventory,["_itemLevel"]);
			var3.addItem(this.api.lang.getText("INVENTORY_POD_SORT"),this,this.sortInventory,["_itemWeight"]);
			var3.addItem(this.api.lang.getText("INVENTORY_QTY_SORT"),this,this.sortInventory,["_nQuantity"]);
			var3.show(_root._xmouse,_root._ymouse);
			return undefined;
		}
		if(var2.target != this._btnSelectedFilterButton)
		{
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = var2.target;
			switch(var2.target._name)
			{
				case "_btnFilterEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
					this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT;
					break;
				case "_btnFilterNonEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
					this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT;
					break;
				case "_btnFilterRessoureces":
					this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES;
					this._lblFilter.text = this.api.lang.getText("RESSOURECES");
					this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES;
			}
			this.updateData();
		}
		else
		{
			var2.target.selected = true;
		}
	}
	function select(§\x1e\x19\x18§)
	{
		var var3 = var2.value;
		var var4 = 0;
		while(var4 < this._oDataViewer.dataProvider.length)
		{
			if(var3 == this._oDataViewer.dataProvider[var4].unicID)
			{
				this._oDataViewer.setVPosition(Math.floor(var4 / this._oDataViewer.visibleColumnCount));
				this._oDataViewer.selectedIndex = var4;
			}
			var4 = var4 + 1;
		}
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),var2.target,-20);
				break;
			case this._btnFilterNonEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),var2.target,-20);
				break;
			default:
				switch(null)
				{
					case this._btnFilterRessoureces:
						this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
						break;
					case this._btnMoreChoice:
						this.api.ui.showTooltip(this.api.lang.getText("SEARCH_AND_SORT"),var2.target,-20);
				}
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.api.ui.hideTooltip();
	}
}
