class dofus.datacenter.LaunchedSpell
{
	function LaunchedSpell(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function __set__remainingTurn(loc2)
	{
		this._nRemainingTurn = Number(loc2);
		return this.__get__remainingTurn();
	}
	function __get__remainingTurn()
	{
		return this._nRemainingTurn;
	}
	function __get__spriteOnID()
	{
		return this._sSpriteOnID;
	}
	function __get__spell()
	{
		return this._oSpell;
	}
	function initialize(loc2, loc3)
	{
		this._oSpell = _global.API.datacenter.Player.Spells.findFirstItem("ID",loc2).item;
		this._sSpriteOnID = loc3;
		var loc4 = this._oSpell.delayBetweenLaunch;
		if(loc4 == undefined)
		{
			loc4 = 0;
		}
		if(loc4 >= 63)
		{
			this._nRemainingTurn = Number.MAX_VALUE;
		}
		else
		{
			this._nRemainingTurn = loc4;
		}
	}
}
