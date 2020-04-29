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
		this._eaItems = new ank.utils.();
		this._tiQuantity.restrict = "0-9";
		this._tiQuantity.text = "1";
		var var2 = new ank.utils.();
		var var3 = this.api.lang.getAllItemTypes();
		for(var a in var3)
		{
			var2.push({label:var3[a].n,id:a});
		}
		var2.sortOn("label");
		var2.push({label:"All",id:-1});
		this._cbType.dataProvider = var2;
		this._eaGridItems = new ank.utils.();
		this._cgGrid.dataProvider = this._eaGridItems;
	}
	function hideItemViewer(var2)
	{
		this._winItemViewer._visible = !var2;
		this._itvItemViewer._visible = !var2;
	}
	function generateIndexes(var2)
	{
		var var3 = new Object();
		for(var k in this._aTypes)
		{
			var3[this._aTypes[k]] = true;
		}
		var var4 = this.api.lang.getItemUnics();
		this._eaItems = new ank.utils.();
		this._eaItemsOriginal = new ank.utils.();
		for(var k in var4)
		{
			var var5 = var4[k];
			if(!(var5.ep != undefined && var5.ep > this.api.datacenter.Basics.aks_current_regional_version))
			{
				if(var3[var5.t])
				{
					var var6 = var5.n;
					this._eaItems.push({id:k,name:var6.toUpperCase()});
					this._eaItemsOriginal.push(new dofus.datacenter.(0,Number(k)));
				}
			}
		}
		this._lblNumber.text = this._eaItemsOriginal.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",this._eaItemsOriginal.length < 2);
	}
	function searchItem(var2)
	{
		var var3 = var2.split(" ");
		var var4 = new ank.utils.();
		var var5 = new Object();
		var var6 = 0;
		var var7 = 0;
		while(var7 < this._eaItems.length)
		{
			var var8 = this._eaItems[var7];
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
		this._lst.dataProvider = var4;
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
	function validateDrop(var2, var3)
	{
		var var4 = false;
		for(var i in this._eaGridItems)
		{
			if(var2.equals(this._eaGridItems[i]))
			{
				this._eaGridItems[i].Quantity = this._eaGridItems[i].Quantity + var3;
				this._cgGrid.modelChanged();
				var4 = true;
				break;
			}
		}
		if(!var4)
		{
			var2.Quantity = var3;
			this._eaGridItems.push(var2);
		}
	}
	function summonItems()
	{
		for(var i in this._eaGridItems)
		{
			var var2 = (dofus.datacenter.Item)this._eaGridItems[i];
			this.api.network.Basics.autorisedCommand("getitem " + var2.unicID + " " + var2.Quantity);
		}
		this._eaGridItems = new ank.utils.();
		this._cgGrid.dataProvider = this._eaGridItems;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.dispatchEvent({type:"cancel"});
				this.callClose();
				break;
			default:
				if(var0 !== "_btnSelect")
				{
				}
				break;
		}
		if(this._eaGridItems.length == 0)
		{
			this.dispatchEvent({type:"cancel"});
			this.callClose();
		}
		this.summonItems();
	}
	function change(var2)
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
	function itemSelected(var2)
	{
		switch(var2.target)
		{
			case this._cbType:
				this._aTypes = new Array();
				if(this._cbType.selectedItem.id != -1)
				{
					this._aTypes.push(this._cbType.selectedItem.id);
				}
				else
				{
					var var3 = 0;
					while(var3 < this._cbType.dataProvider.length)
					{
						if(this._cbType.dataProvider[var3].id != -1)
						{
							this._aTypes.push(this._cbType.dataProvider[var3].id);
						}
						var3 = var3 + 1;
					}
				}
				this.generateIndexes();
				this.change();
				break;
			case this._lst:
				var var4 = this._lst.selectedItem;
				if(var4 == undefined)
				{
					this.hideItemViewer(true);
					break;
				}
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
				{
					this.api.kernel.GameManager.insertItemInChat(var4);
					return undefined;
				}
				this.hideItemViewer(false);
				this._itvItemViewer.itemData = var4;
				break;
		}
	}
	function itemRollOver(var2)
	{
		this.gapi.showTooltip(var2.row.item.name + " (" + var2.row.item.unicID + ")",var2.row,20,{bXLimit:true,bYLimit:false});
	}
	function itemRollOut(var2)
	{
		this.gapi.hideTooltip();
	}
	function itemDrag(var2)
	{
		if(var2.row.item == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(var2.row.item);
	}
	function dragItem(var2)
	{
		this.gapi.removeCursor();
		if(var2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(var2.target.contentData);
	}
	function dropItem(var2)
	{
		var var3 = (dofus.datacenter.Item)this.gapi.getCursor();
		if(var3 == undefined)
		{
			return undefined;
		}
		if(String(var2.target).indexOf("_cgGrid") > -1)
		{
			if(Key.isDown(Key.CONTROL))
			{
				var var4 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:99,params:{targetType:"validateDrop",item:var3}});
				var4.addEventListener("validate",this);
			}
			else
			{
				this.validateDrop(var3,1);
			}
		}
		this.gapi.removeCursor();
	}
	function validate(var2)
	{
		if((var var0 = var2.params.targetType) === "validateDrop")
		{
			this.validateDrop((dofus.datacenter.Item)var2.params.item,var2.value);
		}
	}
	function selectItem(var2)
	{
		var var3 = (dofus.datacenter.Item)var2.target.contentData;
		if(var3 == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
			{
				this.api.kernel.GameManager.insertItemInChat(var3);
				return undefined;
			}
			if(Key.isDown(Key.CONTROL))
			{
				var var4 = new ank.utils.();
				for(var i in this._eaGridItems)
				{
					if(this._eaGridItems[i].unicID != var3.unicID)
					{
						var4.push(this._eaGridItems[i]);
					}
				}
				this._eaGridItems = var4;
				this._cgGrid.modelChanged();
			}
			else
			{
				this.hideItemViewer(false);
				this._itvItemViewer.itemData = var3;
			}
		}
	}
}
