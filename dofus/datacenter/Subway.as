class dofus.datacenter.Subway extends dofus.datacenter.Hint
{
	function Subway(§\x12\x0b§, cost)
	{
		super(var3);
		this._nCost = cost;
		this.fieldToSort = this.name + this.mapID;
	}
	function __get__cost()
	{
		return this._nCost;
	}
}
