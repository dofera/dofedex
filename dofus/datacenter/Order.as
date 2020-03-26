class dofus.datacenter.Order extends Object
{
   function Order(nIndex)
   {
      super();
      this.api = _global.API;
      this.initialize(nIndex);
   }
   function __get__index()
   {
      return this._nIndex;
   }
   function __set__index(nIndex)
   {
      this._nIndex = !(_global.isNaN(nIndex) || nIndex == undefined)?nIndex:0;
      return this.__get__index();
   }
   function __get__name()
   {
      return this._oOrderInfos.n;
   }
   function __get__alignment()
   {
      return new dofus.datacenter.Alignment(this._oOrderInfos.a);
   }
   function __get__iconFile()
   {
      return dofus.Constants.ORDERS_PATH + this._nIndex + ".swf";
   }
   function initialize(nIndex)
   {
      this._nIndex = nIndex;
      this._oOrderInfos = this.api.lang.getAlignmentOrder(nIndex);
   }
}
