class dofus.graphics.gapi.ui.ChooseServer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseServer";
	function ChooseServer()
	{
		super();
	}
	function __set__servers(loc2)
	{
		this._eaServers = loc2;
		return this.__get__servers();
	}
	function __set__serverID(loc2)
	{
		this._nServerID = loc2;
		return this.__get__serverID();
	}
	function __set__remainingTime(loc2)
	{
		this._nRemainingTime = loc2;
		return this.__get__remainingTime();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ChooseServer.CLASS_NAME);
		if(this.api.datacenter.Basics.aks_is_free_community)
		{
			this._btnSubscribe._visible = false;
		}
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._btnSelect.addEventListener("click",this);
		this._btnCreate.addEventListener("click",this);
		this._btnSubscribe.addEventListener("click",this);
		this._btnAutomaticSelection.addEventListener("click",this);
	}
	function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("CHOOSE_SERVER");
		this._lblWhy.text = this.api.lang.getText("CHOOSE_SERVER_WHY");
		this._btnSelect.label = this.api.lang.getText("SELECT");
		this._btnCreate.label = this.api.lang.getText("CREATE_CHARACTER");
		this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
		this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
		this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
		if(!this.api.config.isStreaming)
		{
			this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS",[this.api.datacenter.Basics.dofusPseudo]);
		}
		else
		{
			this._lblLogin.text = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
		}
	}
	function initData()
	{
		this.api.datacenter.Basics.createCharacter = false;
		this._nServerStartIndex = 0;
		this._lblRemainingTime.text = this.api.kernel.GameManager.getRemainingString(this._nRemainingTime);
		this._lblRemainingTime.styleName = this._nRemainingTime != 0?"WhiteRightSmallBoldLabel":"RedRightSmallBoldLabel";
		this._btnSubscribe.enabled = this._nRemainingTime != -1;
		this._lblLogin.onRollOver = function()
		{
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("PSEUDO_DOFUS_INFOS"),this,20,undefined);
		};
		this._lblLogin.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._lblLogin.onRelease = function()
		{
			var loc2 = this._parent.api.lang.getText("PSEUDO_DOFUS_LINK");
			if(loc2 != undefined && loc2 != "")
			{
				this.getURL(loc2,"_blank");
			}
		};
		this._eaFavoriteServers = new ank.utils.();
		var loc2 = 0;
		while(loc2 < this._eaServers.length)
		{
			if(this._eaServers[loc2].charactersCount > 0)
			{
				this._eaFavoriteServers.push(this._eaServers[loc2]);
			}
			loc2 = loc2 + 1;
		}
		this._eaFavoriteServers.bubbleSortOn("charactersCount",Array.DESCENDING);
		this._btnArrowLeft._visible = this._btnArrowRight._visible = this._eaFavoriteServers.length > 5;
		this._btnArrowLeft.onRelease = function()
		{
			this._parent._btnArrowLeft.gotoAndStop("on");
			this._parent._btnArrowRight.gotoAndStop("on");
			this._parent._nServerStartIndex--;
			if(this._parent._nServerStartIndex <= 0)
			{
				this._parent._nServerStartIndex = 0;
				this.gotoAndStop("off");
			}
			this._parent.updateServerList();
		};
		this._btnArrowRight.onRelease = function()
		{
			this._parent._btnArrowLeft.gotoAndStop("on");
			this._parent._btnArrowRight.gotoAndStop("on");
			this._parent._nServerStartIndex++;
			if(this._parent._nServerStartIndex >= this._parent._eaFavoriteServers.length - 5)
			{
				this._parent._nServerStartIndex = this._parent._eaFavoriteServers.length - 5;
				this.gotoAndStop("off");
			}
			this._parent.updateServerList();
		};
		this._btnArrowLeft.onRelease();
		if(this.api.datacenter.Basics.first_connection_from_miniclip)
		{
			this.click({target:{_name:"_btnCreate"}});
		}
	}
	function updateServerList()
	{
		if(this._eaFavoriteServers.length > 0)
		{
			var loc2 = 0;
			while(loc2 < 5)
			{
				var loc3 = this._eaFavoriteServers[loc2 + this._nServerStartIndex];
				if(loc3 != undefined)
				{
					var loc4 = this["_css" + loc2];
					loc4._visible = true;
					loc4.index = loc2;
					loc4.serverID = loc3.id;
					loc4.addEventListener("select",this);
					loc4.addEventListener("unselect",this);
					loc4.addEventListener("remove",this);
					this["_mcServerEmpty" + loc2]._visible = false;
				}
				else
				{
					this["_css" + loc2]._visible = false;
					this["_mcServerEmpty" + loc2]._visible = true;
				}
				loc2 = loc2 + 1;
			}
			this._txtWhy._visible = false;
			this._btnAutomaticSelection._visible = false;
		}
		else
		{
			var loc5 = 0;
			while(loc5 < 5)
			{
				this["_mcServerEmpty" + loc5]._visible = false;
				this["_css" + loc5]._visible = false;
				loc5 = loc5 + 1;
			}
			this._btnAutomaticSelection.label = this.api.lang.getText("AUTOMATIC_SERVER_SELECTION");
			this._txtWhy.text = this.api.lang.getText("CHOOSE_SERVER_WHY_BLABLA");
		}
		if(this.api.datacenter.Basics.isCreatingNewCharacter)
		{
			this.api.datacenter.Basics.hasForcedManualSelection = true;
			this.click({target:this._btnCreate});
			this.api.datacenter.Basics.isCreatingNewCharacter = false;
			this.api.datacenter.Basics.hasForcedManualSelection = false;
		}
	}
	function selectServer(loc2)
	{
		if(_global.isNaN(loc2))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CHOOSE_SERVER"),"ERROR_BOX");
		}
		else
		{
			var loc3 = this.api.datacenter.Basics.aks_servers.findFirstItem("id",loc2).item;
			if(loc3.state == dofus.datacenter.Server.SERVER_ONLINE)
			{
				var loc4 = new dofus.datacenter.(loc2,1,0);
				if(loc4.isAllowed())
				{
					this.api.datacenter.Basics.aks_current_server = loc4;
					this.api.network.Account.setServer(loc2);
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"),"ERROR_BOX");
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"),"ERROR_BOX");
			}
		}
	}
	function select(loc2)
	{
		var loc3 = 0;
		while(loc3 < 5)
		{
			this["_css" + loc3].selected = false;
			loc3 = loc3 + 1;
		}
		loc2.target.selected = true;
		var loc4 = loc2.target.serverID;
		var loc5 = this._nServerID;
		this._nServerID = loc4;
		if(loc5 == loc4)
		{
			this.click({target:this._btnSelect});
		}
	}
	function unselect(loc2)
	{
		var loc3 = loc2.target.serverID;
		if(this._nServerID == loc3)
		{
			delete this._nServerID;
		}
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnSelect":
				var loc3 = this.gapi.getUIComponent("ServerList");
				if(loc3 != undefined)
				{
					this._nServerID = loc3.selectedServerID;
					loc3.onServerSelected();
				}
				else
				{
					this.api.datacenter.Basics.createCharacter = false;
					this.selectServer(this._nServerID);
				}
				break;
			case "_btnCreate":
				if(this.api.datacenter.Basics.hasForcedManualSelection || this.api.datacenter.Basics.first_connection_from_miniclip)
				{
					this.gapi.loadUIComponent("ServerList","ServerList",{servers:this.api.datacenter.Basics.aks_servers});
					this.gapi.getUIComponent("ServerList").addEventListener("serverSelected",this);
					this.api.datacenter.Basics.hasForcedManualSelection = false;
					break;
				}
			case "_btnAutomaticSelection":
				this.api.datacenter.Basics.forceAutomaticServerSelection = true;
				this.api.network.Account.getServersList();
				this.api.datacenter.Basics.isCreatingNewCharacter = true;
				break;
			default:
				if(loc0 !== "_btnSubscribe")
				{
					break;
				}
				_root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
				break;
		}
	}
	function serverSelected(loc2)
	{
		this.api.datacenter.Basics.createCharacter = true;
		this.gapi.unloadUIComponent("ServerList");
		this.selectServer(loc2.serverID);
	}
}
