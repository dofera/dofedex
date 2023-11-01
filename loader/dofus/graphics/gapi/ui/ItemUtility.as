class dofus.graphics.gapi.ui.ItemUtility extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemUtility";
	function ItemUtility()
	{
		super();
	}
	function __set__item(var2)
	{
		this._oItem = var2;
		if(this.initialized)
		{
			this.search(var2);
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
	function search(var2)
	{
		this._eaReceipts = new ank.utils.();
		var var3 = this.api.lang.getAllCrafts();
		var var4 = new Array();
		for(var a in var3)
		{
			if(a == var2.unicID)
			{
				var var5 = new ank.utils.();
				var5.push(this.createCraftObject(Number(a),var3));
				this._lstReceipt.dataProvider = var5;
			}
			else
			{
				var var6 = var3[a];
				var var7 = 0;
				while(var7 < var6.length)
				{
					if(var6[var7][0] == var2.unicID)
					{
						var4.push(a);
					}
					var7 = var7 + 1;
				}
			}
		}
		var var8 = new ank.utils.();
		var8.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		var var9 = new Object();
		if(var4.length > 0)
		{
			var var10 = 0;
			while(var10 < var4.length)
			{
				var var11 = this.createCraftObject(var4[var10],var3);
				var var12 = var11.craftItem.type;
				if(!var9[var12])
				{
					var8.push({label:this.api.lang.getItemTypeText(var12).n,id:var12});
					var9[var12] = true;
				}
				this._eaReceipts.push(var11);
				var10 = var10 + 1;
			}
			this._cbReceiptTypes.dataProvider = var8;
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
	function createCraftObject(var2, var3)
	{
		var var4 = var3[var2];
		var var5 = new Object();
		var5.craftItem = new dofus.datacenter.(0,var2,1);
		var5.items = new Array();
		var var6 = 0;
		while(var6 < var4.length)
		{
			var var7 = var4[var6][0];
			var var8 = var4[var6][1];
			var var9 = new dofus.datacenter.(0,var7,var8);
			var5.items.push(var9);
			var6 = var6 + 1;
		}
		return var5;
	}
	function hideReceiptViewer(var2)
	{
		this._lstReceipt._visible = !var2;
		this._lblNoReceipt._visible = var2;
	}
	function hideCraftsViewer(var2)
	{
		this._lstCrafts._visible = !var2;
		this._cbReceiptTypes.enabled = !var2;
		this._lblNoCrafts._visible = var2;
	}
	function setReceiptType(var2)
	{
		var var3 = new ank.utils.();
		if(var2 == 0)
		{
			var3 = this._eaReceipts;
		}
		else
		{
			var var4 = 0;
			while(var4 < this._eaReceipts.length)
			{
				var var5 = this._eaReceipts[var4];
				if(var5.craftItem.type == var2)
				{
					var3.push(var5);
				}
				var4 = var4 + 1;
			}
		}
		this._lstCrafts.dataProvider = var3;
		var var6 = this._cbReceiptTypes.dataProvider;
		var var7 = 0;
		while(var7 < var6.length)
		{
			if(var6[var7].id == var2)
			{
				this._cbReceiptTypes.selectedIndex = var7;
				return undefined;
			}
			var7 = var7 + 1;
		}
	}
	function click(var2)
	{
		if(var2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
	}
	function itemSelected(var2)
	{
		if((var var0 = var2.target._name) === "_cbReceiptTypes")
		{
			this.setReceiptType(this._cbReceiptTypes.selectedItem.id);
		}
	}
}
