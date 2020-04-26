class dofus.graphics.gapi.controls.GuildHousesViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildHousesViewer";
	function GuildHousesViewer()
	{
		super();
	}
	function __set__houses(loc2)
	{
		this.updateData(loc2);
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
	function updateData(loc2)
	{
		this._lstHouses.dataProvider = loc2;
	}
	function itemSelected(loc2)
	{
		this._hSelectedHouse = (dofus.datacenter.House)loc2.row.item;
		this._lblHouseName.text = this._hSelectedHouse.name;
		this._lblHouseCoords.text = this._hSelectedHouse.coords.x + ";" + this._hSelectedHouse.coords.y;
		this._lblHouseOwner.text = this._hSelectedHouse.ownerName;
		var loc3 = new ank.utils.();
		var loc4 = 0;
		while(loc4 < this._hSelectedHouse.skills.length)
		{
			var loc5 = new dofus.datacenter.(this._hSelectedHouse.skills[loc4]);
			if(!_global.isNaN(loc5.id))
			{
				loc3.push({id:loc5.id,label:loc5.description});
			}
			loc4 = loc4 + 1;
		}
		this._lstSkills.dataProvider = loc3;
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
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._btnTeleport)
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
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._btnTeleport)
		{
			this.gapi.showTooltip(this.api.lang.getText("GUILD_HOUSE_TELEPORT_TOOLTIP"),this._btnTeleport,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
