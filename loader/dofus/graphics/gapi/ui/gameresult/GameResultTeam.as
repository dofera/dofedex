class dofus.graphics.gapi.ui.gameresult.GameResultTeam extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GameResultTeam";
	function GameResultTeam()
	{
		super();
	}
	function __set__title(var2)
	{
		this._sTitle = var2;
		return this.__get__title();
	}
	function __set__dataProvider(var2)
	{
		this._eaDataProvider = var2;
		return this.__get__dataProvider();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.gameresult.GameResultTeam.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
		this._lstPlayers._visible = false;
	}
	function addListeners()
	{
	}
	function initTexts()
	{
		this._lblWinLoose.text = this._sTitle;
		this._lblName.text = this.api.lang.getText("NAME_BIG");
		this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
		this._lblKama.text = this.api.lang.getText("KAMAS");
		this._lblXP.text = this.api.lang.getText("WIN_XP");
		this._lblMountXP.text = this.api.lang.getText("XP_MOUNT");
		this._lblGuildXP.text = this.api.lang.getText("XP_GUILD");
		this._lblItems.text = this.api.lang.getText("WIN_ITEMS");
	}
	function initData()
	{
		var var2 = this._eaDataProvider.length;
		this._lstPlayers.dataProvider = this._eaDataProvider;
		this._lstPlayers.setSize(undefined,Math.min(var2,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * this._lstPlayers.rowHeight);
		this._lstPlayers._visible = true;
	}
	function itemRollOver(var2)
	{
	}
	function itemRollOut(var2)
	{
		this.gapi.hideTooltip();
	}
}
