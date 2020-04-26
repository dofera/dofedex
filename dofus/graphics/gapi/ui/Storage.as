class dofus.graphics.gapi.ui.Storage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Storage";
	function Storage()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		return this.__get__data();
	}
	function __set__isMount(loc2)
	{
		this._bMount = loc2;
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
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._winItemViewer._visible = !loc2;
	}
	function click(loc2)
	{
		this.callClose();
		var loc0 = loc2.target;
	}
	function selectedItem(loc2)
	{
		if(loc2.item == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2.item;
			switch(loc2.target._name)
			{
				case "_ivInventoryViewer":
					this._ivInventoryViewer2.setFilter(this._ivInventoryViewer.currentFilterID);
					break;
				case "_ivInventoryViewer2":
					this._ivInventoryViewer.setFilter(this._ivInventoryViewer2.currentFilterID);
			}
		}
	}
	function dblClickItem(loc2)
	{
		var loc3 = loc2.item;
		if(loc3 == undefined)
		{
			return undefined;
		}
		if(Key.isDown(Key.ALT) && false)
		{
			var loc4 = new ank.utils.();
			var loc5 = loc2.index;
			if(loc2.target._name == "_ivInventoryViewer")
			{
				loc4 = this._ivInventoryViewer.dataProvider;
				var loc6 = this._ivInventoryViewer.selectedItem;
				var loc7 = true;
			}
			if(loc2.target._name == "_ivInventoryViewer2")
			{
				loc4 = this._ivInventoryViewer2.dataProvider;
				loc6 = this._ivInventoryViewer2.selectedItem;
				loc7 = false;
			}
			if(loc5 == undefined || loc6 == undefined)
			{
				return undefined;
			}
			if(loc5 > loc6)
			{
				var loc8 = loc5;
				loc5 = loc6;
				loc6 = loc8;
			}
			var loc10 = new Array();
			var loc12 = loc5;
			while(loc12 <= loc6)
			{
				var loc9 = loc4[loc12];
				var loc11 = loc9.Quantity;
				if(!(loc11 < 1 || loc11 == undefined))
				{
					loc10.push({Add:loc7,ID:loc9.ID,Quantity:loc11});
				}
				loc12 = loc12 + 1;
			}
			this.api.network.Exchange.movementItems(loc10);
		}
		else
		{
			var loc13 = Key.isDown(Key.CONTROL);
			var loc14 = 1;
			switch(loc2.target._name)
			{
				case "_ivInventoryViewer":
					if(this._bMount)
					{
						var loc15 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(loc3,true);
						if(loc15 <= 0)
						{
							this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
						}
						else
						{
							if(loc13)
							{
								loc14 = loc15;
							}
							this.api.network.Exchange.movementItem(true,loc2.item.ID,loc14);
						}
					}
					else
					{
						if(loc13)
						{
							loc14 = loc3.Quantity;
						}
						this.api.network.Exchange.movementItem(true,loc2.item.ID,loc14);
					}
					break;
				case "_ivInventoryViewer2":
					var loc16 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(loc3,false);
					if(loc16 <= 0)
					{
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
						break;
					}
					if(loc13)
					{
						loc14 = loc16;
					}
					this.api.network.Exchange.movementItem(false,loc2.item.ID,loc14);
					break;
			}
		}
	}
	function modelChanged(loc2)
	{
		this._ivInventoryViewer2.dataProvider = this._oData.inventory;
	}
	function dropItem(loc2)
	{
		switch(loc2.target._name)
		{
			case "_ivInventoryViewer":
				this.api.network.Exchange.movementItem(false,loc2.item.ID,loc2.quantity);
				break;
			case "_ivInventoryViewer2":
				this.api.network.Exchange.movementItem(true,loc2.item.ID,loc2.quantity);
		}
	}
	function dragKama(loc2)
	{
		switch(loc2.target)
		{
			case this._ivInventoryViewer:
				this.api.network.Exchange.movementKama(loc2.quantity);
				break;
			case this._ivInventoryViewer2:
				this.api.network.Exchange.movementKama(- loc2.quantity);
		}
	}
}
