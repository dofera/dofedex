class dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CharactersMigrationItem";
	function CharactersMigrationItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function updatePlayerName(loc2)
	{
		this._lblName.text = loc2;
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			this._ldrFace._visible = true;
			this._mcInputNickname._visible = true;
			this._lblName._visible = true;
			this._lblLevel._visible = true;
			this._lblLevel.text = loc4.level;
			this._lblName.text = loc4.newPlayerName;
			this.list = loc4.list;
			this._ldrFace.contentPath = dofus.Constants.GUILDS_MINI_PATH + loc4.gfxID + ".swf";
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
	function click(loc2)
	{
	}
}
