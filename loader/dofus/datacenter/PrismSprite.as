class dofus.datacenter.PrismSprite extends dofus.datacenter.PlayableCharacter
{
	function PrismSprite(sID, clipClass, §\x1e\x13\x14§, cellNum, §\x11\x1b§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,var5,cellNum,var7,gfxID);
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
