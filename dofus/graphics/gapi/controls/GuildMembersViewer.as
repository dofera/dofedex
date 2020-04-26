class dofus.graphics.gapi.controls.GuildMembersViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildMembersViewer";
	function GuildMembersViewer()
	{
		super();
	}
	function __set__members(loc2)
	{
		this._eaData = loc2;
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
	function updateData(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			if(loc2[loc4].state != 0)
			{
				loc3 = loc3 + 1;
			}
			loc4 = loc4 + 1;
		}
		this._lblCount.text = loc3 + " / " + String(loc2.length) + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MEMBERS"),"m",loc2.length < 2);
		var loc5 = new ank.utils.();
		if(!this._btnShowOfflineMembers.selected)
		{
			var loc6 = 0;
			while(loc6 < loc2.length)
			{
				if(loc2[loc6].state != 0)
				{
					loc5.push(loc2[loc6]);
				}
				loc6 = loc6 + 1;
			}
		}
		else
		{
			loc5 = loc2;
		}
		var loc7 = 0;
		var loc8 = 0;
		while(loc8 < loc2.length)
		{
			loc7 = loc7 + loc2[loc8].level;
			loc8 = loc8 + 1;
		}
		loc7 = Math.floor(loc7 / loc2.length);
		if(!_global.isNaN(loc7))
		{
			this._lblSeeAvgMembersLvl.text = this.api.lang.getText("GUILD_AVG_MEMBERS_LEVEL") + " : " + loc7;
		}
		else
		{
			this._lblSeeAvgMembersLvl.text = "";
		}
		this._dgMembers.dataProvider = loc5;
	}
	function itemSelected(loc2)
	{
		var loc3 = loc2.row.item;
		if(loc3.name != this.api.datacenter.Player.Name)
		{
			if(loc3.state == 0)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED",[loc3.name]),"ERROR_CHAT");
			}
			else
			{
				this.api.kernel.GameManager.showPlayerPopupMenu(loc3.name,loc2.row.item.name,undefined,undefined,true,undefined,this.api.datacenter.Player.isAuthorized);
			}
		}
	}
	function itemRollOver(loc2)
	{
		loc2.row.cellRenderer_mc.over();
	}
	function itemRollOut(loc2)
	{
		loc2.row.cellRenderer_mc.out();
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._btnShowOfflineMembers)
		{
			this.updateData(this._eaData);
		}
	}
}
