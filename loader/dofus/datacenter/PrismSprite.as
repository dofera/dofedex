class dofus.datacenter.PrismSprite extends dofus.datacenter.PlayableCharacter
{
	function PrismSprite(sID, clipClass, §\x1e\x12\f§, §\x13\n§, §\x11\b§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,var5,var6,var7,gfxID);
	}
	function __get__name()
	{
		return this.api.lang.getMonstersText(this._nLinkedMonsterId).n;
	}
	function __set__linkedMonster(§\x1e\n\x0f§)
	{
		this._nLinkedMonsterId = var2;
		return this.__get__linkedMonster();
	}
	function __get__linkedMonster()
	{
		return this._nLinkedMonsterId;
	}
	function __set__alignment(§\x1e\n\x0f§)
	{
		this._aAlignment = var2;
		return this.__get__alignment();
	}
	function __get__alignment()
	{
		return this._aAlignment;
	}
}
