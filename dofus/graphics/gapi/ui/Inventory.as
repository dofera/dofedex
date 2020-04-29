class dofus.graphics.gapi.ui.Inventory extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Inventory";
	static var CONTAINER_BY_TYPE = {type1:["_ctr0"],type2:["_ctr1"],type3:["_ctr2","_ctr4"],type4:["_ctr3"],type5:["_ctr5"],type6:["_ctrMount"],type8:["_ctr1"],type9:["_ctr8","_ctrMount"],type10:["_ctr6"],type11:["_ctr7"],type12:["_ctr8","_ctr16"],type13:["_ctr9","_ctr10","_ctr11","_ctr12","_ctr13","_ctr14"],type7:["_ctr15"]};
	static var SUPERTYPE_NOT_EQUIPABLE = [9,14,15,16,17,18,6,19,21,20,8,22];
	static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	static var FILTER_QUEST = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,true];
	var _nSelectedTypeID = 0;
	function Inventory()
	{
		super();
	}
	function __set__dataProvider(var2)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__dataProvider();
	}
	function showCharacterPreview(var2)
	{
		if(var2)
		{
			this._winPreview._visible = true;
			this._svCharacterViewer._visible = true;
			this._mcItemSetViewerPlacer._x = this._mcBottomPlacer._x;
			this._mcItemSetViewerPlacer._y = this._mcBottomPlacer._y;
			this._isvItemSetViewer._x = this._mcBottomPlacer._x;
			this._isvItemSetViewer._y = this._mcBottomPlacer._y;
		}
		else
		{
			this._winPreview._visible = false;
			this._svCharacterViewer._visible = false;
			this._mcItemSetViewerPlacer._x = this._winPreview._x;
			this._mcItemSetViewerPlacer._y = this._winPreview._y;
			this._isvItemSetViewer._x = this._winPreview._x;
			this._isvItemSetViewer._y = this._winPreview._y;
		}
	}
	function showLivingItems(var2)
	{
		this._livItemViewer._visible = var2;
		this._winLivingItems._visible = var2;
		if(var2)
		{
			this._winPreview._visible = false;
			this._svCharacterViewer._visible = false;
			this._mcItemSetViewerPlacer._x = this._mcBottomPlacer._x;
			this._mcItemSetViewerPlacer._y = this._mcBottomPlacer._y;
			this._isvItemSetViewer._x = this._mcBottomPlacer._x;
			this._isvItemSetViewer._y = this._mcBottomPlacer._y;
		}
		else
		{
			this.showCharacterPreview(this.api.kernel.OptionsManager.getOption("CharacterPreview"));
		}
	}
	function showItemInfos(var2)
	{
		if(var2 == undefined)
		{
			this.hideItemViewer(true);
			this.hideItemSetViewer(true);
		}
		else
		{
			this.hideItemViewer(false);
			var var3 = var2.clone();
			if(var3.realGfx)
			{
				var3.gfx = var3.realGfx;
			}
			this._itvItemViewer.itemData = var3;
			if(var2.isFromItemSet)
			{
				var var4 = this.api.datacenter.Player.ItemSets.getItemAt(var2.itemSetID);
				if(var4 == undefined)
				{
					var4 = new dofus.datacenter.ItemSet(var2.itemSetID,"",[]);
				}
				this.hideItemSetViewer(false);
				this._isvItemSetViewer.itemSet = var4;
			}
			else
			{
				this.hideItemSetViewer(true);
			}
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Inventory.CLASS_NAME);
		this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Items");
		this.showCharacterPreview(this.api.kernel.OptionsManager.getOption("CharacterPreview"));
		this.showLivingItems(false);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
		if(this.api.datacenter.Game.isFight)
		{
			this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
		}
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this._winBg.onRelease = function()
		{
		};
		this._winBg.useHandCursor = false;
		this._winLivingItems.onRelease = function()
		{
		};
		this._winLivingItems.useHandCursor = false;
		this.addToQueue({object:this,method:this.hideEpisodicContent});
		this.addToQueue({object:this,method:this.initFilter});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.hideItemViewer(true);
		this.hideItemSetViewer(true);
		this._ctrShield = this._ctr15;
		this._ctrWeapon = this._ctr1;
		this._ctrMount = this._ctr16;
		this._mcTwoHandedLink._visible = false;
		this._mcTwoHandedLink.stop();
		this._mcTwoHandedCrossLeft._visible = false;
		this._mcTwoHandedCrossRight._visible = false;
		Mouse.addListener(this);
		this.api.datacenter.Player.addEventListener("kamaChanged",this);
		this.api.datacenter.Player.addEventListener("mountChanged",this);
		this.addToQueue({object:this,method:this.kamaChanged,params:[{value:this.api.datacenter.Player.Kama}]});
		this.addToQueue({object:this,method:this.mountChanged});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function draw()
	{
		var var2 = this.getStyle();
		this.addToQueue({object:this,method:this.setSubComponentsStyle,params:[var2]});
	}
	function setSubComponentsStyle(var2)
	{
		this._itvItemViewer.styleName = var2.itenviewerstyle;
	}
	function hideEpisodicContent()
	{
		if(this.api.datacenter.Basics.aks_current_regional_version < 20)
		{
			this._ctrMount._visible = false;
			this._mcMountCross._visible = false;
		}
		else
		{
			this._ctrMount._visible = true;
		}
	}
	function addListeners()
	{
		this._cgGrid.addEventListener("dropItem",this);
		this._cgGrid.addEventListener("dragItem",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.addEventListener("overItem",this);
		this._cgGrid.addEventListener("outItem",this);
		this._cgGrid.addEventListener("dblClickItem",this);
		this._btnFilterEquipement.addEventListener("click",this);
		this._btnFilterNonEquipement.addEventListener("click",this);
		this._btnFilterRessoureces.addEventListener("click",this);
		this._btnFilterQuest.addEventListener("click",this);
		this._btnFilterEquipement.addEventListener("over",this);
		this._btnFilterNonEquipement.addEventListener("over",this);
		this._btnFilterRessoureces.addEventListener("over",this);
		this._btnFilterQuest.addEventListener("over",this);
		this._btnFilterEquipement.addEventListener("out",this);
		this._btnFilterNonEquipement.addEventListener("out",this);
		this._btnFilterRessoureces.addEventListener("out",this);
		this._btnFilterQuest.addEventListener("out",this);
		this._btnClose.addEventListener("click",this);
		this._itvItemViewer.addEventListener("useItem",this);
		this._itvItemViewer.addEventListener("destroyItem",this);
		this._itvItemViewer.addEventListener("targetItem",this);
		this._cbTypes.addEventListener("itemSelected",this);
		for(var a in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
		{
			var var2 = dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[a];
			var var3 = 0;
			while(var3 < var2.length)
			{
				var var4 = this[var2[var3]];
				var4.addEventListener("over",this);
				var4.addEventListener("out",this);
				if(var4.toolTipText == undefined)
				{
					var4.toolTipText = this.api.lang.getText(var4 != this._ctrMount?"INVENTORY_" + a.toUpperCase():"MOUNT");
				}
				var3 = var3 + 1;
			}
		}
	}
	function initTexts()
	{
		this._lblWeight.text = this.api.lang.getText("WEIGHT");
		this._winPreview.title = this.api.lang.getText("CHARACTER_PREVIEW",[this.api.datacenter.Player.Name]);
		this._winBg.title = this.api.lang.getText("INVENTORY");
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
		this._lblNoItem.text = this.api.lang.getText("SELECT_ITEM");
		this._winLivingItems.title = this.api.lang.getText("MANAGE_ITEM");
	}
	function initFilter()
	{
		if((var var0 = this.api.datacenter.Basics.inventory_filter) !== "nonequipement")
		{
			switch(null)
			{
				case "resources":
					this._btnFilterRessoureces.selected = true;
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
					this._btnSelectedFilterButton = this._btnFilterRessoureces;
					break;
				case "quest":
					this._btnFilterQuest.selected = true;
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
					this._btnSelectedFilterButton = this._btnFilterQuest;
					break;
				case "equipement":
				default:
					this._btnFilterEquipement.selected = true;
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
					this._btnSelectedFilterButton = this._btnFilterEquipement;
			}
		}
		else
		{
			this._btnFilterNonEquipement.selected = true;
			this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
			this._btnSelectedFilterButton = this._btnFilterNonEquipement;
		}
	}
	function initData()
	{
		this._svCharacterViewer.zoom = 250;
		this._svCharacterViewer.spriteData = (ank.battlefield.datacenter.Sprite)this.api.datacenter.Player.data;
		this.dataProvider = this.api.datacenter.Player.Inventory;
	}
	function enabledFromSuperType(var2)
	{
		var var3 = var2.superType;
		if(var3 != undefined)
		{
			for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
				{
					var var4 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
					var4.enabled = false;
					var4.selected = false;
				}
			}
			var var5 = this.api.lang.getItemSuperTypeText(var3);
			if(var5)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3])
				{
					var var6 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3][i]];
					if(!(var3 == 9 && var6.contentPath == ""))
					{
						var6.enabled = true;
						var6.selected = true;
					}
				}
			}
			else
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3])
				{
					var var8 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3][i]];
					if(var8.contentData == undefined)
					{
						var var7 = var8;
					}
					else if(var8.contentData.unicID == var2.unicID)
					{
						while(§§pop() != null)
						{
						}
						return undefined;
					}
				}
				if(var7 != undefined)
				{
					var7.enabled = true;
					var7.selected = true;
				}
			}
			if(var2.needTwoHands)
			{
				this._mcTwoHandedCrossLeft._visible = true;
				this._mcTwoHandedCrossRight._visible = false;
				this._ctrShield.content._alpha = 30;
				this._mcTwoHandedLink.play();
				this._mcTwoHandedLink._visible = true;
			}
			if(var3 == 7 && this.api.datacenter.Player.weaponItem.needTwoHands)
			{
				this._mcTwoHandedCrossLeft._visible = false;
				this._mcTwoHandedCrossRight._visible = true;
				this._ctrWeapon.content._alpha = 30;
				this._mcTwoHandedLink.play();
				this._mcTwoHandedLink._visible = true;
			}
		}
		else
		{
			for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
				{
					var var9 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
					var9.enabled = true;
					if(var9.selected)
					{
						var9.selected = false;
					}
				}
			}
			if(this.api.datacenter.Player.weaponItem.needTwoHands)
			{
				this._mcTwoHandedLink.gotoAndStop(1);
				this._mcTwoHandedLink._visible = true;
				this._mcTwoHandedCrossLeft._visible = true;
			}
		}
	}
	function updateData(var2)
	{
		var var3 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = var3 != undefined?var3:0;
		var var4 = new Object();
		if(!var2)
		{
			for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
				{
					var4[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]] = true;
				}
			}
		}
		var var5 = new ank.utils.();
		var var6 = new ank.utils.();
		var var7 = new Object();
		for(var k in this._eaDataProvider)
		{
			var var8 = this._eaDataProvider[k];
			var var9 = var8.position;
			if(var9 != -1)
			{
				if(!var2)
				{
					var var10 = this["_ctr" + var9];
					var10.contentData = var8;
					delete register4[var10._name];
				}
			}
			else if(this._aSelectedSuperTypes[var8.superType])
			{
				if(var8.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					var5.push(var8);
				}
				var var11 = var8.type;
				if(var7[var11] != true)
				{
					var6.push({label:this.api.lang.getItemTypeText(var11).n,id:var11});
					var7[var11] = true;
				}
			}
		}
		var6.sortOn("label");
		var6.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = var6;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = var5;
		if(!var2)
		{
			for(var k in var4)
			{
				if(this[k] != this._ctrMount)
				{
					this[k].contentData = undefined;
				}
			}
		}
		this.resetTwoHandClip();
	}
	function resetTwoHandClip()
	{
		this._ctrShield.content._alpha = 100;
		this._ctrWeapon.content._alpha = 100;
		this._mcTwoHandedLink.gotoAndStop(1);
		if(this.api.datacenter.Player.weaponItem.needTwoHands)
		{
			this._mcTwoHandedLink._visible = true;
			this._mcTwoHandedCrossLeft._visible = true;
			this._mcTwoHandedCrossRight._visible = false;
		}
		else
		{
			this._mcTwoHandedLink._visible = false;
			this._mcTwoHandedCrossLeft._visible = false;
			this._mcTwoHandedCrossRight._visible = false;
		}
	}
	function setType(var2)
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
	function canMoveItem()
	{
		var var2 = this.api.datacenter.Game.isRunning;
		var var3 = this.api.datacenter.Exchange != undefined;
		if(var2 || var3)
		{
			this.gapi.loadUIComponent("AskOk","AskOkInventory",{title:this.api.lang.getText("INFORMATIONS"),text:this.api.lang.getText("CANT_MOVE_ITEM")});
		}
		return !(var2 || var3);
	}
	function askDestroy(var2, var3)
	{
		if(var2.Quantity == 1)
		{
			var var4 = this.gapi.loadUIComponent("AskYesNo","AskYesNoDestroy",{title:this.api.lang.getText("QUESTION"),text:this.api.lang.getText("DO_U_DESTROY",[var3,var2.name]),params:{item:var2,quantity:var3}});
			var4.addEventListener("yes",this);
		}
		else
		{
			this.api.network.Items.destroy(var2.ID,var3);
		}
	}
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._mcItvDescBg._visible = !var2;
		this._mcItvIconBg._visible = !var2;
	}
	function hideItemSetViewer(var2)
	{
		if(var2)
		{
			this._isvItemSetViewer.removeMovieClip();
		}
		else if(this._isvItemSetViewer == undefined)
		{
			this.attachMovie("ItemSetViewer","_isvItemSetViewer",this.getNextHighestDepth(),{_x:this._mcItemSetViewerPlacer._x,_y:this._mcItemSetViewerPlacer._y});
		}
	}
	function kamaChanged(var2)
	{
		this._lblKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	}
	function click(var2)
	{
		if(var2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
		if(this._mcArrowAnimation._visible)
		{
			this._mcArrowAnimation._visible = false;
		}
		if(var2.target != this._btnSelectedFilterButton)
		{
			this.api.sounds.events.onInventoryFilterButtonClick();
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = var2.target;
			if((var var0 = var2.target._name) !== "_btnFilterEquipement")
			{
				switch(null)
				{
					case "_btnFilterNonEquipement":
						this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
						this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
						this.api.datacenter.Basics.inventory_filter = "nonequipement";
						break;
					case "_btnFilterRessoureces":
						this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_RESSOURECES;
						this._lblFilter.text = this.api.lang.getText("RESSOURECES");
						this.api.datacenter.Basics.inventory_filter = "resources";
						break;
					case "_btnFilterQuest":
						this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_QUEST;
						this._lblFilter.text = this.api.lang.getText("QUEST_OBJECTS");
						this.api.datacenter.Basics.inventory_filter = "quest";
				}
			}
			else
			{
				this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
				this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
				this.api.datacenter.Basics.inventory_filter = "equipement";
			}
			this.updateData(true);
		}
		else
		{
			var2.target.selected = true;
		}
	}
	function modelChanged(var2)
	{
		switch(var2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		this.updateData(false);
		this.hideItemViewer(true);
		this.hideItemSetViewer(true);
		this.showLivingItems(false);
	}
	function onMouseUp()
	{
		this.addToQueue({object:this,method:this.enabledFromSuperType});
	}
	function dragItem(var2)
	{
		this.gapi.removeCursor();
		if(!this.canMoveItem())
		{
			return undefined;
		}
		if(var2.target.contentData == undefined)
		{
			return undefined;
		}
		if(var2.target.contentData.isCursed)
		{
			return undefined;
		}
		this.enabledFromSuperType(var2.target.contentData);
		this.gapi.setCursor(var2.target.contentData);
	}
	function dropItem(var2)
	{
		if(!this.canMoveItem())
		{
			return undefined;
		}
		var var3 = this.gapi.getCursor();
		if(var3 == undefined)
		{
			return undefined;
		}
		if(var2.target._parent == this)
		{
			var var4 = Number(var2.target._name.substr(4));
		}
		else
		{
			if(var3.position == -1)
			{
				this.resetTwoHandClip();
				return undefined;
			}
			var4 = -1;
		}
		if(var3.position == var4)
		{
			this.resetTwoHandClip();
			return undefined;
		}
		this.gapi.removeCursor();
		if(var3.Quantity > 1 && (var4 == -1 || var4 == 16))
		{
			var var5 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:var3.Quantity,max:var3.Quantity,params:{type:"move",position:var4,item:var3}});
			var5.addEventListener("validate",this);
		}
		else
		{
			this.api.network.Items.movement(var3.ID,var4);
		}
	}
	function selectItem(var2)
	{
		if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && var2.target.contentData != undefined)
		{
			this.api.kernel.GameManager.insertItemInChat(var2.target.contentData);
		}
		else
		{
			this.showItemInfos(var2.target.contentData);
			this.showLivingItems(var2.target.contentData.skineable == true);
			if(var2.target.contentData.skineable)
			{
				this._livItemViewer.itemData = var2.target.contentData;
			}
		}
	}
	function overItem(var2)
	{
		var var3 = var2.target.contentData;
		var var4 = -20;
		var var5 = var3.name;
		var var6 = true;
		for(var s in var3.effects)
		{
			var var7 = var3.effects[s];
			if(var7.description.length > 0)
			{
				if(var6)
				{
					var5 = var5 + "\n";
					var4 = var4 - 10;
					var6 = false;
				}
				var5 = var5 + "\n" + var7.description;
				var4 = var4 - 12;
			}
		}
		this.gapi.showTooltip(var5,var2.target,var4,undefined,var2.target.contentData.style + "ToolTip");
	}
	function outItem(var2)
	{
		this.gapi.hideTooltip();
	}
	function dblClickItem(var2)
	{
		if(!this.canMoveItem())
		{
			return undefined;
		}
		var var3 = var2.target.contentData;
		if(var3 == undefined)
		{
			return undefined;
		}
		if(var3.position == -1)
		{
			if(var3.canUse && this.api.datacenter.Player.canUseObject)
			{
				this.api.network.Items.use(var3.ID);
			}
			else if(this.api.lang.getConfigText("DOUBLE_CLICK_TO_EQUIP"))
			{
				this.equipItem(var3);
			}
		}
		else
		{
			this.api.network.Items.movement(var3.ID,-1);
		}
	}
	function getFreeSlot(var2)
	{
		var var3 = var2.superType;
		for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3])
		{
			if(dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3][i] != "_ctr16")
			{
				if(this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3][i]].contentData == undefined)
				{
					return this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + var3][i]];
				}
			}
		}
		return undefined;
	}
	function equipItem(var2)
	{
		if(var2.position != -1)
		{
			return undefined;
		}
		var var3 = var2.superType;
		if(var2.type != 83)
		{
			var var4 = 0;
			while(var4 < dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE.length)
			{
				if(dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE[var4] == var3)
				{
					return undefined;
				}
				var4 = var4 + 1;
			}
		}
		var var5 = this.getFreeSlot(var2);
		if(var5 != undefined)
		{
			var var6 = Number(var5._name.substr(4));
			this.cleanRideIfNecessary(var3);
			this.api.network.Items.movement(var2.ID,var6);
		}
		else
		{
			var var8 = this.api.lang.getSlotsFromSuperType(var2.superType);
			var var9 = getTimer();
			var var10 = 0;
			while(var10 < var8.length)
			{
				if(this.api.kernel.GameManager.getLastModified(var8[var10]) < var9)
				{
					var9 = this.api.kernel.GameManager.getLastModified(var8[var10]);
					var var7 = var8[var10];
				}
				var10 = var10 + 1;
			}
			if(this["_ctr" + var7].contentData.ID == undefined || _global.isNaN(this["_ctr" + var7].contentData.ID))
			{
				return undefined;
			}
			if(var7 == undefined || _global.isNaN(var7))
			{
				return undefined;
			}
			this.cleanRideIfNecessary(var3);
			this.api.network.Items.movement(this["_ctr" + var7].contentData.ID,-1);
			this.api.network.Items.movement(var2.ID,var7);
		}
	}
	function cleanRideIfNecessary(var2)
	{
		if(var2 == 12 && (!this.api.datacenter.Game.isFight && this.api.datacenter.Player.isRiding))
		{
			this.api.network.Mount.ride();
		}
	}
	function dropDownItem()
	{
		if(!this.canMoveItem())
		{
			return undefined;
		}
		var var2 = this.gapi.getCursor();
		if(!var2.canDrop)
		{
			this.gapi.loadUIComponent("AskOk","AskOkCantDrop",{title:this.api.lang.getText("IMPOSSIBLE"),text:this.api.lang.getText("CANT_DROP_ITEM")});
			return undefined;
		}
		if(var2.Quantity > 1)
		{
			var var3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var2.Quantity,params:{type:"drop",item:var2}});
			var3.addEventListener("validate",this);
		}
		else if(this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_DROP_ITEM"),"CAUTION_YESNO",{name:"ConfirmDropOne",params:{item:var2},listener:this});
		}
		else
		{
			this.api.network.Items.drop(var2.ID,1);
		}
	}
	function validate(var2)
	{
		switch(var2.params.type)
		{
			case "destroy":
				if(var2.value > 0 && !_global.isNaN(Number(var2.value)))
				{
					var var3 = Math.min(var2.value,var2.params.item.Quantity);
					this.askDestroy(var2.params.item,var3);
				}
				break;
			case "drop":
				this.gapi.removeCursor();
				if(var2.value > 0 && !_global.isNaN(Number(var2.value)))
				{
					if(this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_DROP_ITEM"),"CAUTION_YESNO",{name:"ConfirmDrop",params:{item:var2.params.item,minValue:var2.value},listener:this});
					}
					else
					{
						this.api.network.Items.drop(var2.params.item.ID,Math.min(var2.value,var2.params.item.Quantity));
					}
				}
				break;
			case "move":
				if(var2.value > 0 && !_global.isNaN(Number(var2.value)))
				{
					this.api.network.Items.movement(var2.params.item.ID,var2.params.position,Math.min(var2.value,var2.params.item.Quantity));
					break;
				}
		}
	}
	function useItem(var2)
	{
		if(!var2.item.canUse || !this.api.datacenter.Player.canUseObject)
		{
			return undefined;
		}
		this.api.network.Items.use(var2.item.ID);
	}
	function destroyItem(var2)
	{
		if(var2.item.Quantity > 1)
		{
			var var3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var2.item.Quantity,params:{type:"destroy",item:var2.item}});
			var3.addEventListener("validate",this);
		}
		else
		{
			this.askDestroy(var2.item,1);
		}
	}
	function targetItem(var2)
	{
		if(!var2.item.canTarget || !this.api.datacenter.Player.canUseObject)
		{
			return undefined;
		}
		this.api.kernel.GameManager.switchToItemTarget(var2.item);
		this.callClose();
	}
	function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoConfirmDropOne":
				this.api.network.Items.drop(var2.target.params.item.ID,1);
				break;
			case "AskYesNoConfirmDrop":
				this.api.network.Items.drop(var2.params.item.ID,Math.min(var2.params.minValue,var2.params.item.Quantity));
				break;
			default:
				this.api.network.Items.destroy(var2.target.params.item.ID,var2.target.params.quantity);
		}
	}
	function itemSelected(var2)
	{
		if((var var0 = var2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function mountChanged(var2)
	{
		var var3 = this.api.datacenter.Player.mount;
		if(var3 != undefined)
		{
			this._ctrMount.contentPath = "UI_InventoryMountIcon";
			this._mcMountCross._visible = false;
		}
		else
		{
			this._ctrMount.contentPath = "";
			this._mcMountCross._visible = true;
		}
		this.hideEpisodicContent();
	}
	function over(var2)
	{
		switch(var2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),var2.target,-20);
				break;
			case this._btnFilterNonEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),var2.target,-20);
				break;
			case this._btnFilterRessoureces:
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
				break;
			default:
				if(var0 !== this._btnFilterQuest)
				{
					this.api.ui.showTooltip(var2.target.toolTipText,var2.target,-20);
					break;
				}
				this.api.ui.showTooltip(this.api.lang.getText("QUEST_OBJECTS"),var2.target,-20);
				break;
		}
	}
	function out(var2)
	{
		this.api.ui.hideTooltip();
	}
}
