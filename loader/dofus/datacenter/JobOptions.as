class dofus.datacenter.JobOptions extends Object
{
	function JobOptions(§\x01\x17§, §\x02\x12§, nMaxSlot)
	{
		super();
		this._nParams = var3;
		this._nMinSlot = var4 <= 1?2:var4;
		this._nMaxSlot = nMaxSlot;
	}
	function __get__isNotFree()
	{
		return (this._nParams & 1) == 1;
	}
	function __get__isFreeIfFailed()
	{
		return (this._nParams & 2) == 2;
	}
	function __get__ressourcesNeeded()
	{
		return (this._nParams & 4) == 4;
	}
	function __get__minSlots()
	{
		return this._nMinSlot;
	}
	function __get__maxSlots()
	{
		return this._nMaxSlot;
	}
}
