class dofus.datacenter.Hint extends Object
{
   function Hint(data)
   {
      super();
      this.api = _global.API;
      this._oData = data;
   }
   function __get__mapID()
   {
      return this._oData.m;
   }
   function __get__name()
   {
      return this._oData.n;
   }
   function __get__category()
   {
      return this.api.lang.getHintsCategory(this.categoryID).n;
   }
   function __get__categoryID()
   {
      return this._oData.c;
   }
   function __get__coordinates()
   {
      return this.x + ", " + this.y;
   }
   function __get__x()
   {
      if(this._oData.m == undefined)
      {
         return this._oData.x;
      }
      return this.api.lang.getMapText(this._oData.m).x;
   }
   function __get__y()
   {
      if(this._oData.m == undefined)
      {
         return this._oData.y;
      }
      return this.api.lang.getMapText(this._oData.m).y;
   }
   function __get__superAreaID()
   {
      var _loc2_ = this.api.lang.getMapText(this._oData.m).sa;
      var _loc3_ = this.api.lang.getMapSubAreaText(_loc2_).a;
      var _loc4_ = this.api.lang.getMapAreaText(_loc3_).sua;
      return _loc4_;
   }
   function __get__gfx()
   {
      return this._oData.g;
   }
}
