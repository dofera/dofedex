class dofus.datacenter.LaunchedSpell
{
	function LaunchedSpell(var3, var4)
	{
		this.initialize(var2,var3);
	}
	function __set__remainingTurn(var2)
	{
		this._nRemainingTurn = Number(var2);
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
	function initialize(var2, var3)
	{
		this._oSpell = _global.API.datacenter.Player.Spells.findFirstItem("ID",var2).item;
		this._sSpriteOnID = var3;
		var var4 = this._oSpell.delayBetweenLaunch;
		if(var4 == undefined)
		{
			var4 = 0;
		}
		if(var4 >= 63)
		{
			this._nRemainingTurn = Number.MAX_VALUE;
		}
		else
		{
			this._nRemainingTurn = var4;
		}
	}
}
