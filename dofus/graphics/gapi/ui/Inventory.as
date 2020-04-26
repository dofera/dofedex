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
	function __set__dataProvider(loc2)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = loc2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__dataProvider();
	}
	function showCharacterPreview(loc2)
	{
		if(loc2)
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
	function showLivingItems(loc2)
	{
		this._livItemViewer._visible = loc2;
		this._winLivingItems._visible = loc2;
		if(loc2)
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
	function showItemInfos(loc2)
	{
		if(loc2 == undefined)
		{
			this.hideItemViewer(true);
			this.hideItemSetViewer(true);
		}
		else
		{
			this.hideItemViewer(false);
			var loc3 = loc2.clone();
			if(loc3.realGfx)
			{
				loc3.gfx = loc3.realGfx;
			}
			this._itvItemViewer.itemData = loc3;
			if(loc2.isFromItemSet)
			{
				var loc4 = this.api.datacenter.Player.ItemSets.getItemAt(loc2.itemSetID);
				if(loc4 == undefined)
				{
					loc4 = new dofus.datacenter.ItemSet(loc2.itemSetID,"",[]);
				}
				this.hideItemSetViewer(false);
				this._isvItemSetViewer.itemSet = loc4;
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
		var loc2 = this.getStyle();
		this.addToQueue({object:this,method:this.setSubComponentsStyle,params:[loc2]});
	}
	function setSubComponentsStyle(loc2)
	{
		this._itvItemViewer.styleName = loc2.itenviewerstyle;
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
			var loc2 = dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[a];
			var loc3 = 0;
			while(loc3 < loc2.length)
			{
				var loc4 = this[loc2[loc3]];
				loc4.addEventListener("over",this);
				loc4.addEventListener("out",this);
				if(loc4.toolTipText == undefined)
				{
					loc4.toolTipText = this.api.lang.getText(loc4 != this._ctrMount?"INVENTORY_" + a.toUpperCase():"MOUNT");
				}
				loc3 = loc3 + 1;
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
		if((var loc0 = this.api.datacenter.Basics.inventory_filter) !== "nonequipement")
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
	function enabledFromSuperType(loc2)
	{
		var loc3 = loc2.superType;
		if(loc3 != undefined)
		{
			for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
				{
					var loc4 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
					loc4.enabled = false;
					loc4.selected = false;
				}
			}
			var loc5 = this.api.lang.getItemSuperTypeText(loc3);
			if(loc5)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3])
				{
					var loc6 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3][i]];
					if(!(loc3 == 9 && loc6.contentPath == ""))
					{
						loc6.enabled = true;
						loc6.selected = true;
					}
				}
			}
			else
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3])
				{
					var loc8 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3][i]];
					if(loc8.contentData == undefined)
					{
						var loc7 = loc8;
					}
					else if(loc8.contentData.unicID == loc2.unicID)
					{
						return undefined;
					}
				}
				if(loc7 != undefined)
				{
					loc7.enabled = true;
					loc7.selected = true;
				}
			}
			if(loc2.needTwoHands)
			{
				this._mcTwoHandedCrossLeft._visible = true;
				this._mcTwoHandedCrossRight._visible = false;
				this._ctrShield.content._alpha = 30;
				this._mcTwoHandedLink.play();
				this._mcTwoHandedLink._visible = true;
			}
			if(loc3 == 7 && this.api.datacenter.Player.weaponItem.needTwoHands)
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
					var loc9 = this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]];
					loc9.enabled = true;
					if(loc9.selected)
					{
						loc9.selected = false;
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
	function updateData(loc2)
	{
		var loc3 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = loc3 != undefined?loc3:0;
		var loc4 = new Object();
		if(!loc2)
		{
			for(var k in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE)
			{
				for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k])
				{
					loc4[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE[k][i]] = true;
				}
			}
		}
		var loc5 = new ank.utils.();
		var loc6 = new ank.utils.();
		var loc7 = new Object();
		for(var k in this._eaDataProvider)
		{
			var loc8 = this._eaDataProvider[k];
			var loc9 = loc8.position;
			if(loc9 != -1)
			{
				if(!loc2)
				{
					var loc10 = this["_ctr" + loc9];
					loc10.contentData = loc8;
					delete register4[loc10._name];
				}
			}
			else if(this._aSelectedSuperTypes[loc8.superType])
			{
				if(loc8.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					loc5.push(loc8);
				}
				var loc11 = loc8.type;
				if(loc7[loc11] != true)
				{
					loc6.push({label:this.api.lang.getItemTypeText(loc11).n,id:loc11});
					loc7[loc11] = true;
				}
			}
		}
		loc6.sortOn("label");
		loc6.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = loc6;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = loc5;
		if(!loc2)
		{
			for(var k in loc4)
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
	function canMoveItem()
	{
		var loc2 = this.api.datacenter.Game.isRunning;
		var loc3 = this.api.datacenter.Exchange != undefined;
		if(loc2 || loc3)
		{
			this.gapi.loadUIComponent("AskOk","AskOkInventory",{title:this.api.lang.getText("INFORMATIONS"),text:this.api.lang.getText("CANT_MOVE_ITEM")});
		}
		return !(loc2 || loc3);
	}
	function askDestroy(loc2, loc3)
	{
		if(loc2.Quantity == 1)
		{
			var loc4 = this.gapi.loadUIComponent("AskYesNo","AskYesNoDestroy",{title:this.api.lang.getText("QUESTION"),text:this.api.lang.getText("DO_U_DESTROY",[loc3,loc2.name]),params:{item:loc2,quantity:loc3}});
			loc4.addEventListener("yes",this);
		}
		else
		{
			this.api.network.Items.destroy(loc2.ID,loc3);
		}
	}
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._mcItvDescBg._visible = !loc2;
		this._mcItvIconBg._visible = !loc2;
	}
	function hideItemSetViewer(loc2)
	{
		if(loc2)
		{
			this._isvItemSetViewer.removeMovieClip();
		}
		else if(this._isvItemSetViewer == undefined)
		{
			this.attachMovie("ItemSetViewer","_isvItemSetViewer",this.getNextHighestDepth(),{_x:this._mcItemSetViewerPlacer._x,_y:this._mcItemSetViewerPlacer._y});
		}
	}
	function kamaChanged(loc2)
	{
		this._lblKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	}
	function click(loc2)
	{
		if(loc2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
		if(this._mcArrowAnimation._visible)
		{
			this._mcArrowAnimation._visible = false;
		}
		if(loc2.target != this._btnSelectedFilterButton)
		{
			this.api.sounds.events.onInventoryFilterButtonClick();
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = loc2.target;
			switch(loc2.target._name)
			{
				case "_btnFilterEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_EQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
					this.api.datacenter.Basics.inventory_filter = "equipement";
					break;
				case "_btnFilterNonEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Inventory.FILTER_NONEQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
					this.api.datacenter.Basics.inventory_filter = "nonequipement";
					break;
				default:
					switch(null)
					{
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
			this.updateData(true);
		}
		else
		{
			loc2.target.selected = true;
		}
	}
	function modelChanged(loc2)
	{
		switch(loc2.eventName)
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
	function dragItem(loc2)
	{
		this.gapi.removeCursor();
		if(!this.canMoveItem())
		{
			return undefined;
		}
		if(loc2.target.contentData == undefined)
		{
			return undefined;
		}
		if(loc2.target.contentData.isCursed)
		{
			return undefined;
		}
		this.enabledFromSuperType(loc2.target.contentData);
		this.gapi.setCursor(loc2.target.contentData);
	}
	function dropItem(loc2)
	{
		if(!this.canMoveItem())
		{
			return undefined;
		}
		var loc3 = this.gapi.getCursor();
		if(loc3 == undefined)
		{
			return undefined;
		}
		if(loc2.target._parent == this)
		{
			var loc4 = Number(loc2.target._name.substr(4));
		}
		else
		{
			if(loc3.position == -1)
			{
				this.resetTwoHandClip();
				return undefined;
			}
			loc4 = -1;
		}
		if(loc3.position == loc4)
		{
			this.resetTwoHandClip();
			return undefined;
		}
		this.gapi.removeCursor();
		if(loc3.Quantity > 1 && (loc4 == -1 || loc4 == 16))
		{
			var loc5 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:loc3.Quantity,max:loc3.Quantity,params:{type:"move",position:loc4,item:loc3}});
			loc5.addEventListener("validate",this);
		}
		else
		{
			this.api.network.Items.movement(loc3.ID,loc4);
		}
	}
	function selectItem(loc2)
	{
		if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc2.target.contentData != undefined)
		{
			this.api.kernel.GameManager.insertItemInChat(loc2.target.contentData);
		}
		else
		{
			this.showItemInfos(loc2.target.contentData);
			this.showLivingItems(loc2.target.contentData.skineable == true);
			if(loc2.target.contentData.skineable)
			{
				this._livItemViewer.itemData = loc2.target.contentData;
			}
		}
	}
	function overItem(loc2)
	{
		var loc3 = loc2.target.contentData;
		var loc4 = -20;
		var loc5 = loc3.name;
		var loc6 = true;
		for(var s in loc3.effects)
		{
			var loc7 = loc3.effects[s];
			if(loc7.description.length > 0)
			{
				if(loc6)
				{
					loc5 = loc5 + "\n";
					loc4 = loc4 - 10;
					loc6 = false;
				}
				loc5 = loc5 + "\n" + loc7.description;
				loc4 = loc4 - 12;
			}
		}
		this.gapi.showTooltip(loc5,loc2.target,loc4,undefined,loc2.target.contentData.style + "ToolTip");
	}
	function outItem(loc2)
	{
		this.gapi.hideTooltip();
	}
	function dblClickItem(loc2)
	{
		if(!this.canMoveItem())
		{
			return undefined;
		}
		var loc3 = loc2.target.contentData;
		if(loc3 == undefined)
		{
			return undefined;
		}
		if(loc3.position == -1)
		{
			if(loc3.canUse && this.api.datacenter.Player.canUseObject)
			{
				this.api.network.Items.use(loc3.ID);
			}
			else if(this.api.lang.getConfigText("DOUBLE_CLICK_TO_EQUIP"))
			{
				this.equipItem(loc3);
			}
		}
		else
		{
			this.api.network.Items.movement(loc3.ID,-1);
		}
	}
	function getFreeSlot(loc2)
	{
		var loc3 = loc2.superType;
		for(var i in dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3])
		{
			if(dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3][i] != "_ctr16")
			{
				if(this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3][i]].contentData == undefined)
				{
					return this[dofus.graphics.gapi.ui.Inventory.CONTAINER_BY_TYPE["type" + loc3][i]];
				}
			}
		}
		return undefined;
	}
	function equipItem(loc2)
	{
		if(loc2.position != -1)
		{
			return undefined;
		}
		var loc3 = loc2.superType;
		if(loc2.type != 83)
		{
			var loc4 = 0;
			while(loc4 < dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE.length)
			{
				if(dofus.graphics.gapi.ui.Inventory.SUPERTYPE_NOT_EQUIPABLE[loc4] == loc3)
				{
					return undefined;
				}
				loc4 = loc4 + 1;
			}
		}
		var loc5 = this.getFreeSlot(loc2);
		if(loc5 != undefined)
		{
			var loc6 = Number(loc5._name.substr(4));
			this.cleanRideIfNecessary(loc3);
			this.api.network.Items.movement(loc2.ID,loc6);
		}
		else
		{
			var loc8 = this.api.lang.getSlotsFromSuperType(loc2.superType);
			var loc9 = getTimer();
			var loc10 = 0;
			while(loc10 < loc8.length)
			{
				if(this.api.kernel.GameManager.getLastModified(loc8[loc10]) < loc9)
				{
					loc9 = this.api.kernel.GameManager.getLastModified(loc8[loc10]);
					var loc7 = loc8[loc10];
				}
				loc10 = loc10 + 1;
			}
			if(this["_ctr" + loc7].contentData.ID == undefined || _global.isNaN(this["_ctr" + loc7].contentData.ID))
			{
				return undefined;
			}
			if(loc7 == undefined || _global.isNaN(loc7))
			{
				return undefined;
			}
			this.cleanRideIfNecessary(loc3);
			this.api.network.Items.movement(this["_ctr" + loc7].contentData.ID,-1);
			this.api.network.Items.movement(loc2.ID,loc7);
		}
	}
	function cleanRideIfNecessary(loc2)
	{
		if(loc2 == 12 && (!this.api.datacenter.Game.isFight && this.api.datacenter.Player.isRiding))
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
		var loc2 = this.gapi.getCursor();
		if(!loc2.canDrop)
		{
			this.gapi.loadUIComponent("AskOk","AskOkCantDrop",{title:this.api.lang.getText("IMPOSSIBLE"),text:this.api.lang.getText("CANT_DROP_ITEM")});
			return undefined;
		}
		if(loc2.Quantity > 1)
		{
			var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc2.Quantity,params:{type:"drop",item:loc2}});
			loc3.addEventListener("validate",this);
		}
		else if(this.api.kernel.OptionsManager.getOption("ConfirmDropItem"))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_DROP_ITEM"),"CAUTION_YESNO",{name:"ConfirmDropOne",params:{item:loc2},listener:this});
		}
		else
		{
			this.api.network.Items.drop(loc2.ID,1);
		}
	}
	function validate(loc2)
	{
		switch(loc2.params.type)
		{
			case "destroy":
				if(loc2.value > 0 && !_global.isNaN(Number(loc2.value)))
				{
					var loc3 = Math.min(loc2.value,loc2.params.item.Quantity);
					this.askDestroy(loc2.params.item,loc3);
				}
				break;
			case "drop":
				this.gapi.removeCursor();
				if(loc2.value > 0 && !_global.isNaN(Number(loc2.value)))
				{
					§§push("ConfirmDropItem");
					§§push(1);
					§§push(this.api.kernel);
					§§push("OptionsManager");
				}
				break;
			default:
				if(§§pop()[§§pop()].getOption())
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_DROP_ITEM"),"CAUTION_YESNO",{name:"ConfirmDrop",params:{item:loc2.params.item,minValue:loc2.value},listener:this});
				}
				else
				{
					this.api.network.Items.drop(loc2.params.item.ID,Math.min(loc2.value,loc2.params.item.Quantity));
				}
				break;
			case "move":
				if(loc2.value > 0 && !_global.isNaN(Number(loc2.value)))
				{
					this.api.network.Items.movement(loc2.params.item.ID,loc2.params.position,Math.min(loc2.value,loc2.params.item.Quantity));
					break;
				}
		}
	}
	function useItem(loc2)
	{
		if(!loc2.item.canUse || !this.api.datacenter.Player.canUseObject)
		{
			return undefined;
		}
		this.api.network.Items.use(loc2.item.ID);
	}
	function destroyItem(loc2)
	{
		if(loc2.item.Quantity > 1)
		{
			var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc2.item.Quantity,params:{type:"destroy",item:loc2.item}});
			loc3.addEventListener("validate",this);
		}
		else
		{
			this.askDestroy(loc2.item,1);
		}
	}
	function targetItem(loc2)
	{
		if(!loc2.item.canTarget || !this.api.datacenter.Player.canUseObject)
		{
			return undefined;
		}
		this.api.kernel.GameManager.switchToItemTarget(loc2.item);
		this.callClose();
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoConfirmDropOne":
				this.api.network.Items.drop(loc2.target.params.item.ID,1);
				break;
			case "AskYesNoConfirmDrop":
				this.api.network.Items.drop(loc2.params.item.ID,Math.min(loc2.params.minValue,loc2.params.item.Quantity));
				break;
			default:
				this.api.network.Items.destroy(loc2.target.params.item.ID,loc2.target.params.quantity);
		}
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.Inventory.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function mountChanged(loc2)
	{
		var loc3 = this.api.datacenter.Player.mount;
		if(loc3 != undefined)
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
	function over(loc2)
	{
		loop0:
		switch(loc2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),loc2.target,-20);
				break;
			case this._btnFilterNonEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),loc2.target,-20);
				break;
			default:
				switch(null)
				{
					case this._btnFilterRessoureces:
						this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),loc2.target,-20);
						break loop0;
					case this._btnFilterQuest:
						this.api.ui.showTooltip(this.api.lang.getText("QUEST_OBJECTS"),loc2.target,-20);
						break loop0;
					default:
						this.api.ui.showTooltip(loc2.target.toolTipText,loc2.target,-20);
				}
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
}
