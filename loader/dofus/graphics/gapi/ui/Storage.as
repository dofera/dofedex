class dofus.graphics.gapi.ui.Storage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Storage";
	function Storage()
	{
		super();
	}
	function __set__data(var2)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __set__isMount(var2)
	{
		this._bMount = var2;
		return this.__get__isMount();
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
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
	}
	function click(var2)
	{
		this.callClose();
		var var0 = var2.target;
	}
	function selectedItem(var2)
	{
		if(var2.item == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.item;
			switch(var2.target._name)
			{
				case "_ivInventoryViewer":
					this._ivInventoryViewer2.setFilter(this._ivInventoryViewer.currentFilterID);
					break;
				case "_ivInventoryViewer2":
					this._ivInventoryViewer.setFilter(this._ivInventoryViewer2.currentFilterID);
			}
		}
	}
	function dblClickItem(var2)
	{
		var var3 = var2.item;
		if(var3 == undefined)
		{
			return undefined;
		}
		var var13 = Key.isDown(Key.CONTROL);
		var var14 = 1;
		switch(var2.target._name)
		{
			case "_ivInventoryViewer":
				§§push(Key.isDown(Key.ALT));
				if(this._bMount)
				{
					var var15 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(var3,true);
					if(var15 <= 0)
					{
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
					}
					else
					{
						if(var13)
						{
							var14 = var15;
						}
						this.api.network.Exchange.movementItem(true,var2.item.ID,var14);
					}
				}
				else
				{
					if(var13)
					{
						var14 = var3.Quantity;
					}
					this.api.network.Exchange.movementItem(true,var2.item.ID,var14);
				}
				break;
			case "_ivInventoryViewer2":
				var var16 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(var3,false);
				if(var16 <= 0)
				{
					this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
					break;
				}
				if(var13)
				{
					var14 = var16;
				}
				this.api.network.Exchange.movementItem(false,var2.item.ID,var14);
				break;
		}
	}
	function modelChanged(var2)
	{
		this._ivInventoryViewer2.dataProvider = this._oData.inventory;
	}
	function dropItem(var2)
	{
		switch(var2.target._name)
		{
			case "_ivInventoryViewer":
				this.api.network.Exchange.movementItem(false,var2.item.ID,var2.quantity);
				break;
			case "_ivInventoryViewer2":
				this.api.network.Exchange.movementItem(true,var2.item.ID,var2.quantity);
		}
	}
	function dragKama(var2)
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
