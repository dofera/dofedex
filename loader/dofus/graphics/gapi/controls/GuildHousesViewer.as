class dofus.graphics.gapi.controls.GuildHousesViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildHousesViewer";
	function GuildHousesViewer()
	{
		super();
	}
	function __set__houses(var2)
	{
		this.updateData(var2);
		return this.__get__houses();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.GuildHousesViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function initTexts()
	{
		this._lblDescription.text = this.api.lang.getText("GUILD_HOUSES_LIST");
		this._lblHouse.text = this.api.lang.getText("HOUSE_WORD");
		this._lblOwner.text = this.api.lang.getText("OWNER_WORD");
		this._lblCoordsTitle.text = this.api.lang.getText("COORDINATES");
		this._lblOwnerTitle.text = this.api.lang.getText("OWNER_WORD");
		this._lblSkillsTitle.text = this.api.lang.getText("SKILLS");
		this._lblRightsTitle.text = this.api.lang.getText("RIGHTS");
		this._lblSelectHouse.text = this.api.lang.getText("SELECT_A_HOUSE");
		this._btnTeleport.label = this.api.lang.getText("JOIN_SMALL");
	}
	function addListeners()
	{
		this._lstHouses.addEventListener("itemSelected",this);
		this._btnTeleport.addEventListener("click",this);
	}
	function updateData(var2)
	{
		this._lstHouses.dataProvider = var2;
	}
	function itemSelected(var2)
	{
		this._hSelectedHouse = (dofus.datacenter.House)var2.row.item;
		this._lblHouseName.text = this._hSelectedHouse.name;
		this._lblHouseCoords.text = this._hSelectedHouse.coords.x + ";" + this._hSelectedHouse.coords.y;
		this._lblHouseOwner.text = this._hSelectedHouse.ownerName;
		var var3 = new ank.utils.();
		var var4 = 0;
		while(var4 < this._hSelectedHouse.skills.length)
		{
			var var5 = new dofus.datacenter.(this._hSelectedHouse.skills[var4]);
			if(!_global.isNaN(var5.id))
			{
				var3.push({id:var5.id,label:var5.description});
			}
			var4 = var4 + 1;
		}
		this._lstSkills.dataProvider = var3;
		this._lstRights.dataProvider = this._hSelectedHouse.getHumanReadableRightsList();
		this._btnTeleport._visible = this._hSelectedHouse.hasRight(dofus.datacenter.House.GUILDSHARE_TELEPORT);
		if(!this._btnTeleport._visible)
		{
			if(!this._mcHouseIcon.moved)
			{
				this._mcHouseIcon.moved = true;
				this._mcHouseIcon._y = this._mcHouseIcon._y + this._btnTeleport._height / 2;
			}
		}
		this._mcMask._visible = false;
		this._lblSelectHouse._visible = false;
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnTeleport)
		{
			if(this._hSelectedHouse == null)
			{
				return undefined;
			}
			if(!this._hSelectedHouse.hasRight(dofus.datacenter.House.GUILDSHARE_TELEPORT))
			{
				return undefined;
			}
			this.api.network.Guild.teleportToGuildHouse(this._hSelectedHouse.id);
		}
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._btnTeleport)
		{
			this.gapi.showTooltip(this.api.lang.getText("GUILD_HOUSE_TELEPORT_TOOLTIP"),this._btnTeleport,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
