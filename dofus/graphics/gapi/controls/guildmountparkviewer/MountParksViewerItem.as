class dofus.graphics.gapi.controls.guildmountparkviewer.MountParksViewerItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function MountParksViewerItem()
	{
		super();
		this.api = _global.API;
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		this._bUsed = loc2;
		if(loc2)
		{
			this._oItem = loc4;
			var loc5 = this.api.lang.getMapText(Number(loc4.map)).x;
			var loc6 = this.api.lang.getMapText(Number(loc4.map)).y;
			this._lblSubArea.text = this.api.kernel.MapsServersManager.getMapName(loc4.map) + " (" + loc5 + ", " + loc6 + ")";
			loc4.sortLocalisation = this._lblSubArea.text;
			this._lblItems.text = this.api.lang.getText("MOUNTPARKS_MAX_ITEMS",[loc4.items]);
			this._lblMounts.text = this.api.lang.getText("MOUNTPARKS_CURRENT_MOUNTS",[loc4.mounts.length,loc4.size]);
			loc4.sortMounts = loc4.mounts.length;
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
	function over(loc2)
	{
		var loc3 = this._mcList._parent._parent.api;
		if((var loc0 = loc2.target) === this._lblMounts)
		{
			var loc4 = "";
			var loc5 = this._oItem.mounts;
			var loc6 = 0;
			while(loc6 < loc5.length)
			{
				if(loc6 > 0)
				{
					loc4 = loc4 + "\n\n";
				}
				var loc7 = loc5[loc6];
				loc4 = loc4 + (loc3.lang.getText("MOUNT_OF",[loc7.ownerName]) + " : " + loc7.name + "\n(" + loc7.modelName + ")");
				loc6 = loc6 + 1;
			}
			if(loc4 != "")
			{
				loc3.ui.showTooltip(loc4,loc2.target,-30,{bXLimit:true,bYLimit:false});
			}
		}
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._btnTeleport)
		{
			if(!this._bUsed)
			{
				return undefined;
			}
			this.api.network.Guild.teleportToGuildFarm(this._oItem.map);
		}
	}
	function out(loc2)
	{
		var loc3 = this._mcList._parent._parent.api;
		loc3.ui.hideTooltip();
	}
}
