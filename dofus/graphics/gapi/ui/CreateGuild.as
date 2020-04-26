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
		this._eaBacks = new ank.utils.();
		var loc2 = 1;
		while(loc2 <= dofus.Constants.EMBLEM_BACKS_COUNT)
		{
			this._eaBacks.push({iconFile:dofus.Constants.EMBLEMS_BACK_PATH + loc2 + ".swf"});
			loc2 = loc2 + 1;
		}
		this._eaUps = new ank.utils.();
		var loc3 = 1;
		while(loc3 <= dofus.Constants.EMBLEM_UPS_COUNT)
		{
			this._eaUps.push({iconFile:dofus.Constants.EMBLEMS_UP_PATH + loc3 + ".swf"});
			loc3 = loc3 + 1;
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
	function setCurrentTab(loc2)
	{
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._sCurrentTab = loc2;
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
	function setEnabled(loc2)
	{
		this._btnCancel.enabled = this._bEnabled;
		this._btnClose.enabled = this._bEnabled;
		this._btnCreate.enabled = this._bEnabled;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.api.network.Guild.leave();
				break;
			default:
				switch(null)
				{
					case "_btnCreate":
						var loc3 = this._itName.text;
						if(loc3 == undefined || loc3.length < 3)
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
							var loc4 = new dofus.utils.nameChecker.
(loc3);
							var loc5 = new dofus.utils.nameChecker.rules.	();
							var loc6 = loc4.isValidAgainstWithDetails(loc5);
							if(!loc6.IS_SUCCESS)
							{
								this.api.kernel.showMessage(undefined,this.api.lang.getText("INVALID_GUILD_NAME") + "\r\n" + loc6.toString("\r\n"),"ERROR_BOX");
								return undefined;
							}
						}
						this.enabled = false;
						this.api.network.Guild.create(this._nBackID,this._nBackColor,this._nUpID,this._nUpColor,loc3);
						break;
					case "_btnTabBack":
						this.setCurrentTab("Back");
						break;
					case "_btnTabUp":
						this.setCurrentTab("Up");
				}
		}
	}
	function change(loc2)
	{
		switch(this._sCurrentTab)
		{
			case "Back":
				this._nBackColor = loc2.value;
				this.updateBack();
				break;
			case "Up":
				this._nUpColor = loc2.value;
				this.updateUp();
		}
	}
	function selectItem(loc2)
	{
		switch(this._sCurrentTab)
		{
			case "Back":
				this._nBackID = loc2.owner.selectedIndex + 1;
				this.updateBack();
				break;
			case "Up":
				this._nUpID = loc2.owner.selectedIndex + 1;
				this.updateUp();
		}
	}
}
