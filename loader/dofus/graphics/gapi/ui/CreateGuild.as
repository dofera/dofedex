class dofus.graphics.gapi.ui.CreateGuild extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CreateGuild";
	var _nBackColor = 14933949;
	var _nUpColor = 0;
	var _sCurrentTab = "Back";
	function CreateGuild()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CreateGuild.CLASS_NAME);
	}
	function callClose()
	{
		if(this._bEnabled)
		{
			this.api.network.Guild.leave();
			return true;
		}
		return false;
	}
	function createChildren()
	{
		this._eaBacks = new ank.utils.();
		var var2 = 1;
		while(var2 <= dofus.Constants.EMBLEM_BACKS_COUNT)
		{
			this._eaBacks.push({iconFile:dofus.Constants.EMBLEMS_BACK_PATH + var2 + ".swf"});
			var2 = var2 + 1;
		}
		this._eaUps = new ank.utils.();
		var var3 = 1;
		while(var3 <= dofus.Constants.EMBLEM_UPS_COUNT)
		{
			this._eaUps.push({iconFile:dofus.Constants.EMBLEMS_UP_PATH + var3 + ".swf"});
			var3 = var3 + 1;
		}
		this._nBackID = 1;
		this._nUpID = 1;
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.setTextFocus});
		this.addToQueue({object:this,method:this.updateCurrentTabInformations});
		this.addToQueue({object:this,method:this.updateBack});
		this.addToQueue({object:this,method:this.updateUp});
	}
	function initTexts()
	{
		this._winBg.title = this.api.lang.getText("GUILD_CREATION");
		this._lblName.text = this.api.lang.getText("GUILD_NAME");
		this._lblEmblem.text = this.api.lang.getText("EMBLEM");
		this._lblColors.text = this.api.lang.getText("CREATE_COLOR");
		this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		this._btnCreate.label = this.api.lang.getText("CREATE");
		this._btnTabBack.label = this.api.lang.getText("EMBLEM_BACK");
		this._btnTabUp.label = this.api.lang.getText("EMBLEM_UP");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnCancel.addEventListener("click",this);
		this._btnCreate.addEventListener("click",this);
		this._btnTabBack.addEventListener("click",this);
		this._btnTabUp.addEventListener("click",this);
		this._cpColors.addEventListener("change",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.multipleContainerSelectionEnabled = false;
	}
	function setTextFocus()
	{
		this._itName.setFocus();
	}
	function updateCurrentTabInformations()
	{
		switch(this._sCurrentTab)
		{
			case "Back":
				this._cpColors.setColor(this._nBackColor);
				this._cgGrid.dataProvider = this._eaBacks;
				this._cgGrid.selectedIndex = this._nBackID - 1;
				break;
			case "Up":
				this._cpColors.setColor(this._nUpColor);
				this._cgGrid.dataProvider = this._eaUps;
				this._cgGrid.selectedIndex = this._nUpID - 1;
		}
	}
	function setCurrentTab(var2)
	{
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		this._sCurrentTab = var2;
		this.updateCurrentTabInformations();
	}
	function updateBack()
	{
		this._eEmblem.backID = this._nBackID;
		this._eEmblem.backColor = this._nBackColor;
	}
	function updateUp()
	{
		this._eEmblem.upID = this._nUpID;
		this._eEmblem.upColor = this._nUpColor;
	}
	function setEnabled(var2)
	{
		this._btnCancel.enabled = this._bEnabled;
		this._btnClose.enabled = this._bEnabled;
		this._btnCreate.enabled = this._bEnabled;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.api.network.Guild.leave();
				break;
			case "_btnCreate":
				var var3 = this._itName.text;
				if(var3 == undefined || var3.length < 3)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("BAD_GUILD_NAME"),"ERROR_BOX");
					return undefined;
				}
				if(this._nBackID == undefined || this._nUpID == undefined)
				{
					return undefined;
				}
				if(this.api.lang.getConfigText("GUILD_NAME_FILTER"))
				{
					var var4 = new dofus.utils.nameChecker.(var3);
					var var5 = new dofus.utils.nameChecker.rules.();
					var var6 = var4.isValidAgainstWithDetails(var5);
					if(!var6.IS_SUCCESS)
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("INVALID_GUILD_NAME") + "\r\n" + var6.toString("\r\n"),"ERROR_BOX");
						return undefined;
					}
				}
				this.enabled = false;
				this.api.network.Guild.create(this._nBackID,this._nBackColor,this._nUpID,this._nUpColor,var3);
				break;
			default:
				switch(null)
				{
					case "_btnTabBack":
						this.setCurrentTab("Back");
						break;
					case "_btnTabUp":
						this.setCurrentTab("Up");
				}
		}
	}
	function change(var2)
	{
		switch(this._sCurrentTab)
		{
			case "Back":
				this._nBackColor = var2.value;
				this.updateBack();
				break;
			case "Up":
				this._nUpColor = var2.value;
				this.updateUp();
		}
	}
	function selectItem(var2)
	{
		switch(this._sCurrentTab)
		{
			case "Back":
				this._nBackID = var2.owner.selectedIndex + 1;
				this.updateBack();
				break;
			case "Up":
				this._nUpID = var2.owner.selectedIndex + 1;
				this.updateUp();
		}
	}
}
