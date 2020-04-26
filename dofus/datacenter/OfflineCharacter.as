class dofus.datacenter.OfflineCharacter extends ank.battlefield.datacenter.Sprite
{
	var xtraClipTopAnimations = {staticL:true,staticF:true,staticR:true};
	function OfflineCharacter(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super();
		if(this.__proto__ == dofus.datacenter.OfflineCharacter.prototype)
		{
			this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID);
		}
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
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
	function __set__gfxID(loc2)
	{
		this._gfxID = loc2;
		return this.__get__gfxID();
	}
	function initialize(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super.initialize(sID,clipClass,loc5,cellNum,loc7);
		this._gfxID = gfxID;
	}
	function __set__guildName(loc2)
	{
		this._sGuildName = loc2;
		return this.__get__guildName();
	}
	function __get__guildName()
	{
		return this._sGuildName;
	}
	function __set__emblem(loc2)
	{
		this._oEmblem = loc2;
		return this.__get__emblem();
	}
	function __get__emblem()
	{
		return this._oEmblem;
	}
	function __set__offlineType(loc2)
	{
		this._sOfflineType = loc2;
		return this.__get__offlineType();
	}
	function __get__offlineType()
	{
		return this._sOfflineType;
	}
}
