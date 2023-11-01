class dofus.graphics.gapi.controls.guildmountparkviewer.MountParksViewerItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function MountParksViewerItem()
	{
		super();
		this.api = _global.API;
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		this._bUsed = var2;
		if(var2)
		{
			this._oItem = var4;
			var var5 = this.api.lang.getMapText(Number(var4.map)).x;
			var var6 = this.api.lang.getMapText(Number(var4.map)).y;
			this._lblSubArea.text = this.api.kernel.MapsServersManager.getMapName(var4.map) + " (" + var5 + ", " + var6 + ")";
			var4.sortLocalisation = this._lblSubArea.text;
			this._lblItems.text = this.api.lang.getText("MOUNTPARKS_MAX_ITEMS",[var4.items]);
			this._lblMounts.text = this.api.lang.getText("MOUNTPARKS_CURRENT_MOUNTS",[var4.mounts.length,var4.size]);
			var4.sortMounts = var4.mounts.length;
			this._btnTeleport._visible = true;
			this._btnTeleport.onRollOver = function()
			{
				this._parent.gapi.showTooltip(this._parent.api.lang.getText("GUILD_FARM_TELEPORT_TOOLTIP"),this,-20);
			};
			this._btnTeleport.onRollOut = function()
			{
				this._parent.gapi.hideTooltip();
			};
		}
		else
		{
			this._btnTeleport._visible = false;
			if(this._lblArea.text != undefined)
			{
				this._lblArea.text = "";
				this._lblSubArea.text = "";
				this._lblItems.text = "-";
				this._lblMounts.text = "";
			}
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._lblMounts.onRollOver = function()
		{
			this._parent.over({target:this});
		};
		this._lblMounts.onRollOut = function()
		{
			this._parent.out({target:this});
		};
		this._btnTeleport.addEventListener("click",this);
	}
	function over(var2)
	{
		var var3 = this._mcList._parent._parent.api;
		if((var var0 = var2.target) === this._lblMounts)
		{
			var var4 = "";
			var var5 = this._oItem.mounts;
			var var6 = 0;
			while(var6 < var5.length)
			{
				if(var6 > 0)
				{
					var4 = var4 + "\n\n";
				}
				var var7 = var5[var6];
				var4 = var4 + (var3.lang.getText("MOUNT_OF",[var7.ownerName]) + " : " + var7.name + "\n(" + var7.modelName + ")");
				var6 = var6 + 1;
			}
			if(var4 != "")
			{
				var3.ui.showTooltip(var4,var2.target,-30,{bXLimit:true,bYLimit:false});
			}
		}
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnTeleport)
		{
			if(!this._bUsed)
			{
				return undefined;
			}
			this.api.network.Guild.teleportToGuildFarm(this._oItem.map);
		}
	}
	function out(var2)
	{
		var var3 = this._mcList._parent._parent.api;
		var3.ui.hideTooltip();
	}
}
