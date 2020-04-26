class dofus.graphics.gapi.ui.ItemUtility extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemUtility";
	function ItemUtility()
	{
		super();
	}
	function __set__item(loc2)
	{
		this._oItem = loc2;
		if(this.initialized)
		{
			this.search(loc2);
		}
		return this.__get__item();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ItemUtility.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
		this.hideCraftsViewer(true);
		this.hideReceiptViewer(true);
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._cbReceiptTypes.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._winReceipt.title = this._oItem.name;
		this._lblReceiptFilter.text = this.api.lang.getText("ITEM_TYPE");
		this._lblNoCrafts.text = this.api.lang.getText("ITEM_UTILITY_NO_CRAFTS");
		this._lblNoReceipt.text = this.api.lang.getText("ITEM_UTILITY_NO_RECEIPT");
		this._lblCrafts.text = this.api.lang.getText("ITEM_UTILITY_CRAFTS");
		this._lblReceipt.text = this.api.lang.getText("ITEM_UTILITY_RECEIPT");
	}
	function initData()
	{
		if(this._oItem != undefined)
		{
			this.search(this._oItem);
		}
	}
	function search(loc2)
	{
		this._eaReceipts = new ank.utils.();
		var loc3 = this.api.lang.getAllCrafts();
		var loc4 = new Array();
		for(var a in loc3)
		{
			if(a == loc2.unicID)
			{
				var loc5 = new ank.utils.();
				loc5.push(this.createCraftObject(Number(a),loc3));
				this._lstReceipt.dataProvider = loc5;
			}
			else
			{
				var loc6 = loc3[a];
				var loc7 = 0;
				while(loc7 < loc6.length)
				{
					if(loc6[loc7][0] == loc2.unicID)
					{
						loc4.push(a);
					}
					loc7 = loc7 + 1;
				}
			}
		}
		var loc8 = new ank.utils.();
		loc8.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		var loc9 = new Object();
		if(loc4.length > 0)
		{
			var loc10 = 0;
			while(loc10 < loc4.length)
			{
				var loc11 = this.createCraftObject(loc4[loc10],loc3);
				var loc12 = loc11.craftItem.type;
				if(!loc9[loc12])
				{
					loc8.push({label:this.api.lang.getItemTypeText(loc12).n,id:loc12});
					loc9[loc12] = true;
				}
				this._eaReceipts.push(loc11);
				loc10 = loc10 + 1;
			}
			this._cbReceiptTypes.dataProvider = loc8;
			this._cbReceiptTypes.selectedIndex = 0;
			this._lstCrafts.dataProvider = this._eaReceipts;
			this.hideCraftsViewer(false);
		}
		else
		{
			this.hideCraftsViewer(true);
		}
		this.hideReceiptViewer(this._lstReceipt.dataProvider.length != 1);
	}
	function createCraftObject(loc2, loc3)
	{
		var loc4 = loc3[loc2];
		var loc5 = new Object();
		loc5.craftItem = new dofus.datacenter.(0,loc2,1);
		loc5.items = new Array();
		var loc6 = 0;
		while(loc6 < loc4.length)
		{
			var loc7 = loc4[loc6][0];
			var loc8 = loc4[loc6][1];
			var loc9 = new dofus.datacenter.(0,loc7,loc8);
			loc5.items.push(loc9);
			loc6 = loc6 + 1;
		}
		return loc5;
	}
	function hideReceiptViewer(loc2)
	{
		this._lstReceipt._visible = !loc2;
		this._lblNoReceipt._visible = loc2;
	}
	function hideCraftsViewer(loc2)
	{
		this._lstCrafts._visible = !loc2;
		this._cbReceiptTypes.enabled = !loc2;
		this._lblNoCrafts._visible = loc2;
	}
	function setReceiptType(loc2)
	{
		var loc3 = new ank.utils.();
		if(loc2 == 0)
		{
			loc3 = this._eaReceipts;
		}
		else
		{
			var loc4 = 0;
			while(loc4 < this._eaReceipts.length)
			{
				var loc5 = this._eaReceipts[loc4];
				if(loc5.craftItem.type == loc2)
				{
					loc3.push(loc5);
				}
				loc4 = loc4 + 1;
			}
		}
		this._lstCrafts.dataProvider = loc3;
		var loc6 = this._cbReceiptTypes.dataProvider;
		var loc7 = 0;
		while(loc7 < loc6.length)
		{
			if(loc6[loc7].id == loc2)
			{
				this._cbReceiptTypes.selectedIndex = loc7;
				return undefined;
			}
			loc7 = loc7 + 1;
		}
	}
	function click(loc2)
	{
		if(loc2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbReceiptTypes")
		{
			this.setReceiptType(this._cbReceiptTypes.selectedItem.id);
		}
	}
}
