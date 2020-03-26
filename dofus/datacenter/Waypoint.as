class dofus.datacenter.Waypoint extends Object
{
   function Waypoint(nID, bCurrent, bRespawn, nCost)
   {
      super();
      this.api = _global.API;
      this._nID = nID;
      this._bCurrent = bCurrent;
      this._bRespawn = bRespawn;
      this._nCost = nCost;
      this.fieldToSort = this.name + nID;
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__name()
   {
      return this.api.kernel.MapsServersManager.getMapName(this._nID);
   }
   function __get__coordinates()
   {
      return this.api.lang.getMapText(this._nID).x + ", " + this.api.lang.getMapText(this._nID).y;
   }
   function __get__isRespawn()
   {
      return this._bRespawn;
   }
   function __get__isCurrent()
   {
      return this._bCurrent;
   }
   function __get__cost()
   {
      return this._nCost;
   }
}
