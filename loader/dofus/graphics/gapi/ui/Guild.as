class dofus.graphics.gapi.ui.Guild extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Guild";
	var _sCurrentTab = "Members";
	function Guild()
	{
		super();
	}
	function __set__currentTab(§\x1e\r\x10§)
	{
		this._sCurrentTab = var2;
		return this.__get__currentTab();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Guild.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.unloadUIComponent("GuildMemberInfos");
		this.gapi.hideTooltip();
		this.api.datacenter.Player.guildInfos.removeEventListener("modelChanged",this);
		this.checkIfLocalPlayerIsDefender();
		if(this._sCurrentTab == "TaxCollectors")
		{
			this.api.network.Guild.leaveTaxInterface();
		}
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this.api.network.Guild,method:this.api.network.Guild.getInfosGeneral});
		this.addToQueue({object:this,method:this.setCurrentTab,params:[this._sCurrentTab]});
		this._mcPlacer._visible = false;
		this._mcCaution._visible = this._lblValid._visible = false;
	}
	function initTexts()
	{
		this._btnTabMembers.label = this.api.lang.getText("GUILD_MEMBERS");
		this._btnTabBoosts.label = this.api.lang.getText("GUILD_BOOSTS");
		this._btnTabTaxCollectors.label = this.api.lang.getText("GUILD_TAXCOLLECTORS");
		this._btnTabMountParks.label = this.api.lang.getText("MOUNT_PARK");
		this._btnTabGuildHouses.label = this.api.lang.getText("HOUSES_WORD");
		this._lblXP.text = this.api.lang.getText("EXPERIMENT");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnTabMembers.addEventListener("click",this);
		this._btnTabBoosts.addEventListener("click",this);
		this._btnTabTaxCollectors.addEventListener("click",this);
		this._btnTabMountParks.addEventListener("click",this);
		this._btnTabGuildHouses.addEventListener("click",this);
		this.api.datacenter.Player.guildInfos.addEventListener("modelChanged",this);
		this._pbXP.addEventListener("over",this);
		this._pbXP.addEventListener("out",this);
	}
	function initData()
	{
		var var2 = this.api.datacenter.Player.guildInfos;
		var var3 = var2.emblem;
		this._eEmblem.backID = var3.backID;
		this._eEmblem.backColor = var3.backColor;
		this._eEmblem.upID = var3.upID;
		this._eEmblem.upColor = var3.upColor;
		this._winBg.title = this.api.lang.getText("GUILD") + " \'" + var2.name + "\'";
	}
	function updateCurrentTabInformations()
	{
		this._mcTabViewer.removeMovieClip();
		switch(this._sCurrentTab)
		{
			case "Members":
				this.attachMovie("GuildMembersViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
				this.api.datacenter.Player.guildInfos.members.removeAll();
				this.api.network.Guild.getInfosMembers();
				break;
			case "Boosts":
				this.attachMovie("GuildBoostsViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
				this.api.network.Guild.getInfosBoosts();
				break;
			default:
				switch(null)
				{
					case "TaxCollectors":
						this.attachMovie("TaxCollectorsViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
						this.api.datacenter.Player.guildInfos.taxCollectors.removeAll();
						this.api.network.Guild.getInfosTaxCollector();
						break;
					case "MountParks":
						this.attachMovie("GuildMountParkViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
						this.api.network.Guild.getInfosMountPark();
						break;
					case "GuildHouses":
						this.attachMovie("GuildHousesViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
						this.api.network.Guild.getInfosGuildHouses();
				}
		}
	}
	function setCurrentTab(§\x1e\x10\x04§)
	{
		if(this._sCurrentTab == "TaxCollectors")
		{
			this.api.network.Guild.leaveTaxInterface();
		}
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		this._sCurrentTab = var2;
		this.updateCurrentTabInformations();
	}
	function checkIfLocalPlayerIsDefender()
	{
		var var2 = this.api.datacenter.Player.guildInfos;
		if(var2.isLocalPlayerDefender)
		{
			this.api.network.Guild.leaveTaxCollector(var2.defendedTaxCollectorID);
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("AUTO_DISJOIN_TAX"),"ERROR_BOX");
		}
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_btnTabMembers":
				this.setCurrentTab("Members");
				break;
			default:
				switch(null)
				{
					case "_btnTabBoosts":
						if(this.api.datacenter.Player.guildInfos.isValid)
						{
							this.setCurrentTab("Boosts");
						}
						else
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
							var2.target.selected = true;
						}
						break;
					case "_btnTabTaxCollectors":
						if(this.api.datacenter.Player.guildInfos.isValid)
						{
							this.setCurrentTab("TaxCollectors");
						}
						else
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
							var2.target.selected = true;
						}
						break;
					case "_btnTabMountParks":
						if(this.api.datacenter.Player.guildInfos.isValid)
						{
							this.setCurrentTab("MountParks");
						}
						else
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
							var2.target.selected = true;
						}
						break;
					case "_btnTabGuildHouses":
						if(this.api.datacenter.Player.guildInfos.isValid)
						{
							this.setCurrentTab("GuildHouses");
							break;
						}
						this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
						var2.target.selected = true;
						break;
				}
		}
	}
	function over(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "_pbXP")
		{
			this.gapi.showTooltip(new ank.utils.(this._pbXP.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._pbXP.maximum).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this._pbXP,-20);
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		loop0:
		switch(var2.eventName)
		{
			case "infosUpdate":
				this.initData();
				break;
			case "general":
				var var3 = this.api.datacenter.Player.guildInfos;
				this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + var3.level;
				this._pbXP.minimum = var3.xpmin;
				this._pbXP.maximum = var3.xpmax;
				this._pbXP.value = var3.xp;
				this._pbXP.onRollOver = function()
				{
					this._parent.gapi.showTooltip(this.value + " / " + this.maximum,this,-20);
				};
				this._pbXP.onRollOut = function()
				{
					this._parent.gapi.hideTooltip();
				};
				if(var3.isValid)
				{
					this._y = 0;
					this._lblValid._visible = var0 = false;
					this._mcCaution._visible = var0;
				}
				else
				{
					this._y = -20;
					this._lblValid._visible = var0 = true;
					this._mcCaution._visible = var0;
					this._lblValid.text = this.api.lang.getText("GUILD_INVALID_INFOS");
				}
				break;
			case "members":
				if(this._sCurrentTab == "Members")
				{
					this._mcTabViewer.members = this.api.datacenter.Player.guildInfos.members;
				}
				break;
			case "boosts":
				if(this._sCurrentTab == "Boosts")
				{
					this._mcTabViewer.updateData();
				}
				break;
			default:
				switch(null)
				{
					case "taxcollectors":
						if(this._sCurrentTab == "TaxCollectors")
						{
							this._mcTabViewer.taxCollectors = this.api.datacenter.Player.guildInfos.taxCollectors;
						}
						break loop0;
					case "noboosts":
					case "notaxcollectors":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
						this.setCurrentTab("Members");
						break loop0;
					case "mountParks":
						if(this._sCurrentTab == "MountParks")
						{
							this._mcTabViewer.mountParks = this.api.datacenter.Player.guildInfos.mountParks;
						}
						break loop0;
					default:
						if(var0 !== "houses")
						{
							break loop0;
						}
						if(this._sCurrentTab == "GuildHouses")
						{
							this._mcTabViewer.houses = this.api.datacenter.Player.guildInfos.houses;
							break loop0;
						}
						break loop0;
				}
		}
	}
}
