class dofus.graphics.gapi.ui.GuildMemberInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildMemberInfos";
	function GuildMemberInfos()
	{
		super();
	}
	function __set__member(§\x1e\x19\x03§)
	{
		this._oMember = var2;
		this._oMemberClone = new Object();
		this._oMemberClone.rank = this._oMember.rank;
		this._oMemberClone.percentxp = this._oMember.percentxp;
		this._oMemberClone.rights = new dofus.datacenter.(this._oMember.rights.value);
		return this.__get__member();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.GuildMemberInfos.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
		this._cbRanks._visible = false;
		this._btnPercentXP._visible = false;
	}
	function initTexts()
	{
		this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		this._btnModify.label = this.api.lang.getText("MODIFY");
		this._lblRank.text = this.api.lang.getText("GUILD_RANK");
		this._lblPercentXP.text = this.api.lang.getText("PERCENT_XP_FULL");
		this._lblRights.text = this.api.lang.getText("RIGHTS");
		this._lblRBoost.text = this.api.lang.getText("GUILD_RIGHTS_BOOST");
		this._lblRRights.text = this.api.lang.getText("GUILD_RIGHTS_RIGHTS");
		this._lblRInvit.text = this.api.lang.getText("GUILD_RIGHTS_INVIT");
		this._lblRBann.text = this.api.lang.getText("GUILD_RIGHTS_BANN");
		this._lblRPercentXP.text = this.api.lang.getText("GUILD_RIGHTS_PERCENTXP");
		this._lblROwnPercentXP.text = this.api.lang.getText("GUILD_RIGHT_MANAGE_OWN_XP");
		this._lblRRank.text = this.api.lang.getText("GUILD_RIGHTS_RANK");
		this._lblRHireTax.text = this.api.lang.getText("GUILD_RIGHTS_HIRETAX");
		this._lblRDefendTax.text = this.api.lang.getText("GUILD_RIGHTS_DEFENDTAX");
		this._lblRCollect.text = this.api.lang.getText("GUILD_RIGHTS_COLLECT");
		this._lblRCanUseMountPark.text = this.api.lang.getText("GUILD_RIGHTS_MOUNT_PARK_USE");
		this._lblRCanArrangeMountPark.text = this.api.lang.getText("GUILD_RIGHTS_MOUNT_PARK_ARRANGE");
		this._lblRCanManageOtherMount.text = this.api.lang.getText("GUILD_RIGHTS_MANAGE_OTHER_MOUNT");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnCancel.addEventListener("click",this);
		this._btnModify.addEventListener("click",this);
		this._btnPercentXP.addEventListener("click",this);
		this._cbRanks.addEventListener("itemSelected",this);
		this._btnRBoost.addEventListener("click",this);
		this._btnRRights.addEventListener("click",this);
		this._btnRInvit.addEventListener("click",this);
		this._btnRBann.addEventListener("click",this);
		this._btnRPercentXP.addEventListener("click",this);
		this._btnROwnPercentXP.addEventListener("click",this);
		this._btnRRank.addEventListener("click",this);
		this._btnRHireTax.addEventListener("click",this);
		this._btnRDefendTax.addEventListener("click",this);
		this._btnRCollect.addEventListener("click",this);
		this._bntRCanUseMountPark.addEventListener("click",this);
		this._btnRCanArrangeMountPark.addEventListener("click",this);
		this._btnRCanManageOtherMount.addEventListener("click",this);
	}
	function updateData()
	{
		this._winBg.title = this._oMember.name + " (" + this.api.lang.getText("LEVEL_SMALL") + " " + this._oMember.level + ")";
		this._lblPercentXPValue.text = this._oMemberClone.percentxp + "%";
		var var2 = this.api.datacenter.Player.guildInfos.playerRights;
		this._cbRanks.enabled = var2.canManageRanks;
		this._btnPercentXP._visible = var2.canManageXPContitribution || var2.canManageOwnXPContitribution;
		var var3 = this._oMemberClone.rights;
		this._btnRBoost.selected = var3.canManageBoost;
		this._btnRRights.selected = var3.canManageRights;
		this._btnRInvit.selected = var3.canInvite;
		this._btnRBann.selected = var3.canBann;
		this._btnRPercentXP.selected = var3.canManageXPContitribution;
		this._btnRRank.selected = var3.canManageRanks;
		this._btnRHireTax.selected = var3.canHireTaxCollector;
		this._btnROwnPercentXP.selected = var3.canManageOwnXPContitribution;
		this._btnRCollect.selected = var3.canCollect;
		this._bntRCanUseMountPark.selected = var3.canUseMountPark;
		this._btnRCanArrangeMountPark.selected = var3.canArrangeMountPark;
		this._btnRCanManageOtherMount.selected = var3.canManageOtherMount;
		var var4 = var2.canManageRights && !var3.isBoss;
		this._btnRBoost.enabled = var4;
		this._btnRRights.enabled = var4;
		this._btnRInvit.enabled = var4;
		this._btnRBann.enabled = var4;
		this._btnRPercentXP.enabled = var4;
		this._btnRRank.enabled = var4;
		this._btnRHireTax.enabled = var4;
		this._btnROwnPercentXP.enabled = var4;
		this._btnRCollect.enabled = var4;
		this._bntRCanUseMountPark.enabled = var4;
		this._btnRCanArrangeMountPark.enabled = var4;
		this._btnRCanManageOtherMount.enabled = var4;
		this._btnModify.enabled = var2.isBoss || (var2.canManageRights || (var2.canManageRanks || (var2.canManageXPContitribution || var3.canManageOwnXPContitribution)));
		if(var2.canManageRanks)
		{
			this._cbRanks._visible = true;
			var var5 = this.api.lang.getRanks().slice();
			var var6 = new ank.utils.
();
			var5.sortOn("o",Array.NUMERIC);
			if(this.api.datacenter.Player.guildInfos.playerRights.isBoss)
			{
				var6.push({label:var5[0].n,id:var5[0].i});
				if(this._oMemberClone.rank == var5[0].i)
				{
					this._cbRanks.selectedIndex = 0;
				}
			}
			var var7 = 1;
			while(var7 < var5.length)
			{
				var6.push({label:var5[var7].n,id:var5[var7].i});
				if(this._oMemberClone.rank == var5[var7].i)
				{
					this._cbRanks.selectedIndex = var6.length - 1;
				}
				var7 = var7 + 1;
			}
			this._cbRanks.dataProvider = var6;
		}
		else
		{
			this._lblRankValue.text = this.api.lang.getRankInfos(this._oMemberClone.rank).n;
		}
	}
	function setRank(§\x1e\x1e\x1d§)
	{
		this._oMemberClone.rank = var2;
		this._oMemberClone.rankOrder = this.api.lang.getRankInfos(var2).o;
		this.updateData();
	}
	function setBoss()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_GIVERIGHTS",[this._oMember.name]),"CAUTION_YESNO",{name:"GuildSetBoss",listener:this});
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		if(this._cbRanks.selectedItem.id == 1)
		{
			this.setBoss();
		}
		else
		{
			this.setRank(this._cbRanks.selectedItem.id);
		}
	}
	function click(§\x1e\x19\x18§)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnCancel":
			case "_btnClose":
				this.unloadThis();
				break;
			default:
				switch(null)
				{
					case "_btnModify":
						if(this._oMember.rank == this._oMemberClone.rank && (this._oMember.percentxp == this._oMemberClone.percentxp && this._oMember.rights.value == this._oMemberClone.rights.value))
						{
							return undefined;
						}
						this._oMember.rank = this._oMemberClone.rank;
						this._oMember.rankOrder = this._oMemberClone.rankOrder;
						this._oMember.percentxp = this._oMemberClone.percentxp;
						this._oMember.rights.value = this._oMemberClone.rights.value;
						this.api.network.Guild.changeMemberProfil(this._oMember);
						this.api.datacenter.Player.guildInfos.setMembers();
						this.unloadThis();
						break loop0;
					case "_btnPercentXP":
						var var3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this._oMember.percentxp,max:90,min:0});
						var3.addEventListener("validate",this);
						break loop0;
					case "_btnRBoost":
						if(this._btnRBoost.selected)
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value | 2;
						}
						else
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 2;
						}
						break loop0;
					case "_btnRRights":
						if(this._btnRRights.selected)
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value | 4;
						}
						else
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 4;
						}
						break loop0;
					case "_btnRInvit":
						if(this._btnRInvit.selected)
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value | 8;
						}
						else
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 8;
						}
						break loop0;
					case "_btnRBann":
						if(this._btnRBann.selected)
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value | 16;
						}
						else
						{
							this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 16;
						}
						break loop0;
					default:
						switch(null)
						{
							case "_btnRPercentXP":
								if(this._btnRPercentXP.selected)
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value | 32;
								}
								else
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 32;
								}
								break loop0;
							case "_btnRRank":
								if(this._btnRRank.selected)
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value | 64;
								}
								else
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 64;
								}
								break loop0;
							case "_btnRHireTax":
								if(this._btnRHireTax.selected)
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value | 128;
								}
								else
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 128;
								}
								break loop0;
							case "_btnROwnPercentXP":
								if(this._btnROwnPercentXP.selected)
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value | 256;
								}
								else
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 256;
								}
								break loop0;
							case "_btnRCollect":
								if(this._btnRCollect.selected)
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value | 512;
								}
								else
								{
									this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 512;
								}
								break loop0;
							default:
								switch(null)
								{
									case "_bntRCanUseMountPark":
										if(this._bntRCanUseMountPark.selected)
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value | 4096;
										}
										else
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 4096;
										}
										break;
									case "_btnRCanArrangeMountPark":
										if(this._btnRCanArrangeMountPark.selected)
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value | 8192;
										}
										else
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 8192;
										}
										break;
									case "_btnRCanManageOtherMount":
										if(this._btnRCanManageOtherMount.selected)
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value | 16384;
											break;
										}
										this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 16384;
										break;
								}
						}
				}
		}
	}
	function validate(§\x1e\x19\x18§)
	{
		var var3 = var2.value;
		if(_global.isNaN(var3))
		{
			return undefined;
		}
		if(var3 > 90)
		{
			return undefined;
		}
		if(var3 < 0)
		{
			return undefined;
		}
		this._oMemberClone.percentxp = var3;
		this.updateData();
	}
	function yes(§\x1e\x19\x18§)
	{
		this.setRank(1);
	}
}
