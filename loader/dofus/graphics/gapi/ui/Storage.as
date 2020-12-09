class dofus.graphics.gapi.ui.Storage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Storage";
	function Storage()
	{
		super();
	}
	function __set__data(§\x1e\x1a\x02§)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __set__isMount(§\x17\x1a§)
	{
		this._bMount = var2;
		return this.__get__isMount();
	}
	function __get__currentOverItem()
	{
		if(this._ivInventoryViewer != undefined && this._ivInventoryViewer.currentOverItem != undefined)
		{
			return this._ivInventoryViewer.currentOverItem;
		}
		if(this._ivInventoryViewer2 != undefined && this._ivInventoryViewer2.currentOverItem != undefined)
		{
			return this._ivInventoryViewer2.currentOverItem;
		}
		return undefined;
	}
	function __get__itemViewer()
	{
		return this._itvItemViewer;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Storage.CLASS_NAME);
	}
	function callClose()
	{
		if(this._bMount == true)
		{
			this.api.ui.loadUIComponent("Mount","Mount");
		}
		this.api.network.Exchange.leave();
		return true;
	}
	function createChildren()
	{
		if(this._bMount != true)
		{
			this._pbPods._visible = false;
		}
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.hideItemViewer(true);
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._ivInventoryViewer.addEventListener("selectedItem",this);
		this._ivInventoryViewer.addEventListener("dblClickItem",this);
		this._ivInventoryViewer.addEventListener("dropItem",this);
		this._ivInventoryViewer.addEventListener("dragKama",this);
		this._ivInventoryViewer2.addEventListener("selectedItem",this);
		this._ivInventoryViewer2.addEventListener("dblClickItem",this);
		this._ivInventoryViewer2.addEventListener("dropItem",this);
		this._ivInventoryViewer2.addEventListener("dragKama",this);
		if(this._oData != undefined)
		{
			this._oData.addEventListener("modelChanged",this);
		}
		else
		{
			ank.utils.Logger.err("[Storage] il n\'y a pas de data");
		}
	}
	function initTexts()
	{
		this._winInventory.title = this.api.datacenter.Player.data.name;
		if(this._bMount != true)
		{
			this._winInventory2.title = this.api.lang.getText("STORAGE");
		}
		else
		{
			this._winInventory2.title = this.api.lang.getText("MY_MOUNT");
		}
	}
	function initData()
	{
		if(this._bMount == true)
		{
			this._ivInventoryViewer.showKamas = false;
			this._ivInventoryViewer2.showKamas = false;
		}
		this._ivInventoryViewer.dataProvider = this.api.datacenter.Player.Inventory;
		this._ivInventoryViewer.kamasProvider = this.api.datacenter.Player;
		this._ivInventoryViewer2.kamasProvider = this._oData;
		this._ivInventoryViewer.checkPlayerPods = true;
		this._ivInventoryViewer2.checkMountPods = this._bMount;
		this.modelChanged();
	}
	function hideItemViewer(§\x19\x0e§)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
	}
	function click(§\x1e\x19\x18§)
	{
		this.callClose();
		var var0 = var2.target;
	}
	function selectedItem(§\x1e\x19\x18§)
	{
		if(var2.item == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.item;
			if((var var0 = var2.target._name) !== "_ivInventoryViewer")
			{
				if(var0 === "_ivInventoryViewer2")
				{
					this._ivInventoryViewer.setFilter(this._ivInventoryViewer2.currentFilterID);
				}
			}
			else
			{
				this._ivInventoryViewer2.setFilter(this._ivInventoryViewer.currentFilterID);
			}
		}
	}
	function dblClickItem(§\x1e\x19\x18§)
	{
		var var3 = var2.item;
		var var4 = var2.targets;
		if(var3 == undefined)
		{
			return undefined;
		}
		var var5 = Key.isDown(dofus.Constants.SELECT_MULTIPLE_ITEMS_KEY);
		switch(var2.target._name)
		{
			case "_ivInventoryViewer":
				if(var5 && var4.length > 1)
				{
					this.moveItems(var4,true);
				}
				else
				{
					this.moveItem(var3,true,var5);
				}
				break;
			case "_ivInventoryViewer2":
				if(var5 && var4.length > 1)
				{
					this.moveItems(var4,false);
					break;
				}
				this.moveItem(var3,false,var5);
				break;
		}
	}
	function moveItems(§\x1e\x10§, §\x1c\x1a§)
	{
		if((var3 && this._bMount || !var3) && !this.api.datacenter.Player.canReceiveItems(var2,var3 && this._bMount))
		{
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
			return undefined;
		}
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2[var5];
			var4.push({Add:var3,ID:var6.ID,Quantity:var6.Quantity});
			var5 = var5 + 1;
		}
		this.api.network.Exchange.movementItems(var4);
	}
	function moveItem(§\x1e\x19\r§, §\x1c\x1a§, §\x17\x17§)
	{
		var var5 = var2.Quantity;
		if(var3 && this._bMount || !var3)
		{
			var5 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(var2,var3 && this._bMount);
			if(var5 <= 0)
			{
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
				return undefined;
			}
		}
		var var6 = 1;
		if(var4)
		{
			var6 = var5;
		}
		this.api.network.Exchange.movementItem(var3,var2,var6);
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		this._ivInventoryViewer2.dataProvider = this._oData.inventory;
	}
	function dropItem(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_ivInventoryViewer":
				this.api.network.Exchange.movementItem(false,var2.item,var2.quantity);
				break;
			case "_ivInventoryViewer2":
				this.api.network.Exchange.movementItem(true,var2.item,var2.quantity);
		}
	}
	function dragKama(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._ivInventoryViewer:
				this.api.network.Exchange.movementKama(var2.quantity);
				break;
			case this._ivInventoryViewer2:
				this.api.network.Exchange.movementKama(- var2.quantity);
		}
	}
}
