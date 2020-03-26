class dofus.datacenter.ConquestVillageData extends Object
{
   function ConquestVillageData(id, alignment, door, prism)
   {
      super();
      this._nSubAreaId = id;
      this._nAlignment = alignment;
      this._bDoor = door;
      this._bPrism = prism;
      this.areaName = String(_global.API.lang.getMapAreaText(Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a)).n);
   }
   function __get__id()
   {
      return this._nSubAreaId;
   }
   function __get__areaId()
   {
      return Number(_global.API.lang.getMapSubAreaText(this._nSubAreaId).a);
   }
   function __get__alignment()
   {
      return this._nAlignment;
   }
   function __get__door()
   {
      return this._bDoor;
   }
   function __get__prism()
   {
      return this._bPrism;
   }
}
