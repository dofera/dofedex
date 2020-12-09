class dofus.graphics.gapi.controls.guildmembersviewer.GuildMembersViewerMember extends ank.gapi.core.UIBasicComponent
{
	var ftgt = 150;
	function GuildMembersViewerMember()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = var4;
			var var5 = this._mcList.gapi.api.datacenter.Player.guildInfos.playerRights;
			this._lblName.text = var4.name;
			this._lblRank.text = this._mcList.gapi.api.lang.getRankInfos(var4.rank).n;
			this._lblLevel.text = var4.level;
			this._lblPercentXP.text = var4.percentxp + "%";
			this._lblWinXP.text = var4.winxp;
			this._btnBann._visible = var4.isLocalPlayer || var5.canBann;
			this._btnProfil._visible = var4.isLocalPlayer || (var5.canManageRights || (var5.canManageXPContitribution || var5.canManageRanks));
			this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + var4.gfx + ".swf";
			this._mcFight._visible = var4.state == 2;
			this._mcOffline._visible = var4.state == 0;
			this._mcOver.hint = var4.lastConnection;
			this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + var4.alignement + ".swf";
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
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnBann":
				var var3 = this._mcList.gapi.api;
				var var4 = var3.datacenter.Player.guildInfos.members.length;
				if(this._oItem.rights.isBoss && var4 > 1)
				{
					this._mcList.gapi.api.kernel.showMessage(undefined,var3.lang.getText("GUILD_BOSS_CANT_BE_BANN"),"ERROR_BOX");
				}
				else if(this._oItem.isLocalPlayer)
				{
					this._mcList.gapi.api.kernel.showMessage(undefined,var3.lang.getText("DO_U_DELETE_YOU") + (var4 <= 1?"\n" + var3.lang.getText("DELETE_GUILD_CAUTION"):""),"CAUTION_YESNO",{name:"DeleteMember",listener:this,params:{name:this._oItem.name}});
				}
				else
				{
					this._mcList.gapi.api.kernel.showMessage(undefined,var3.lang.getText("DO_U_DELETE_MEMBER",[this._oItem.name]),"CAUTION_YESNO",{name:"DeleteMember",listener:this,params:{name:this._oItem.name}});
				}
				break;
			case "_btnProfil":
				this._mcList.gapi.loadUIComponent("GuildMemberInfos","GuildMemberInfos",{member:this._oItem});
		}
	}
	function yes(§\x1e\x19\x18§)
	{
		this._mcList.gapi.api.network.Guild.bann(var2.params.name);
	}
	function over(§\x1e\x19\x18§)
	{
		if(this._oItem.state != 0)
		{
			return undefined;
		}
		var var3 = this._mcList.gapi.api;
		var var4 = this._oItem.lastConnection;
		var var5 = Math.floor(var4 / (24 * 31));
		var4 = var4 - var5 * 24 * 31;
		var var6 = Math.floor(var4 / 24);
		var4 = var4 - var6 * 24;
		var var7 = var4;
		if(var5 < 0)
		{
			var5 = 0;
			var6 = 0;
			var7 = 0;
		}
		var var8 = " " + var3.lang.getText("AND") + " ";
		var var9 = "";
		if(var5 > 0 && var6 != 0)
		{
			var var10 = ank.utils.PatternDecoder.combine(var3.lang.getText("MONTHS"),"m",var5 == 1);
			var var11 = ank.utils.PatternDecoder.combine(var3.lang.getText("DAYS"),"m",var6 == 1);
			var9 = var9 + (var5 + " " + var10 + var8 + var6 + " " + var11);
		}
		else if(var6 != 0)
		{
			var var12 = ank.utils.PatternDecoder.combine(var3.lang.getText("DAYS"),"m",var6 == 1);
			var9 = var9 + (var6 + " " + var12);
		}
		else
		{
			var9 = var9 + var3.lang.getText("A_CONNECTED_TODAY");
		}
		var3.ui.showTooltip(var3.lang.getText("GUILD_LAST_CONNECTION",[var9]),this._mcOver,-20);
	}
	function out(§\x1e\x19\x18§)
	{
		this._mcList.gapi.api.ui.hideTooltip();
	}
}
