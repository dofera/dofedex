class dofus.datacenter.PrismSprite extends dofus.datacenter.PlayableCharacter
{
	function PrismSprite(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID);
	}
	function __get__name()
	{
		return this.api.lang.getMonstersText(this._nLinkedMonsterId).n;
	}
	function __set__linkedMonster(loc2)
	{
		this._nLinkedMonsterId = loc2;
		return this.__get__linkedMonster();
	}
	function __get__linkedMonster()
	{
		return this._nLinkedMonsterId;
	}
	function __set__alignment(loc2)
	{
		this._aAlignment = loc2;
		return this.__get__alignment();
	}
	function __get__alignment()
	{
		return this._aAlignment;
	}
}
