class dofus.graphics.gapi.ui.ItemSummoner extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemSummoner";
	function ItemSummoner()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ItemSummoner.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._winBg.title = "Liste des objets";
		this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_ITEM_NAME");
		this._lblType.text = this.api.lang.getText("TYPE");
		this._lblQuantity.text = this.api.lang.getText("QUANTITY");
		this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		this._btnSelect.label = this.api.lang.getText("VALIDATE");
		this._tiSearch.setFocus();
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnCancel.addEventListener("click",this);
		this._btnSelect.addEventListener("click",this);
		this._tiSearch.addEventListener("change",this);
		this._cbType.addEventListener("itemSelected",this);
		this._lst.addEventListener("itemSelected",this);
		this._lst.addEventListener("itemRollOver",this);
		this._lst.addEventListener("itemRollOut",this);
		this._lst.addEventListener("itemDrag",this);
		this._cgGrid.addEventListener("dropItem",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.addEventListener("dragItem",this);
	}
	function initData()
	{
		this._eaItems = new ank.utils.();
		this._tiQuantity.restrict = "0-9";
		this._tiQuantity.text = "1";
		var loc2 = new ank.utils.();
		var loc3 = this.api.lang.getAllItemTypes();
		§§enumerate(loc3);
		while((var loc0 = §§enumeration()) != null)
		{
			loc2.push({label:loc3[a].n,id:a});
		}
		loc2.sortOn("label");
		loc2.push({label:"All",id:-1});
		this._cbType.dataProvider = loc2;
		this._eaGridItems = new ank.utils.();
		this._cgGrid.dataProvider = this._eaGridItems;
	}
	function hideItemViewer(loc2)
	{
		this._winItemViewer._visible = !loc2;
		this._itvItemViewer._visible = !loc2;
	}
	function generateIndexes(loc2)
	{
		var loc3 = new Object();
		for(var k in this._aTypes)
		{
			loc3[this._aTypes[k]] = true;
		}
		var loc4 = this.api.lang.getItemUnics();
		this._eaItems = new ank.utils.();
		this._eaItemsOriginal = new ank.utils.();
		for(var k in loc4)
		{
			var loc5 = loc4[k];
			if(!(loc5.ep != undefined && loc5.ep > this.api.datacenter.Basics.aks_current_regional_version))
			{
				if(loc3[loc5.t])
				{
					var loc6 = loc5.n;
					this._eaItems.push({id:k,name:loc6.toUpperCase()});
					this._eaItemsOriginal.push(new dofus.datacenter.(0,Number(k)));
				}
			}
		}
		this._lblNumber.text = this._eaItemsOriginal.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",this._eaItemsOriginal.length < 2);
	}
	function searchItem(loc2)
	{
		var loc3 = loc2.split(" ");
		var loc4 = new ank.utils.();
		var loc5 = new Object();
		var loc6 = 0;
		var loc7 = 0;
		while(loc7 < this._eaItems.length)
		{
			var loc8 = this._eaItems[loc7];
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
		this._lst.dataProvider = loc4;
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
	function validateDrop(loc2, loc3)
	{
		var loc4 = false;
		§§enumerate(this._eaGridItems);
		loop0:
		while((var loc0 = §§enumeration()) != null)
		{
			if(loc2.equals(this._eaGridItems[i]))
			{
				this._eaGridItems[i].Quantity = this._eaGridItems[i].Quantity + loc3;
				this._cgGrid.modelChanged();
				loc4 = true;
				while(true)
				{
					if(§§pop() == null)
					{
						break loop0;
					}
				}
			}
			else
			{
				continue;
			}
		}
		if(!loc4)
		{
			loc2.Quantity = loc3;
			this._eaGridItems.push(loc2);
		}
	}
	function summonItems()
	{
		for(var loc2 in this._eaGridItems)
		{
			this.api.network.Basics.autorisedCommand("getitem " + loc2.unicID + " " + loc2.Quantity);
		}
		this._eaGridItems = new ank.utils.();
		this._cgGrid.dataProvider = this._eaGridItems;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.dispatchEvent({type:"cancel"});
				this.callClose();
			case "_btnSelect":
				if(this._eaGridItems.length == 0)
				{
					this.dispatchEvent({type:"cancel"});
					this.callClose();
				}
				this.summonItems();
		}
	}
	function change(loc2)
	{
		if(this._tiSearch.text.length >= 2)
		{
			this.searchItem(this._tiSearch.text.toUpperCase());
		}
		else if(this._lst.dataProvider != this._eaItemsOriginal)
		{
			this._lst.dataProvider = this._eaItemsOriginal;
		}
	}
	function itemSelected(loc2)
	{
		switch(loc2.target)
		{
			case this._cbType:
				this._aTypes = new Array();
				if(this._cbType.selectedItem.id != -1)
				{
					this._aTypes.push(this._cbType.selectedItem.id);
				}
				else
				{
					var loc3 = 0;
					while(loc3 < this._cbType.dataProvider.length)
					{
						if(this._cbType.dataProvider[loc3].id != -1)
						{
							this._aTypes.push(this._cbType.dataProvider[loc3].id);
						}
						loc3 = loc3 + 1;
					}
				}
				this.generateIndexes();
				this.change();
				break;
			case this._lst:
				var loc4 = this._lst.selectedItem;
				if(loc4 == undefined)
				{
					this.hideItemViewer(true);
					break;
				}
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
				{
					this.api.kernel.GameManager.insertItemInChat(loc4);
					return undefined;
				}
				this.hideItemViewer(false);
				this._itvItemViewer.itemData = loc4;
				break;
		}
	}
	function itemRollOver(loc2)
	{
		this.gapi.showTooltip(loc2.row.item.name + " (" + loc2.row.item.unicID + ")",loc2.row,20,{bXLimit:true,bYLimit:false});
	}
	function itemRollOut(loc2)
	{
		this.gapi.hideTooltip();
	}
	function itemDrag(loc2)
	{
		if(loc2.row.item == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(loc2.row.item);
	}
	function dragItem(loc2)
	{
		this.gapi.removeCursor();
		if(loc2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(loc2.target.contentData);
	}
	function dropItem(loc2)
	{
		var loc3 = (dofus.datacenter.Item)this.gapi.getCursor();
		if(loc3 == undefined)
		{
			return undefined;
		}
		if(String(loc2.target).indexOf("_cgGrid") > -1)
		{
			if(Key.isDown(Key.CONTROL))
			{
				var loc4 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:99,params:{targetType:"validateDrop",item:loc3}});
				loc4.addEventListener("validate",this);
			}
			else
			{
				this.validateDrop(loc3,1);
			}
		}
		this.gapi.removeCursor();
	}
	function validate(loc2)
	{
		if((var loc0 = loc2.params.targetType) === "validateDrop")
		{
			this.validateDrop((dofus.datacenter.Item)loc2.params.item,loc2.value);
		}
	}
	function selectItem(loc2)
	{
		var loc3 = (dofus.datacenter.Item)loc2.target.contentData;
		if(loc3 == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
			{
				this.api.kernel.GameManager.insertItemInChat(loc3);
				return undefined;
			}
			if(Key.isDown(Key.CONTROL))
			{
				var loc4 = new ank.utils.();
				for(var i in this._eaGridItems)
				{
					if(this._eaGridItems[i].unicID != loc3.unicID)
					{
						loc4.push(this._eaGridItems[i]);
					}
				}
				this._eaGridItems = loc4;
				this._cgGrid.modelChanged();
			}
			else
			{
				this.hideItemViewer(false);
				this._itvItemViewer.itemData = loc3;
			}
		}
	}
}
