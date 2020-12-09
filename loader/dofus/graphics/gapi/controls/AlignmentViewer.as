class dofus.graphics.gapi.controls.AlignmentViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "AlignmentViewer";
	var _sCurrentTab = "Specialization";
	function AlignmentViewer()
	{
		super();
	}
	function __set__enable(§\x1d\x03§)
	{
		this._lblAlignment._visible = var2;
		this._pbAlignment._visible = var2;
		this._mcAlignment._visible = var2;
		return this.__get__enable();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.AlignmentViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this._pbAlignment._visible = false;
		this._lblAlignment._visible = false;
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("ALIGNMENT");
		this._lblAlignment.text = this.api.lang.getText("LEVEL");
	}
	function addListeners()
	{
		this.api.datacenter.Player.addEventListener("alignmentChanged",this);
	}
	function initData()
	{
		this._sCurrentTab = "Specialization";
		this.alignmentChanged({alignment:this.api.datacenter.Player.alignment});
	}
	function updateCurrentTabInformations()
	{
		this._mcTab.removeMovieClip();
		if((var var0 = this._sCurrentTab) !== "Specialization")
		{
			if(var0 === "Rank")
			{
				this.attachMovie("RankViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y});
			}
		}
		else
		{
			this.attachMovie("SpecializationViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y});
		}
	}
	function setCurrentTab(§\x1e\x10\x04§)
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
	function alignmentChanged(oEvent)
	{
		this._mcTab.removeMovieClip();
		this._ldrIcon.contentPath = oEvent.alignment.iconFile;
		this._lblTitle.text = this.api.lang.getText("ALIGNMENT") + " " + oEvent.alignment.name;
		if(this.api.datacenter.Player.alignment.index != 0)
		{
			this.enable = true;
			this._lblNoAlignement.text = "";
			this._pbAlignment.value = oEvent.alignment.value;
			this._mcAlignment.onRollOver = function()
			{
				this._parent.gapi.showTooltip(new ank.utils.(oEvent.alignment.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._pbAlignment.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
			};
			this._mcAlignment.onRollOut = function()
			{
				this._parent.gapi.hideTooltip();
			};
			this.setCurrentTab(this._sCurrentTab);
		}
		else if(this._lblNoAlignement.text != undefined)
		{
			this.enable = false;
			this._lblNoAlignement.text = this.api.lang.getText("NO_ALIGNEMENT");
		}
	}
}
