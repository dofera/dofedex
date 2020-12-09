class dofus.datacenter.OfflineCharacter extends ank.battlefield.datacenter.Sprite
{
	var xtraClipTopAnimations = {staticL:true,staticF:true,staticR:true};
	function OfflineCharacter(sID, clipClass, §\x1e\x12\f§, §\x13\n§, §\x11\b§, gfxID)
	{
		super();
		if(this.__proto__ == dofus.datacenter.OfflineCharacter.prototype)
		{
			this.initialize(sID,clipClass,var5,var6,var7,gfxID);
		}
	}
	function __set__name(§\x1e\x10\x06§)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __get__gfxID()
	{
		return this._gfxID;
	}
	function __set__gfxID(§\x1e\n\x0f§)
	{
		this._gfxID = var2;
		return this.__get__gfxID();
	}
	function initialize(sID, clipClass, §\x1e\x12\f§, §\x13\n§, §\x11\b§, gfxID)
	{
		super.initialize(sID,clipClass,var5,var6,var7);
		this._gfxID = gfxID;
	}
	function __set__guildName(§\x1e\x12\b§)
	{
		this._sGuildName = var2;
		return this.__get__guildName();
	}
	function __get__guildName()
	{
		return this._sGuildName;
	}
	function __set__emblem(§\x1e\x19\x1a§)
	{
		this._oEmblem = var2;
		return this.__get__emblem();
	}
	function __get__emblem()
	{
		return this._oEmblem;
	}
	function __set__offlineType(§\x1e\x0f\x1a§)
	{
		this._sOfflineType = var2;
		return this.__get__offlineType();
	}
	function __get__offlineType()
	{
		return this._sOfflineType;
	}
}
