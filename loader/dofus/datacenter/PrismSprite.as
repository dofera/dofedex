class dofus.datacenter.PrismSprite extends dofus.datacenter.PlayableCharacter
{
	function PrismSprite(sID, clipClass, §\x1e\x11\x1c§, §\x13\x05§, §\x10\x1d§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,var5,var6,var7,gfxID);
	}
	function __get__name()
	{
		return this.api.lang.getMonstersText(this._nLinkedMonsterId).n;
	}
	function __set__linkedMonster(var2)
	{
		this._nLinkedMonsterId = var2;
		return this.__get__linkedMonster();
	}
	function __get__linkedMonster()
	{
		return this._nLinkedMonsterId;
	}
	function __set__alignment(var2)
	{
		this._aAlignment = var2;
		return this.__get__alignment();
	}
	function __get__alignment()
	{
		return this._aAlignment;
	}
}
