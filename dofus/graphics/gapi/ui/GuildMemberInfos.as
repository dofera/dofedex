class dofus.graphics.gapi.ui.GuildMemberInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildMemberInfos";
	function GuildMemberInfos()
	{
		super();
	}
	function __set__member(loc2)
	{
		this._oMember = loc2;
		this._oMemberClone = new Object();
		this._oMemberClone.rank = this._oMember.rank;
		this._oMemberClone.percentxp = this._oMember.percentxp;
		this._oMemberClone.rights = new dofus.datacenter.(this._oMember.rights.value);
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
		var loc2 = this.api.datacenter.Player.guildInfos.playerRights;
		this._cbRanks.enabled = loc2.canManageRanks;
		this._btnPercentXP._visible = loc2.canManageXPContitribution || loc2.canManageOwnXPContitribution;
		var loc3 = this._oMemberClone.rights;
		this._btnRBoost.selected = loc3.canManageBoost;
		this._btnRRights.selected = loc3.canManageRights;
		this._btnRInvit.selected = loc3.canInvite;
		this._btnRBann.selected = loc3.canBann;
		this._btnRPercentXP.selected = loc3.canManageXPContitribution;
		this._btnRRank.selected = loc3.canManageRanks;
		this._btnRHireTax.selected = loc3.canHireTaxCollector;
		this._btnROwnPercentXP.selected = loc3.canManageOwnXPContitribution;
		this._btnRCollect.selected = loc3.canCollect;
		this._bntRCanUseMountPark.selected = loc3.canUseMountPark;
		this._btnRCanArrangeMountPark.selected = loc3.canArrangeMountPark;
		this._btnRCanManageOtherMount.selected = loc3.canManageOtherMount;
		var loc4 = loc2.canManageRights && !loc3.isBoss;
		this._btnRBoost.enabled = loc4;
		this._btnRRights.enabled = loc4;
		this._btnRInvit.enabled = loc4;
		this._btnRBann.enabled = loc4;
		this._btnRPercentXP.enabled = loc4;
		this._btnRRank.enabled = loc4;
		this._btnRHireTax.enabled = loc4;
		this._btnROwnPercentXP.enabled = loc4;
		this._btnRCollect.enabled = loc4;
		this._bntRCanUseMountPark.enabled = loc4;
		this._btnRCanArrangeMountPark.enabled = loc4;
		this._btnRCanManageOtherMount.enabled = loc4;
		this._btnModify.enabled = loc2.isBoss || (loc2.canManageRights || (loc2.canManageRanks || (loc2.canManageXPContitribution || loc3.canManageOwnXPContitribution)));
		if(loc2.canManageRanks)
		{
			this._cbRanks._visible = true;
			var loc5 = this.api.lang.getRanks().slice();
			var loc6 = new ank.utils.();
			loc5.sortOn("o",Array.NUMERIC);
			if(this.api.datacenter.Player.guildInfos.playerRights.isBoss)
			{
				loc6.push({label:loc5[0].n,id:loc5[0].i});
				if(this._oMemberClone.rank == loc5[0].i)
				{
					this._cbRanks.selectedIndex = 0;
				}
			}
			var loc7 = 1;
			while(loc7 < loc5.length)
			{
				loc6.push({label:loc5[loc7].n,id:loc5[loc7].i});
				if(this._oMemberClone.rank == loc5[loc7].i)
				{
					this._cbRanks.selectedIndex = loc6.length - 1;
				}
				loc7 = loc7 + 1;
			}
			this._cbRanks.dataProvider = loc6;
		}
		else
		{
			this._lblRankValue.text = this.api.lang.getRankInfos(this._oMemberClone.rank).n;
		}
	}
	function setRank(loc2)
	{
		this._oMemberClone.rank = loc2;
		this._oMemberClone.rankOrder = this.api.lang.getRankInfos(loc2).o;
		this.updateData();
	}
	function setBoss()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_GIVERIGHTS",[this._oMember.name]),"CAUTION_YESNO",{name:"GuildSetBoss",listener:this});
	}
	function itemSelected(loc2)
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
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
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
						var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this._oMember.percentxp,max:90,min:0});
						loc3.addEventListener("validate",this);
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
					default:
						switch(null)
						{
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
							default:
								switch(null)
								{
									case "_btnRCollect":
										if(this._btnRCollect.selected)
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value | 512;
										}
										else
										{
											this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 512;
										}
										break;
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
	function validate(loc2)
	{
		var loc3 = loc2.value;
		if(_global.isNaN(loc3))
		{
			return undefined;
		}
		if(loc3 > 90)
		{
			return undefined;
		}
		if(loc3 < 0)
		{
			return undefined;
		}
		this._oMemberClone.percentxp = loc3;
		this.updateData();
	}
	function yes(loc2)
	{
		this.setRank(1);
	}
}
