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
		this._eaItems = new ank.utils.();
		this._tiQuantity.restrict = "0-9";
		this._tiQuantity.text = "1";
		var var2 = new ank.utils.();
		var var3 = this.api.lang.getAllItemTypes();
		for(var a in var3)
		{
			var2.push({label:var3[a].n,id:a});
		}
		var2.sortOn("label");
		var2.push({label:"All",id:-1});
		this._cbType.dataProvider = var2;
	}
	function hideItemViewer(var2)
	{
		this._winItemViewer._visible = !var2;
		this._itvItemViewer._visible = !var2;
	}
	function generateIndexes()
	{
		var var2 = new Object();
		for(var k in this._aTypes)
		{
			var2[this._aTypes[k]] = true;
		}
		var var3 = this.api.lang.getItemUnics();
		this._eaItems = new ank.utils.();
		this._eaItemsOriginal = new ank.utils.();
		for(var k in var3)
		{
			var var4 = var3[k];
			if(!(var4.ep != undefined && var4.ep > this.api.datacenter.Basics.aks_current_regional_version))
			{
				if(var2[var4.t])
				{
					var var5 = var4.n;
					this._eaItems.push({id:k,name:var5.toUpperCase()});
					this._eaItemsOriginal.push(new dofus.datacenter.(0,Number(k)));
				}
			}
		}
		this._lblNumber.text = this._eaItemsOriginal.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",this._eaItemsOriginal.length < 2);
	}
	function searchItem(var2)
	{
		var var3 = var2.split(" ");
		var var4 = new ank.utils.();
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
				var4.push(new dofus.datacenter.(0,Number(k)));
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
		if(this._lst.selectedItem == undefined)
		{
			return undefined;
		}
		this.dispatchEvent({type:"select",ui:"ItemSelector",itemId:this._lst.selectedItem.unicID,itemQuantity:this._tiQuantity.text});
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
}
