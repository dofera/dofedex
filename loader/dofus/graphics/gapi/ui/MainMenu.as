class dofus.graphics.gapi.ui.MainMenu extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MainMenu";
	var _sQuitMode = "no";
	function MainMenu()
	{
		super();
	}
	function __set__quitMode(§\x1e\x0e\x15§)
	{
		this._sQuitMode = var2;
		if(this.initialized)
		{
			this.setQuitButtonStatus();
		}
		return this.__get__quitMode();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MainMenu.CLASS_NAME);
		this._btnBugs._visible = false;
		this._btnSubscribe._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.setQuitButtonStatus});
	}
	function addListeners()
	{
		this._btnQuit.addEventListener("click",this);
		this._btnOptions.addEventListener("click",this);
		this._btnHelp.addEventListener("click",this);
		this._btnBugs.addEventListener("click",this);
		this._btnSubscribe.addEventListener("click",this);
		this._btnQuit.addEventListener("over",this);
		this._btnOptions.addEventListener("over",this);
		this._btnHelp.addEventListener("over",this);
		this._btnBugs.addEventListener("over",this);
		this._btnSubscribe.addEventListener("over",this);
		this._btnQuit.addEventListener("out",this);
		this._btnOptions.addEventListener("out",this);
		this._btnHelp.addEventListener("out",this);
		this._btnBugs.addEventListener("out",this);
		this._btnSubscribe.addEventListener("out",this);
	}
	function setQuitButtonStatus()
	{
		this._btnQuit.enabled = this._sQuitMode != "no";
		if(dofus.Constants.BETAVERSION > 0)
		{
			this._mcBackground._x = 730;
			this._bBackgroundMoved = true;
			this._btnBugs._visible = true;
		}
		else if(!this.api.datacenter.Player.subscriber && !this.api.datacenter.Basics.aks_is_free_community)
		{
			this._mcBackground._x = 730;
			this._bBackgroundMoved = true;
			this._btnSubscribe._visible = true;
		}
		else
		{
			this._btnBugs._visible = false;
		}
	}
	function updateSubscribeButton()
	{
		if(dofus.Constants.BETAVERSION == 0 && (!this.api.datacenter.Player.subscriber && !this.api.datacenter.Basics.aks_is_free_community))
		{
			if(!this._bBackgroundMoved)
			{
				this._mcBackground._x = 730;
				this._bBackgroundMoved = true;
			}
			this._btnSubscribe._visible = true;
		}
		else if(!this._btnBugs._visible)
		{
			if(this._bBackgroundMoved)
			{
				this._mcBackground._x = 744.3;
				this._bBackgroundMoved = false;
			}
			this._btnSubscribe._visible = false;
		}
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._btnQuit:
				if(this._sQuitMode == "quit")
				{
					this.api.kernel.quit(false);
				}
				else if(this._sQuitMode == "menu")
				{
					this.gapi.loadUIComponent("AskMainMenu","AskMainMenu");
				}
				break;
			case this._btnOptions:
				this.gapi.loadUIComponent("Options","Options",{_y:(this.gapi.screenHeight != 432?0:-50)},{bAlwaysOnTop:true});
				break;
			case this._btnHelp:
				if(this.api.ui.getUIComponent("Banner") != undefined)
				{
					this.gapi.loadUIComponent("KnownledgeBase","KnownledgeBase");
				}
				else
				{
					_root.getURL(this.api.lang.getConfigText("TUTORIAL_FILE"),"_blank");
				}
				break;
			default:
				switch(null)
				{
					case this._btnSubscribe:
						_root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
						break;
					case this._btnBugs:
						_root.getURL(this.api.lang.getConfigText("BETA_BUGS_REPORT"),"_blank");
				}
		}
	}
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._btnQuit:
				this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_QUIT"),var2.target,20,{bXLimit:true,bYLimit:true});
				break;
			case this._btnOptions:
				this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_OPTIONS"),var2.target,20,{bXLimit:true,bYLimit:true});
				break;
			case this._btnHelp:
				if(this.api.ui.getUIComponent("Banner") != undefined)
				{
					this.api.ui.showTooltip(this.api.lang.getText("KB_TITLE"),var2.target,20,{bXLimit:true,bYLimit:true});
				}
				else
				{
					this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_HELP"),var2.target,20,{bXLimit:true,bYLimit:true});
				}
				break;
			default:
				switch(null)
				{
					case this._btnBugs:
						this.api.ui.showTooltip(this.api.lang.getText("MAIN_MENU_BUGS"),var2.target,20,{bXLimit:true,bYLimit:true});
						break;
					case this._btnSubscribe:
						this.api.ui.showTooltip(this.api.lang.getText("SUBSCRIPTION"),var2.target,20,{bXLimit:true,bYLimit:true});
				}
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.api.ui.hideTooltip();
	}
}
