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
	function __set__dataProvider(loc2)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = loc2;
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
	function __set__kamasProvider(loc2)
	{
		loc2.removeEventListener("kamaChanged",this);
		this._oKamasProvider = loc2;
		loc2.addEventListener("kamaChanged",this);
		if(this.initialized)
		{
			this.kamaChanged();
		}
		return this.__get__kamasProvider();
	}
	function __set__autoFilter(loc2)
	{
		this._bAutoFilter = loc2;
		return this.__get__autoFilter();
	}
	function __set__filterAtStart(loc2)
	{
		this._bFilterAtStart = loc2;
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
	function __set__customInventoryFilter(loc2)
	{
		this._iifFilter = loc2;
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
	function setFilter(loc2)
	{
		if(loc2 == this._nCurrentFilterID)
		{
			return undefined;
		}
		if((var loc0 = loc2) !== dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT)
		{
			if(loc0 !== dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT)
			{
				if(loc0 === dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES)
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
		var loc2 = new Array({count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT},{count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT},{count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES});
		for(var loc3 in this._eaDataProvider)
		{
			if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT[loc3])
			{
				loc2[0].count++;
			}
			if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT[loc3])
			{
				loc2[1].count++;
			}
			if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES[loc3])
			{
				loc2[2].count++;
			}
		}
		loc2.sortOn("count");
		this.setFilter(loc2[2].id);
	}
	function updateData()
	{
		var loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name];
		this._nSelectedTypeID = loc2 != undefined?loc2:0;
		var loc3 = new ank.utils.();
		var loc4 = new ank.utils.();
		var loc5 = new Object();
		for(var loc6 in this._eaDataProvider)
		{
			var loc7 = loc6.position;
			if(loc7 == -1 && this._aSelectedSuperTypes[loc6.superType])
			{
				if(loc6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					if(this._iifFilter == null || this._iifFilter == undefined || this._iifFilter.isItemListed(loc6))
					{
						loc3.push(loc6);
					}
				}
				var loc8 = loc6.type;
				if(loc5[loc8] != true)
				{
					loc4.push({label:this.api.lang.getItemTypeText(loc8).n,id:loc8});
					loc5[loc8] = true;
				}
			}
		}
		loc4.sortOn("label");
		loc4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = loc4;
		this.setType(this._nSelectedTypeID);
		this._oDataViewer.dataProvider = loc3;
		this.sortInventory(this._sCurrentSort);
	}
	function setType(loc2)
	{
		var loc3 = this._cbTypes.dataProvider;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			if(loc3[loc4].id == loc2)
			{
				this._cbTypes.selectedIndex = loc4;
				return undefined;
			}
			loc4 = loc4 + 1;
		}
		this._nSelectedTypeID = 0;
		this._cbTypes.selectedIndex = this._nSelectedTypeID;
	}
	function showSearch()
	{
		var loc2 = this.gapi.loadUIComponent("InventorySearch","InventorySearch",{_oDataProvider:this._oDataViewer.dataProvider});
		loc2.addEventListener("select",this);
	}
	function sortInventory(loc2)
	{
		if(!loc2)
		{
			return undefined;
		}
		this._oDataViewer.dataProvider.sortOn(loc2,Array.NUMERIC);
		this._sCurrentSort = loc2;
		this._nLastProviderLen = this._oDataViewer.dataProvider.length;
		this._nLastFilterID = this._nCurrentFilterID;
		this._oDataViewer.modelChanged();
	}
	function modelChanged()
	{
		this.updateData();
	}
	function kamaChanged(loc2)
	{
		if(loc2.value == undefined)
		{
			this._lblKama.text = "0";
		}
		else
		{
			this._lblKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		}
	}
	function click(loc2)
	{
		if(loc2.target == this._btnMoreChoice)
		{
			var loc3 = this.api.ui.createPopupMenu();
			loc3.addItem(this.api.lang.getText("INVENTORY_SEARCH"),this,this.showSearch);
			loc3.addItem(this.api.lang.getText("INVENTORY_DATE_SORT"),this,this.sortInventory,["_itemDateId"]);
			loc3.addItem(this.api.lang.getText("INVENTORY_NAME_SORT"),this,this.sortInventory,["_itemName"]);
			loc3.addItem(this.api.lang.getText("INVENTORY_TYPE_SORT"),this,this.sortInventory,["_itemType"]);
			loc3.addItem(this.api.lang.getText("INVENTORY_LEVEL_SORT"),this,this.sortInventory,["_itemLevel"]);
			loc3.addItem(this.api.lang.getText("INVENTORY_POD_SORT"),this,this.sortInventory,["_itemWeight"]);
			loc3.addItem(this.api.lang.getText("INVENTORY_QTY_SORT"),this,this.sortInventory,["_nQuantity"]);
			loc3.show(_root._xmouse,_root._ymouse);
			return undefined;
		}
		if(loc2.target != this._btnSelectedFilterButton)
		{
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = loc2.target;
			if((var loc0 = loc2.target._name) !== "_btnFilterEquipement")
			{
				switch(null)
				{
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
			}
			else
			{
				this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT;
				this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
				this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT;
			}
			this.updateData();
		}
		else
		{
			loc2.target.selected = true;
		}
	}
	function select(loc2)
	{
		var loc3 = loc2.value;
		var loc4 = 0;
		while(loc4 < this._oDataViewer.dataProvider.length)
		{
			if(loc3 == this._oDataViewer.dataProvider[loc4].unicID)
			{
				this._oDataViewer.setVPosition(Math.floor(loc4 / this._oDataViewer.visibleColumnCount));
				this._oDataViewer.selectedIndex = loc4;
			}
			loc4 = loc4 + 1;
		}
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),loc2.target,-20);
				break;
			case this._btnFilterNonEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),loc2.target,-20);
				break;
			case this._btnFilterRessoureces:
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),loc2.target,-20);
				break;
			default:
				if(loc0 !== this._btnMoreChoice)
				{
					break;
				}
				this.api.ui.showTooltip(this.api.lang.getText("SEARCH_AND_SORT"),loc2.target,-20);
				break;
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
}
