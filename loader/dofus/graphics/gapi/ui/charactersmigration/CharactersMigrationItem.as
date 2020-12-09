class dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CharactersMigrationItem";
	function CharactersMigrationItem()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function updatePlayerName(§\x1e\x10\x06§)
	{
		this._lblName.text = var2;
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = var4;
			this._ldrFace._visible = true;
			this._mcInputNickname._visible = true;
			this._lblName._visible = true;
			this._lblLevel._visible = true;
			this._lblLevel.text = var4.level;
			this._lblName.text = var4.newPlayerName;
			this.list = var4.list;
			this._ldrFace.contentPath = dofus.Constants.GUILDS_MINI_PATH + var4.gfxID + ".swf";
			this._oItem.ref = this;
		}
		else
		{
			this._ldrFace._visible = false;
			this._mcInputNickname._visible = false;
			this._lblName._visible = false;
			this._lblLevel._visible = false;
		}
	}
	function getValue()
	{
		return this._oItem;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
	}
	function initTexts()
	{
	}
	function click(§\x1e\x19\x18§)
	{
	}
}
