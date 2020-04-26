class dofus.graphics.gapi.ui.HouseIndoor extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "HouseIndoor";
	function HouseIndoor()
	{
		super();
	}
	function __set__house(loc2)
	{
		this._oHouse = loc2;
		loc2.addEventListener("forsale",this);
		loc2.addEventListener("locked",this);
		this._mcForSale._visible = loc2.isForSale;
		this._mcLock._visible = loc2.isLocked;
		return this.__get__house();
	}
	function __set__skills(loc2)
	{
		this._aSkills = loc2;
		return this.__get__skills();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.HouseIndoor.CLASS_NAME);
	}
	function createChildren()
	{
		this._mcHouse.onRelease = this.click;
		if(this._oHouse == undefined)
		{
			this._mcForSale._visible = false;
			this._mcLock._visible = false;
		}
	}
	function click()
	{
		var loc2 = this._parent.gapi.createPopupMenu();
		var loc3 = this._parent._oHouse;
		var loc4 = this._parent.api;
		loc2.addStaticItem(loc3.name);
		for(var k in this._parent._aSkills)
		{
			var loc5 = this._parent._aSkills[k];
			var loc6 = loc5.getState(true,loc3.localOwner,loc3.isForSale,loc3.isLocked,true);
			if(loc6 != "X")
			{
				loc2.addItem(loc5.description,loc4.kernel.GameManager,loc4.kernel.GameManager.useSkill,[loc5.id],loc6 == "V");
			}
		}
		if(loc4.datacenter.Player.guildInfos != undefined && loc4.datacenter.Player.guildInfos.isValid)
		{
			loc2.addItem(loc4.lang.getText("GUILD_HOUSE_CONFIGURATION"),this._parent,this._parent.guildHouse);
		}
		loc2.show(_root._xmouse,_root._ymouse);
	}
	function guildHouse()
	{
		this.api.ui.loadUIComponent("GuildHouseRights","GuildHouseRights",{house:this._oHouse});
	}
	function forsale(loc2)
	{
		this._mcForSale._visible = loc2.value;
	}
	function locked(loc2)
	{
		this._mcLock._visible = loc2.value;
	}
}
