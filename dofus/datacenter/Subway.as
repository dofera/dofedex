class dofus.datacenter.Subway extends dofus.datacenter.Hint
{
   function Subway(data, cost)
   {
      super(data);
      this._nCost = cost;
      this.fieldToSort = this.name + this.mapID;
   }
   function __get__cost()
   {
      return this._nCost;
   }
}
