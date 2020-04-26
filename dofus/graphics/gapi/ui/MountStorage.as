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
	function __set__mounts(loc2)
	{
		this._eaMount.removeEventListener("modelChanged",this);
		this._eaMount = loc2;
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
	function __set__parkMounts(loc2)
	{
		this._eaParkMounts.removeEventListener("modelChanged",this);
		this._eaParkMounts = loc2;
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
		var loc2 = new ank.utils.();
		var loc3 = this.api.datacenter.Player.Inventory;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = loc3[loc4];
			if(loc5.type == 97)
			{
				loc2.push(loc5);
			}
			loc4 = loc4 + 1;
		}
		return loc2;
	}
	function hideShedButton(loc2)
	{
		this._mcArrowShed._visible = !loc2;
		this._btnShed._visible = !loc2;
	}
	function hideMountParkButton(loc2)
	{
		this._mcArrowMountPark._visible = !loc2;
		this._btnMountPark._visible = !loc2;
	}
	function hideCertificateButton(loc2)
	{
		this._mcArrowCertificate._visible = !loc2;
		this._btnCertificate._visible = !loc2;
	}
	function hideInventoryButton(loc2)
	{
		this._mcArrowInventory._visible = !loc2;
		this._btnInventory._visible = !loc2;
	}
	function hideMountViewer(loc2)
	{
		this._winMountViewer._visible = !loc2;
		this._mvMountViewer._visible = !loc2;
		if(!loc2)
		{
			this.moveTopButtons(0);
			this.moveBottomButtons(0);
		}
	}
	function hideItemViewer(loc2)
	{
		this._winItemViewer._visible = !loc2;
		this._itvItemViewer._visible = !loc2;
		if(!loc2)
		{
			this.moveTopButtons(14);
			this.moveBottomButtons(-13);
		}
	}
	function moveTopButtons(loc2)
	{
		this._btnInventory._y = 146 + loc2;
		this._btnShed._y = 146 + loc2;
	}
	function moveBottomButtons(loc2)
	{
		this._btnCertificate._y = 383 + loc2;
		this._btnMountPark._y = 383 + loc2;
	}
	function hideAllButtons(loc2)
	{
		this.hideShedButton(loc2);
		this.hideMountParkButton(loc2);
		this.hideCertificateButton(loc2);
		this.hideInventoryButton(loc2);
	}
	function hideViewersAndButtons()
	{
		this.hideAllButtons(true);
		this.hideMountViewer(true);
		this.hideItemViewer(true);
	}
	function fillTypeCombobox(loc2, loc3)
	{
		var loc4 = loc2.selectedItem.id;
		var loc5 = loc2.selectedItem.modelID;
		var loc6 = !loc2.dataProvider.length?new ank.utils.():loc2.dataProvider;
		if(!loc2.dataProvider.length)
		{
			loc6.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_MAN"),id:1});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_WOMAN"),id:2});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_FECONDABLE"),id:3});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_FECONDEE"),id:4});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_MOUNTABLE"),id:5});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_NONAME"),id:6});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_CAPACITY"),id:7});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_MUSTXP"),id:8});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_TIRED"),id:9});
			loc6.push({label:this.api.lang.getText("MOUNT_FILTER_NOTIRED"),id:10});
		}
		loc3.sortOn("modelID");
		for(var loc7 in loc3)
		{
			§§enumerate(loc6);
			loop1:
			while((var loc0 = §§enumeration()) != null)
			{
				if(loc6[j].modelID == loc3[i].modelID)
				{
					loc7 = true;
					while(true)
					{
						if(§§pop() == null)
						{
							break loop1;
						}
					}
				}
				else
				{
					continue;
				}
			}
			if(!loc7)
			{
				loc6.push({label:loc3[i].modelName,id:11,modelID:loc3[i].modelID});
			}
		}
		loc6.sortOn(["id","modelName"],Array.NUMERIC);
		var loc8 = -1;
		§§enumerate(loc6);
		while((var loc0 = §§enumeration()) != null)
		{
			if(loc6[i].id == loc4 && loc6[i].modelID == loc5)
			{
				loc8 = _global.parseInt(i);
			}
		}
		loc2.dataProvider = loc6;
		loc2.selectedIndex = loc8 == -1?0:loc8;
	}
	function makeDataProvider(loc2, loc3)
	{
		var loc4 = new ank.utils.();
		var loc5 = loc3.selectedItem.id;
		loop11:
		switch(loc5)
		{
			case 0:
				loc4 = loc2;
				break;
			case 1:
				§§enumerate(loc2);
				while((loc0 = §§enumeration()) != null)
				{
					if(!loc2[i].sex)
					{
						loc4.push(loc2[i]);
					}
				}
				break;
			case 2:
				§§enumerate(loc2);
				while((var loc0 = §§enumeration()) != null)
				{
					if(loc2[i].sex)
					{
						loc4.push(loc2[i]);
					}
				}
				break;
			default:
				switch(null)
				{
					case 3:
						§§enumerate(loc2);
						while((var loc0 = §§enumeration()) != null)
						{
							if(loc2[i].fecondable && loc2[i].fecondation == -1)
							{
								loc4.push(loc2[i]);
							}
						}
						break loop11;
					case 4:
						§§enumerate(loc2);
						while((var loc0 = §§enumeration()) != null)
						{
							if(loc2[i].fecondation > 0)
							{
								loc4.push(loc2[i]);
							}
						}
						break loop11;
					case 5:
						§§enumerate(loc2);
						while((var loc0 = §§enumeration()) != null)
						{
							if(loc2[i].mountable)
							{
								loc4.push(loc2[i]);
							}
						}
						break loop11;
					case 6:
						§§enumerate(loc2);
						while((var loc0 = §§enumeration()) != null)
						{
							if(loc2[i].name == this.api.lang.getText("NO_NAME"))
							{
								loc4.push(loc2[i]);
							}
						}
						break loop11;
					case 7:
						for(var i in loc2)
						{
							if(loc2[i].capacities.length > 0)
							{
								loc4.push(loc2[i]);
							}
						}
						break loop11;
					case 8:
						§§enumerate(loc2);
						while((var loc0 = §§enumeration()) != null)
						{
							if(loc2[i].mountable && loc2[i].level < 5)
							{
								loc4.push(loc2[i]);
							}
						}
						break loop11;
					default:
						switch(null)
						{
							case 9:
								§§enumerate(loc2);
								while((var loc0 = §§enumeration()) != null)
								{
									if(loc2[i].tired == loc2[i].tiredMax)
									{
										loc4.push(loc2[i]);
									}
								}
								break;
							case 10:
								§§enumerate(loc2);
								while((var loc0 = §§enumeration()) != null)
								{
									if(loc2[i].tired < loc2[i].tiredMax)
									{
										loc4.push(loc2[i]);
									}
								}
								break;
							case 11:
								§§enumerate(loc2);
								while((var loc0 = §§enumeration()) != null)
								{
									if(loc2[i].modelID == loc3.selectedItem.modelID)
									{
										loc4.push(loc2[i]);
									}
								}
						}
				}
		}
		break loop10;
	}
	function initialization(loc2)
	{
		var loc3 = loc2.target.content;
		loc3.attachMovie("staticR_front","anim_front",11);
		loc3.attachMovie("staticR_back","anim_back",10);
	}
	function mountChanged(loc2)
	{
		this.hideViewersAndButtons();
		var loc3 = this.api.datacenter.Player.mount;
		var loc4 = loc3 != undefined;
		if(loc4)
		{
			this._lblInventoryMountModel.text = loc3.modelName;
			this._lblInventoryMountName.text = loc3.name;
			this._ldrSprite.forceNextLoad();
			this._ldrSprite.contentPath = loc3.gfxFile;
			var loc5 = new ank.battlefield.datacenter.("-1",undefined,"",0,0);
			loc5.mount = loc3;
			this.api.colors.addSprite(this._ldrSprite,loc5);
		}
		this._lblInventoryNoMount._visible = !loc4;
		this._lblInventoryMountModel._visible = loc4;
		this._lblInventoryMountName._visible = loc4;
		this._ldrSprite._visible = loc4;
		this._mcRectanglePreview._visible = loc4;
	}
	function modelChanged(loc2)
	{
		this.hideViewersAndButtons();
		if((var loc0 = loc2.target) !== this._eaMount)
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
	function click(loc2)
	{
		var loc3 = this.api.network.Exchange;
		if((var loc0 = loc2.target) !== this._btnClose)
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
					if((loc0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE)
					{
						if(loc0 !== dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK)
						{
							if(loc0 === dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY)
							{
								loc3.putInShedFromInventory(this.api.datacenter.Player.mount.ID);
							}
						}
						else
						{
							loc3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
						}
					}
					else
					{
						loc3.putInShedFromCertificate(this._itvItemViewer.itemData.ID);
					}
					break;
				case this._btnInventory:
					if((loc0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_SHED)
					{
						if(loc0 !== dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK)
						{
							if(loc0 !== dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE)
							{
							}
						}
						else
						{
							loc3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
							loc3.putInInventoryFromShed(this._mvMountViewer.mount.ID);
						}
					}
					else
					{
						loc3.putInInventoryFromShed(this._mvMountViewer.mount.ID);
					}
					break;
				case this._btnMountPark:
					if((loc0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_SHED)
					{
						if(loc0 !== dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE)
						{
							if(loc0 === dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY)
							{
								loc3.putInShedFromInventory(this._mvMountViewer.mount.ID);
								loc3.putInMountParkFromShed(this._mvMountViewer.mount.ID);
							}
						}
					}
					else
					{
						loc3.putInMountParkFromShed(this._mvMountViewer.mount.ID);
					}
					break;
				default:
					if(loc0 !== this._btnCertificate)
					{
						break;
					}
					if((loc0 = this._nSelectFrom) !== dofus.graphics.gapi.ui.MountStorage.FROM_SHED)
					{
						if(loc0 !== dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK)
						{
							if(loc0 !== dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY)
							{
								break;
							}
							loc3.putInShedFromInventory(this._mvMountViewer.mount.ID);
							loc3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
							break;
						}
						loc3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
						loc3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
						break;
					}
					loc3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
					break;
			}
		}
		else
		{
			this.callClose();
		}
	}
	function itemSelected(loc2)
	{
		this.hideAllButtons(false);
		loop0:
		switch(loc2.target)
		{
			case this._lstShed:
				this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_SHED;
				this._mvMountViewer.mount = loc2.row.item;
				this.hideItemViewer(true);
				this.hideShedButton(true);
				this.hideMountViewer(false);
				break;
			case this._lstMountPark:
				this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK;
				this._mvMountViewer.mount = loc2.row.item;
				this.hideItemViewer(true);
				this.hideMountParkButton(true);
				this.hideMountViewer(false);
				break;
			default:
				switch(null)
				{
					case this._lstCertificate:
						this.hideMountParkButton(true);
						this.hideInventoryButton(true);
						this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE;
						this._itvItemViewer.itemData = loc2.row.item;
						this.hideCertificateButton(true);
						this.hideMountViewer(true);
						this.hideItemViewer(false);
						break loop0;
					case this._cbFilterShed:
						this._lstShed.dataProvider = this.makeDataProvider(this._eaMount,this._cbFilterShed);
						this.hideViewersAndButtons();
						break loop0;
					case this._cbFilterPark:
						this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts,this._cbFilterPark);
						this.hideViewersAndButtons();
						break loop0;
					default:
						this.hideViewersAndButtons();
				}
		}
	}
	function itemRollOver(loc2)
	{
		switch(loc2.target)
		{
			case this._lstCertificate:
				break;
			case this._lstMountPark:
			case this._lstShed:
				this.gapi.showTooltip(loc2.row.item.getToolTip(),loc2.target,20,{bXLimit:true,bYLimit:false});
		}
	}
	function itemRollOut(loc2)
	{
		this.gapi.hideTooltip();
	}
	function nameChanged(loc2)
	{
		this._lblInventoryMountName.text = loc2.name;
	}
}
