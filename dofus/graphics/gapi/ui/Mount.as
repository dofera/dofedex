class dofus.graphics.gapi.ui.Mount extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Mount";
	function Mount()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Mount.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.mountChanged,params:[{mount:this.api.datacenter.Player.mount}]});
	}
	function addListeners()
	{
		this._btnNameValid.addEventListener("click",this);
		this._btnName.addEventListener("click",this);
		this._btnName.addEventListener("over",this);
		this._btnName.addEventListener("out",this);
		this._btnXP.addEventListener("click",this);
		this._btnXP.addEventListener("over",this);
		this._btnXP.addEventListener("out",this);
		this._btnRide.addEventListener("click",this);
		this._btnRide.addEventListener("over",this);
		this._btnRide.addEventListener("out",this);
		this._btnInventory.addEventListener("click",this);
		this._btnInventory.addEventListener("over",this);
		this._btnInventory.addEventListener("out",this);
		this._btnAction.addEventListener("click",this);
		this._btnAction.addEventListener("over",this);
		this._btnAction.addEventListener("out",this);
		this.api.datacenter.Player.addEventListener("mountXPPercentChanged",this);
		this.api.datacenter.Player.addEventListener("mountChanged",this);
		this._btnClose.addEventListener("click",this);
	}
	function initData()
	{
		this.mountChanged();
	}
	function initTexts()
	{
		this._win.title = this.api.lang.getText("MY_MOUNT");
		this._lblName.text = this.api.lang.getText("NAME_BIG");
		this._lblPercentXP.text = this.api.lang.getText("MOUNT_PERCENT_XP");
		this._lblInventory.text = this.api.lang.getText("MOUNT_INVENTORY_2");
	}
	function editName(loc2)
	{
		this._tiName._visible = loc2;
		this._btnNameValid._visible = loc2;
		this._mcTextInputBackground._visible = loc2;
		this._lblNameValue._visible = !loc2;
		this._btnName._visible = !loc2;
	}
	function mountXPPercentChanged(loc2)
	{
		this._lblPercentXPValue.text = this.api.datacenter.Player.mountXPPercent + "%";
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target)
		{
			case this._btnNameValid:
				if(this._tiName.text != "")
				{
					this.api.network.Mount.rename(this._tiName.text);
				}
				break;
			case this._btnName:
				this.editName(true);
				break;
			case this._btnXP:
				var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Player.mountXPPercent,max:90});
				loc3.addEventListener("validate",this);
				break;
			default:
				switch(null)
				{
					case this._btnClose:
						this.callClose();
						break loop0;
					case this._btnRide:
						this.api.network.Mount.ride();
						break loop0;
					case this._btnInventory:
						this.api.network.Exchange.request(15);
						break loop0;
					default:
						if(loc0 !== this._btnAction)
						{
							break loop0;
						}
						var loc4 = this.api.ui.createPopupMenu();
						var loc5 = this.api.datacenter.Player.mount;
						loc4.addStaticItem(loc5.name);
						loc4.addItem(this.api.lang.getText("MOUNT_CASTRATE_TOOLTIP"),this,this.castrateMount);
						loc4.addItem(this.api.lang.getText("MOUNT_KILL_TOOLTIP"),this,this.killMount);
						loc4.show(_root._xmouse,_root._ymouse);
						break loop0;
				}
		}
	}
	function castrateMount()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_CASTRATE_YOUR_MOUNT"),"CAUTION_YESNO",{name:"CastrateMount",listener:this});
	}
	function killMount()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_KILL_YOUR_MOUNT"),"CAUTION_YESNO",{name:"KillMount",listener:this});
	}
	function nameChanged(loc2)
	{
		var loc3 = this.api.datacenter.Player.mount;
		this._lblNameValue.text = loc3.name;
		this._tiName.text = loc3.name;
		this.editName(false);
	}
	function mountChanged(loc2)
	{
		var loc3 = this.api.datacenter.Player.mount;
		if(loc3 != undefined)
		{
			loc3.addEventListener("nameChanged",this);
			this._mvMountViewer.mount = loc3;
			this.mountXPPercentChanged();
			this.nameChanged();
		}
		else
		{
			this.callClose();
		}
	}
	function validate(loc2)
	{
		var loc3 = loc2.value;
		if(_global.isNaN(loc3))
		{
			return undefined;
		}
		if(loc3 > 90)
		{
			return undefined;
		}
		if(loc3 < 0)
		{
			return undefined;
		}
		this.api.network.Mount.setXP(loc3);
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._btnName:
				this.gapi.showTooltip(this.api.lang.getText("MOUNT_RENAME_TOOLTIP"),loc2.target,-30,{bXLimit:true,bYLimit:false});
				break;
			case this._btnInventory:
				this.gapi.showTooltip(this.api.lang.getText("MOUNT_INVENTORY_ACCES"),loc2.target,-30,{bXLimit:true,bYLimit:false});
				break;
			case this._btnRide:
				this.gapi.showTooltip(this.api.lang.getText("MOUNT_RIDE_TOOLTIP"),loc2.target,-30,{bXLimit:true,bYLimit:false});
				break;
			default:
				switch(null)
				{
					case this._btnAction:
						this.gapi.showTooltip(this.api.lang.getText("MOUNT_ACTION_TOOLTIP"),loc2.target,-30,{bXLimit:true,bYLimit:false});
						break;
					case this._btnXP:
						this.gapi.showTooltip(this.api.lang.getText("MOUNT_XP_PERCENT_TOOLTIP"),loc2.target,-30,{bXLimit:true,bYLimit:false});
				}
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoKillMount":
				this.api.network.Mount.kill();
				break;
			case "AskYesNoCastrateMount":
				this.api.network.Mount.castrate();
		}
	}
}
