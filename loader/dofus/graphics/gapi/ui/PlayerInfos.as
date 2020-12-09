class dofus.graphics.gapi.ui.PlayerInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PlayerInfos";
	function PlayerInfos()
	{
		super();
	}
	function __set__data(§\x1e\x1a\x02§)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __get__data()
	{
		return this._oData;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.PlayerInfos.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
	}
	function initData()
	{
		if(this._oData != undefined)
		{
			this._winBackground.title = this.api.lang.getText("EFFECTS") + " " + this._oData.name + " (" + this.api.lang.getText("LEVEL_SMALL") + this._oData.Level + ")";
			this._lstEffects.dataProvider = this._oData.EffectsManager.getEffects();
			org.flashdevelop.utils.FlashConnect.mtrace(this._oData.states,"dofus.graphics.gapi.ui.PlayerInfos::initData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/graphics/gapi/ui/PlayerInfos.as",92);
		}
	}
	function quit()
	{
		this.unloadThis();
	}
	function click(§\x1e\x19\x18§)
	{
		this.unloadThis();
	}
}
