class dofus.graphics.gapi.controls.guildmembersviewer.GuildMembersViewerMember extends ank.gapi.core.UIBasicComponent
{
	var ftgt = 150;
	function GuildMembersViewerMember()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			var loc5 = this._mcList.gapi.api.datacenter.Player.guildInfos.playerRights;
			this._lblName.text = loc4.name;
			this._lblRank.text = this._mcList.gapi.api.lang.getRankInfos(loc4.rank).n;
			this._lblLevel.text = loc4.level;
			this._lblPercentXP.text = loc4.percentxp + "%";
			this._lblWinXP.text = loc4.winxp;
			this._btnBann._visible = loc4.isLocalPlayer || loc5.canBann;
			this._btnProfil._visible = loc4.isLocalPlayer || (loc5.canManageRights || (loc5.canManageXPContitribution || loc5.canManageRanks));
			this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + loc4.gfx + ".swf";
			this._mcFight._visible = loc4.state == 2;
			this._mcOffline._visible = loc4.state == 0;
			this._mcOver.hint = loc4.lastConnection;
			this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + loc4.alignement + ".swf";
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblRank.text = "";
			this._lblLevel.text = "";
			this._lblPercentXP.text = "";
			this._lblWinXP.text = "";
			this._btnBann._visible = false;
			this._btnProfil._visible = false;
			this._ldrGuild.contentPath = "";
			this._ldrAlignement.contentPath = "";
			this._mcFight._visible = false;
			this._mcOffline._visible = false;
			delete this._mcOver.onRollOver;
			delete this._mcOver.onRollOut;
		}
	}
	function init()
	{
		super.init(false);
		this._btnBann._visible = false;
		this._btnProfil._visible = false;
		this._mcFight._visible = false;
		this._mcOffline._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnBann.addEventListener("click",this);
		this._btnProfil.addEventListener("click",this);
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnBann":
				var loc3 = this._mcList.gapi.api;
				var loc4 = loc3.datacenter.Player.guildInfos.members.length;
				if(this._oItem.rights.isBoss && loc4 > 1)
				{
					this._mcList.gapi.api.kernel.showMessage(undefined,loc3.lang.getText("GUILD_BOSS_CANT_BE_BANN"),"ERROR_BOX");
				}
				else if(this._oItem.isLocalPlayer)
				{
					this._mcList.gapi.api.kernel.showMessage(undefined,loc3.lang.getText("DO_U_DELETE_YOU") + (loc4 <= 1?"\n" + loc3.lang.getText("DELETE_GUILD_CAUTION"):""),"CAUTION_YESNO",{name:"DeleteMember",listener:this,params:{name:this._oItem.name}});
				}
				else
				{
					this._mcList.gapi.api.kernel.showMessage(undefined,loc3.lang.getText("DO_U_DELETE_MEMBER",[this._oItem.name]),"CAUTION_YESNO",{name:"DeleteMember",listener:this,params:{name:this._oItem.name}});
				}
				break;
			case "_btnProfil":
				this._mcList.gapi.loadUIComponent("GuildMemberInfos","GuildMemberInfos",{member:this._oItem});
		}
	}
	function yes(loc2)
	{
		this._mcList.gapi.api.network.Guild.bann(loc2.params.name);
	}
	function over(loc2)
	{
		if(this._oItem.state != 0)
		{
			return undefined;
		}
		var loc3 = this._mcList.gapi.api;
		var loc4 = this._oItem.lastConnection;
		var loc5 = Math.floor(loc4 / (24 * 31));
		loc4 = loc4 - loc5 * 24 * 31;
		var loc6 = Math.floor(loc4 / 24);
		loc4 = loc4 - loc6 * 24;
		var loc7 = loc4;
		if(loc5 < 0)
		{
			loc5 = 0;
			loc6 = 0;
			loc7 = 0;
		}
		var loc8 = " " + loc3.lang.getText("AND") + " ";
		var loc9 = "";
		if(loc5 > 0 && loc6 != 0)
		{
			var loc10 = ank.utils.PatternDecoder.combine(loc3.lang.getText("MONTHS"),"m",loc5 == 1);
			var loc11 = ank.utils.PatternDecoder.combine(loc3.lang.getText("DAYS"),"m",loc6 == 1);
			loc9 = loc9 + (loc5 + " " + loc10 + loc8 + loc6 + " " + loc11);
		}
		else if(loc6 != 0)
		{
			var loc12 = ank.utils.PatternDecoder.combine(loc3.lang.getText("DAYS"),"m",loc6 == 1);
			loc9 = loc9 + (loc6 + " " + loc12);
		}
		else
		{
			loc9 = loc9 + loc3.lang.getText("A_CONNECTED_TODAY");
		}
		loc3.ui.showTooltip(loc3.lang.getText("GUILD_LAST_CONNECTION",[loc9]),this._mcOver,-20);
	}
	function out(loc2)
	{
		this._mcList.gapi.api.ui.hideTooltip();
	}
}
