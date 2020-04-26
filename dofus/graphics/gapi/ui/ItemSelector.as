class dofus.graphics.gapi.ui.ItemSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemSelector";
	function ItemSelector()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ItemSelector.CLASS_NAME);
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
		this._btnSelect.label = this.api.lang.getText("SELECT");
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
	}
	function initData()
	{
		this._eaItems = new ank.utils.();
		this._tiQuantity.restrict = "0-9";
		this._tiQuantity.text = "1";
		var loc2 = new ank.utils.();
		var loc3 = this.api.lang.getAllItemTypes();
		for(var a in loc3)
		{
			loc2.push({label:loc3[a].n,id:a});
		}
		loc2.sortOn("label");
		loc2.push({label:"All",id:-1});
		this._cbType.dataProvider = loc2;
	}
	function hideItemViewer(loc2)
	{
		this._winItemViewer._visible = !loc2;
		this._itvItemViewer._visible = !loc2;
	}
	function generateIndexes()
	{
		var loc2 = new Object();
		for(var k in this._aTypes)
		{
			loc2[this._aTypes[k]] = true;
		}
		var loc3 = this.api.lang.getItemUnics();
		this._eaItems = new ank.utils.();
		this._eaItemsOriginal = new ank.utils.();
		for(var k in loc3)
		{
			var loc4 = loc3[k];
			if(!(loc4.ep != undefined && loc4.ep > this.api.datacenter.Basics.aks_current_regional_version))
			{
				if(loc2[loc4.t])
				{
					var loc5 = loc4.n;
					this._eaItems.push({id:k,name:loc5.toUpperCase()});
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
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.dispatchEvent({type:"cancel"});
				this.callClose();
			case "_btnSelect":
				if(this._lst.selectedItem == undefined)
				{
					return undefined;
				}
				this.dispatchEvent({type:"select",ui:"ItemSelector",itemId:this._lst.selectedItem.unicID,itemQuantity:this._tiQuantity.text});
				break;
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
}
