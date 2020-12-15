class dofus.graphics.gapi.controls.GuildMembersViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildMembersViewer";
	function GuildMembersViewer()
	{
		super();
	}
	function __set__members(var2)
	{
		this._eaData = var2;
		this.updateData(this._eaData);
		return this.__get__members();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.GuildMembersViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._dgMembers.addEventListener("itemSelected",this);
		this._dgMembers.addEventListener("itemRollOver",this);
		this._dgMembers.addEventListener("itemRollOut",this);
		this._btnShowOfflineMembers.addEventListener("click",this);
	}
	function initTexts()
	{
		this._dgMembers.columnsNames = ["","",this.api.lang.getText("NAME_BIG"),this.api.lang.getText("GUILD_RANK"),this.api.lang.getText("LEVEL_SMALL"),this.api.lang.getText("PERCENT_XP"),this.api.lang.getText("WIN_XP"),""];
		this._lblDescription.text = this.api.lang.getText("GUILD_MEMBERS_LIST");
		this._lblShowOfflineMembers.text = this.api.lang.getText("DISPLAY_OFFLINE_GUILD_MEMBERS");
	}
	function updateData(var2)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < var2.length)
		{
			if(var2[var4].state != 0)
			{
				var3 = var3 + 1;
			}
			var4 = var4 + 1;
		}
		this._lblCount.text = var3 + " / " + String(var2.length) + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MEMBERS"),"m",var2.length < 2);
		var var5 = new ank.utils.();
		if(!this._btnShowOfflineMembers.selected)
		{
			var var6 = 0;
			while(var6 < var2.length)
			{
				if(var2[var6].state != 0)
				{
					var5.push(var2[var6]);
				}
				var6 = var6 + 1;
			}
		}
		else
		{
			var5 = var2;
		}
		var var7 = 0;
		var var8 = 0;
		while(var8 < var2.length)
		{
			var7 = var7 + var2[var8].level;
			var8 = var8 + 1;
		}
		var7 = Math.floor(var7 / var2.length);
		if(!_global.isNaN(var7))
		{
			this._lblSeeAvgMembersLvl.text = this.api.lang.getText("GUILD_AVG_MEMBERS_LEVEL") + " : " + var7;
		}
		else
		{
			this._lblSeeAvgMembersLvl.text = "";
		}
		this._dgMembers.dataProvider = var5;
	}
	function itemSelected(var2)
	{
		var var3 = var2.row.item;
		if(var3.name != this.api.datacenter.Player.Name)
		{
			if(var3.state == 0)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED",[var3.name]),"ERROR_CHAT");
			}
			else
			{
				this.api.kernel.GameManager.showPlayerPopupMenu(var3.name,var2.row.item.name,undefined,undefined,true,undefined,this.api.datacenter.Player.isAuthorized);
			}
		}
	}
	function itemRollOver(var2)
	{
		var2.row.cellRenderer_mc.over();
	}
	function itemRollOut(var2)
	{
		var2.row.cellRenderer_mc.out();
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnShowOfflineMembers)
		{
			this.updateData(this._eaData);
		}
	}
}
