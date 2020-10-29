class dofus.graphics.gapi.ui.MountStorage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MountStorage";
	static var FROM_SHED = 0;
	static var FROM_MOUNTPARK = 1;
	static var FROM_CERTIFICATE = 2;
	static var FROM_INVENTORY = 3;
	function MountStorage()
	{
		super();
	}
	function __set__mounts(var2)
	{
		this._eaMount.removeEventListener("modelChanged",this);
		this._eaMount = var2;
		this._eaMount.addEventListener("modelChanged",this);
		if(this.initialized)
		{
			this.modelChanged({target:this._eaMount});
		}
		return this.__get__mounts();
	}
	function __get__mounts()
	{
		return this._eaMount;
	}
	function __set__parkMounts(var2)
	{
		this._eaParkMounts.removeEventListener("modelChanged",this);
		this._eaParkMounts = var2;
		this._eaParkMounts.addEventListener("modelChanged",this);
		if(this.initialized)
		{
			this.modelChanged({target:this._eaParkMounts});
		}
		return this.__get__parkMounts();
	}
	function __get__parkMounts()
	{
		return this._eaParkMounts;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MountStorage.CLASS_NAME);
	}
	function callClose()
	{
		this.api.network.Exchange.leave();
		return true;
	}
	function createChildren()
	{
		this.hideViewersAndButtons();
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
		this.gapi.unloadLastUIAutoHideComponent();
	}
	function addListeners()
	{
		this.api.datacenter.Player.addEventListener("mountChanged",this);
		this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
		this.api.datacenter.Player.mount.addEventListener("nameChanged",this);
		this._cbFilterShed.addEventListener("itemSelected",this);
		this._cbFilterPark.addEventListener("itemSelected",this);
		this._lstCertificate.addEventListener("itemSelected",this);
		this._lstCertificate.addEventListener("itemRollOver",this);
		this._lstCertificate.addEventListener("itemRollOut",this);
		this._lstMountPark.addEventListener("itemSelected",this);
		this._lstMountPark.addEventListener("itemRollOver",this);
		this._lstMountPark.addEventListener("itemRollOut",this);
		this._lstShed.addEventListener("itemSelected",this);
		this._lstShed.addEventListener("itemRollOver",this);
		this._lstShed.addEventListener("itemRollOut",this);
		this._btnClose.addEventListener("click",this);
		this._btnShed.addEventListener("click",this);
		this._btnMountPark.addEventListener("click",this);
		this._btnCertificate.addEventListener("click",this);
		this._btnInventory.addEventListener("click",this);
		this._ldrSprite.addEventListener("initialization",this);
		this._mcRectanglePreview.onRelease = function()
		{
			this._parent.click({target:this._parent._btnInventoryMount});
		};
	}
	function initTexts()
	{
		this._winCertificate.title = this.api.lang.getText("MOUNT_CERTIFICATES");
		this._winMountPark.title = this.api.lang.getText("MOUNT_PARK");
		this._winInventory.title = this.api.lang.getText("MOUNT_INVENTORY");
		this._winShed.title = this.api.lang.getText("MOUNT_SHED");
		this._btnShed.label = this.api.lang.getText("MOUNT_SHED_ACTION");
		this._btnMountPark.label = this.api.lang.getText("MOUNT_PARK_ACTION");
		this._btnCertificate.label = this.api.lang.getText("MOUNT_CERTIFICATE_ACTION");
		this._btnInventory.label = this.api.lang.getText("MOUNT_INVENTORY_ACTION");
		this._lblTitle.text = this.api.lang.getText("MOUNT_MANAGER");
		this._lblInventoryNoMount.text = this.api.lang.getText("MOUNT_NO_EQUIP");
		this.fillTypeCombobox(this._cbFilterShed,this.mounts.concat(this.parkMounts));
		this.fillTypeCombobox(this._cbFilterPark,this.mounts.concat(this.parkMounts));
	}
	function initData()
	{
		this.modelChanged({target:this._eaMount});
		this.modelChanged({target:this._eaParkMounts});
		this.modelChanged({target:this.api.datacenter.Player.Inventory});
		this.mountChanged();
	}
	function createCertificateArray()
	{
		var var2 = new ank.utils.();
		var var3 = this.api.datacenter.Player.Inventory;
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4];
			if(var5.type == 97)
			{
				var2.push(var5);
			}
			var4 = var4 + 1;
		}
		return var2;
	}
	function hideShedButton(var2)
	{
		this._mcArrowShed._visible = !var2;
		this._btnShed._visible = !var2;
	}
	function hideMountParkButton(var2)
	{
		this._mcArrowMountPark._visible = !var2;
		this._btnMountPark._visible = !var2;
	}
	function hideCertificateButton(var2)
	{
		this._mcArrowCertificate._visible = !var2;
		this._btnCertificate._visible = !var2;
	}
	function hideInventoryButton(var2)
	{
		this._mcArrowInventory._visible = !var2;
		this._btnInventory._visible = !var2;
	}
	function hideMountViewer(var2)
	{
		this._winMountViewer._visible = !var2;
		this._mvMountViewer._visible = !var2;
		if(!var2)
		{
			this.moveTopButtons(0);
			this.moveBottomButtons(0);
		}
	}
	function hideItemViewer(var2)
	{
		this._winItemViewer._visible = !var2;
		this._itvItemViewer._visible = !var2;
		if(!var2)
		{
			this.moveTopButtons(14);
			this.moveBottomButtons(-13);
		}
	}
	function moveTopButtons(var2)
	{
		this._btnInventory._y = 146 + var2;
		this._btnShed._y = 146 + var2;
	}
	function moveBottomButtons(var2)
	{
		this._btnCertificate._y = 383 + var2;
		this._btnMountPark._y = 383 + var2;
	}
	function hideAllButtons(var2)
	{
		this.hideShedButton(var2);
		this.hideMountParkButton(var2);
		this.hideCertificateButton(var2);
		this.hideInventoryButton(var2);
	}
	function hideViewersAndButtons()
	{
		this.hideAllButtons(true);
		this.hideMountViewer(true);
		this.hideItemViewer(true);
	}
	function fillTypeCombobox(var2, var3)
	{
		var var4 = var2.selectedItem.id;
		var var5 = var2.selectedItem.modelID;
		var var6 = !var2.dataProvider.length?new ank.utils.():var2.dataProvider;
		if(!var2.dataProvider.length)
		{
			var6.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_MAN"),id:1});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_WOMAN"),id:2});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_FECONDABLE"),id:3});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_FECONDEE"),id:4});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_MOUNTABLE"),id:5});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_NONAME"),id:6});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_CAPACITY"),id:7});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_MUSTXP"),id:8});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_TIRED"),id:9});
			var6.push({label:this.api.lang.getText("MOUNT_FILTER_NOTIRED"),id:10});
		}
		var3.sortOn("modelID");
		for(var i in var3)
		{
			var var7 = false;
			for(var j in var6)
			{
				if(var6[j].modelID == var3[i].modelID)
				{
					var7 = true;
					break;
				}
			}
			if(!var7)
			{
				var6.push({label:var3[i].modelName,id:11,modelID:var3[i].modelID});
			}
		}
		var6.sortOn(["id","modelName"],Array.NUMERIC);
		var var8 = -1;
		for(var i in var6)
		{
			if(var6[i].id == var4 && var6[i].modelID == var5)
			{
				var8 = _global.parseInt(i);
			}
		}
		var2.dataProvider = var6;
		var2.selectedIndex = var8 == -1?0:var8;
	}
	function makeDataProvider(var2, var3)
	{
		var var4 = new ank.utils.();
		var var5 = var3.selectedItem.id;
		loop11:
		switch(var5)
		{
			case 0:
				var4 = var2;
				break;
			case 1:
				for(var i in var2)
				{
					if(!var2[i].sex)
					{
						var4.push(var2[i]);
					}
				}
				break;
			case 2:
				for(var i in var2)
				{
					if(var2[i].sex)
					{
						var4.push(var2[i]);
					}
				}
				break;
			default:
				switch(null)
				{
					case 3:
						for(var i in var2)
						{
							if(var2[i].fecondable && var2[i].fecondation == -1)
							{
								var4.push(var2[i]);
							}
						}
						break loop11;
					case 4:
						for(var i in var2)
						{
							if(var2[i].fecondation > 0)
							{
								var4.push(var2[i]);
							}
						}
						break loop11;
					case 5:
						for(var i in var2)
						{
							if(var2[i].mountable)
							{
								var4.push(var2[i]);
							}
						}
						break loop11;
					case 6:
						for(var i in var2)
						{
							if(var2[i].name == this.api.lang.getText("NO_NAME"))
							{
								var4.push(var2[i]);
							}
						}
						break loop11;
					case 7:
						for(var i in var2)
						{
							if(var2[i].capacities.length > 0)
							{
								var4.push(var2[i]);
							}
						}
						break loop11;
					default:
						switch(null)
						{
							case 8:
								for(var i in var2)
								{
									if(var2[i].mountable && var2[i].level < 5)
									{
										var4.push(var2[i]);
									}
								}
								break;
							case 9:
								for(var i in var2)
								{
									if(var2[i].tired == var2[i].tiredMax)
									{
										var4.push(var2[i]);
									}
								}
								break;
							case 10:
								for(var i in var2)
								{
									if(var2[i].tired < var2[i].tiredMax)
									{
										var4.push(var2[i]);
									}
								}
								break;
							case 11:
								for(var i in var2)
								{
									if(var2[i].modelID == var3.selectedItem.modelID)
									{
										var4.push(var2[i]);
									}
								}
						}
				}
		}
		break loop10;
	}
	function initialization(var2)
	{
		var var3 = var2.target.content;
		var3.attachMovie("staticR_front","anim_front",11);
		var3.attachMovie("staticR_back","anim_back",10);
	}
	function mountChanged(var2)
	{
		this.hideViewersAndButtons();
		var var3 = this.api.datacenter.Player.mount;
		var var4 = var3 != undefined;
		if(var4)
		{
			this._lblInventoryMountModel.text = var3.modelName;
			this._lblInventoryMountName.text = var3.name;
			this._ldrSprite.forceNextLoad();
			this._ldrSprite.contentPath = var3.gfxFile;
			var var5 = new ank.battlefield.datacenter.("-1",undefined,"",0,0);
			var5.mount = var3;
			this.api.colors.addSprite(this._ldrSprite,var5);
		}
		this._lblInventoryNoMount._visible = !var4;
		this._lblInventoryMountModel._visible = var4;
		this._lblInventoryMountName._visible = var4;
		this._ldrSprite._visible = var4;
		this._mcRectanglePreview._visible = var4;
	}
	function modelChanged(var2)
	{
		this.hideViewersAndButtons();
		if((var var0 = var2.target) !== this._eaMount)
		{
			switch(null)
			{
				case this._eaParkMounts:
					this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts,this._cbFilterPark);
					this._lstShed.sortOn("modelID");
					this.fillTypeCombobox(this._cbFilterShed,this.mounts.concat(this.parkMounts));
					this.fillTypeCombobox(this._cbFilterPark,this.mounts.concat(this.parkMounts));
					break;
				case this.api.datacenter.Player.Inventory:
					this._lstCertificate.dataProvider = this.createCertificateArray();
			}
		}
		else
		{
			this._lstShed.dataProvider = this.makeDataProvider(this._eaMount,this._cbFilterShed);
			this._lstShed.sortOn("modelID");
			this.fillTypeCombobox(this._cbFilterShed,this.mounts.concat(this.parkMounts));
			this.fillTypeCombobox(this._cbFilterPark,this.mounts.concat(this.parkMounts));
		}
	}
	function click(var2)
	{
		var var3 = this.api.network.Exchange;
		if((var var0 = var2.target) !== this._btnClose)
		{
			switch(null)
			{
				case this._btnInventoryMount:
					this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY;
					this._mvMountViewer.mount = this.api.datacenter.Player.mount;
					this.hideAllButtons(false);
					this.hideItemViewer(true);
					this.hideMountViewer(false);
					this.hideInventoryButton(true);
					break;
				case this._btnShed:
					if((var0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE)
					{
						if(var0 !== dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK)
						{
							if(var0 === dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY)
							{
								var3.putInShedFromInventory(this.api.datacenter.Player.mount.ID);
							}
						}
						else
						{
							var3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
						}
					}
					else
					{
						var3.putInShedFromCertificate(this._itvItemViewer.itemData.ID);
					}
					break;
				case this._btnInventory:
					if((var0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_SHED)
					{
						if(var0 !== dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK)
						{
							if(var0 !== dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE)
							{
							}
						}
						else
						{
							var3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
							var3.putInInventoryFromShed(this._mvMountViewer.mount.ID);
						}
					}
					else
					{
						var3.putInInventoryFromShed(this._mvMountViewer.mount.ID);
					}
					break;
				default:
					switch(null)
					{
						case this._btnMountPark:
							if((var0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_SHED)
							{
								if(var0 !== dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE)
								{
									if(var0 === dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY)
									{
										var3.putInShedFromInventory(this._mvMountViewer.mount.ID);
										var3.putInMountParkFromShed(this._mvMountViewer.mount.ID);
									}
								}
							}
							else
							{
								var3.putInMountParkFromShed(this._mvMountViewer.mount.ID);
							}
							break;
						case this._btnCertificate:
							if((var0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_SHED)
							{
								if(var0 !== dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK)
								{
									if(var0 === dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY)
									{
										var3.putInShedFromInventory(this._mvMountViewer.mount.ID);
										var3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
									}
								}
								else
								{
									var3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
									var3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
								}
							}
							else
							{
								var3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
							}
					}
			}
		}
		else
		{
			this.callClose();
		}
	}
	function itemSelected(var2)
	{
		this.hideAllButtons(false);
		if((var var0 = var2.target) !== this._lstShed)
		{
			switch(null)
			{
				case this._lstMountPark:
					this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK;
					this._mvMountViewer.mount = var2.row.item;
					this.hideItemViewer(true);
					this.hideMountParkButton(true);
					this.hideMountViewer(false);
					break;
				case this._lstCertificate:
					this.hideMountParkButton(true);
					this.hideInventoryButton(true);
					this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE;
					this._itvItemViewer.itemData = var2.row.item;
					this.hideCertificateButton(true);
					this.hideMountViewer(true);
					this.hideItemViewer(false);
					break;
				case this._cbFilterShed:
					this._lstShed.dataProvider = this.makeDataProvider(this._eaMount,this._cbFilterShed);
					this.hideViewersAndButtons();
					break;
				default:
					if(var0 !== this._cbFilterPark)
					{
						this.hideViewersAndButtons();
						break;
					}
					this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts,this._cbFilterPark);
					this.hideViewersAndButtons();
					break;
			}
		}
		else
		{
			this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_SHED;
			this._mvMountViewer.mount = var2.row.item;
			this.hideItemViewer(true);
			this.hideShedButton(true);
			this.hideMountViewer(false);
		}
	}
	function itemRollOver(var2)
	{
		switch(var2.target)
		{
			case this._lstCertificate:
				break;
			case this._lstMountPark:
			case this._lstShed:
				this.gapi.showTooltip(var2.row.item.getToolTip(),var2.target,20,{bXLimit:true,bYLimit:false});
		}
	}
	function itemRollOut(var2)
	{
		this.gapi.hideTooltip();
	}
	function nameChanged(var2)
	{
		this._lblInventoryMountName.text = var2.name;
	}
}
