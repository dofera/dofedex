class dofus.graphics.gapi.ui.ChooseServer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChooseServer";
	function ChooseServer()
	{
		super();
	}
	function __set__servers(var2)
	{
		this._eaServers = var2;
		return this.__get__servers();
	}
	function __set__serverID(var2)
	{
		this._nServerID = var2;
		return this.__get__serverID();
	}
	function __set__remainingTime(var2)
	{
		this._nRemainingTime = var2;
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
			var var2 = this._parent.api.lang.getText("PSEUDO_DOFUS_LINK");
			if(var2 != undefined && var2 != "")
			{
				this.getURL(var2,"_blank");
			}
		};
		this._eaFavoriteServers = new ank.utils.();
		var var2 = 0;
		while(var2 < this._eaServers.length)
		{
			if(this._eaServers[var2].charactersCount > 0)
			{
				this._eaFavoriteServers.push(this._eaServers[var2]);
			}
			var2 = var2 + 1;
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
			var var2 = 0;
			while(var2 < 5)
			{
				var var3 = this._eaFavoriteServers[var2 + this._nServerStartIndex];
				if(var3 != undefined)
				{
					var var4 = this["_css" + var2];
					var4._visible = true;
					var4.index = var2;
					var4.serverID = var3.id;
					var4.addEventListener("select",this);
					var4.addEventListener("unselect",this);
					var4.addEventListener("remove",this);
					this["_mcServerEmpty" + var2]._visible = false;
				}
				else
				{
					this["_css" + var2]._visible = false;
					this["_mcServerEmpty" + var2]._visible = true;
				}
				var2 = var2 + 1;
			}
			this._txtWhy._visible = false;
			this._btnAutomaticSelection._visible = false;
		}
		else
		{
			var var5 = 0;
			while(var5 < 5)
			{
				this["_mcServerEmpty" + var5]._visible = false;
				this["_css" + var5]._visible = false;
				var5 = var5 + 1;
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
	function selectServer(var2)
	{
		if(_global.isNaN(var2))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CHOOSE_SERVER"),"ERROR_BOX");
		}
		else
		{
			var var3 = this.api.datacenter.Basics.aks_servers.findFirstItem("id",var2).item;
			if(var3.state == dofus.datacenter.Server.SERVER_ONLINE)
			{
				var var4 = new dofus.datacenter.	(var2,1,0);
				if(var4.isAllowed())
				{
					this.api.datacenter.Basics.aks_current_server = var4;
					this.api.network.Account.setServer(var2);
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
	function select(var2)
	{
		var var3 = 0;
		while(var3 < 5)
		{
			this["_css" + var3].selected = false;
			var3 = var3 + 1;
		}
		var2.target.selected = true;
		var var4 = var2.target.serverID;
		var var5 = this._nServerID;
		this._nServerID = var4;
		if(var5 == var4)
		{
			this.click({target:this._btnSelect});
		}
	}
	function unselect(var2)
	{
		var var3 = var2.target.serverID;
		if(this._nServerID == var3)
		{
			delete this._nServerID;
		}
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnSelect":
				var var3 = this.gapi.getUIComponent("ServerList");
				if(var3 != undefined)
				{
					this._nServerID = var3.selectedServerID;
					var3.onServerSelected();
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
				if(var0 !== "_btnSubscribe")
				{
					break;
				}
				_root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
				break;
		}
	}
	function serverSelected(var2)
	{
		this.api.datacenter.Basics.createCharacter = true;
		this.gapi.unloadUIComponent("ServerList");
		this.selectServer(var2.serverID);
	}
}
