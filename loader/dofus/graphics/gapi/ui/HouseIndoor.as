class dofus.graphics.gapi.ui.HouseIndoor extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "HouseIndoor";
	function HouseIndoor()
	{
		super();
	}
	function __set__house(var2)
	{
		this._oHouse = var2;
		var2.addEventListener("forsale",this);
		var2.addEventListener("locked",this);
		this._mcForSale._visible = var2.isForSale;
		this._mcLock._visible = var2.isLocked;
		return this.__get__house();
	}
	function __set__skills(var2)
	{
		this._aSkills = var2;
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
		var var2 = this._parent.gapi.createPopupMenu();
		var var3 = this._parent._oHouse;
		var var4 = this._parent.api;
		var2.addStaticItem(var3.name);
		for(var var5 in this._parent._aSkills)
		{
			var var6 = var5.getState(true,var3.localOwner,var3.isForSale,var3.isLocked,true);
			if(var6 != "X")
			{
				var2.addItem(var5.description,var4.kernel.GameManager,var4.kernel.GameManager.useSkill,[var5.id],var6 == "V");
			}
		}
		if(var4.datacenter.Player.guildInfos != undefined && var4.datacenter.Player.guildInfos.isValid)
		{
			var2.addItem(var4.lang.getText("GUILD_HOUSE_CONFIGURATION"),this._parent,this._parent.guildHouse);
		}
		var2.show(_root._xmouse,_root._ymouse);
	}
	function guildHouse()
	{
		this.api.ui.loadUIComponent("GuildHouseRights","GuildHouseRights",{house:this._oHouse});
	}
	function forsale(var2)
	{
		this._mcForSale._visible = var2.value;
	}
	function locked(var2)
	{
		this._mcLock._visible = var2.value;
	}
}
