class dofus.datacenter.Subarea extends Object
{
   function Subarea(nID, nAlignment)
   {
      super();
      this.api = _global.API;
      this.initialize(nID,nAlignment);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__alignment()
   {
      return this._oAlignment;
   }
   function __set__alignment(oAlignment)
   {
      this._oAlignment = oAlignment;
      return this.__get__alignment();
   }
   function __get__name()
   {
      return String(this.api.lang.getMapSubAreaText(this._nID).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(this._nID).n:String(this.api.lang.getMapSubAreaText(this._nID).n).substr(2);
   }
   function __get__color()
   {
      return dofus.Constants.AREA_ALIGNMENT_COLOR[this._oAlignment.index];
   }
   function initialize(nID, nAlignment)
   {
      this._nID = nID;
      this._oAlignment = new dofus.datacenter.Alignment(nAlignment);
   }
}
