class dofus.datacenter.DofusMap extends ank.battlefield.datacenter.Map
{
   function DofusMap(nID)
   {
      super(nID);
   }
   function __get__coordinates()
   {
      var _loc2_ = _global.API.lang.getMapText(this.id);
      return _global.API.lang.getText("COORDINATES") + " : " + _loc2_.x + ", " + _loc2_.y;
   }
   function __get__x()
   {
      return _global.API.lang.getMapText(this.id).x;
   }
   function __get__y()
   {
      return _global.API.lang.getMapText(this.id).y;
   }
   function __get__superarea()
   {
      var _loc2_ = _global.API.lang;
      return _loc2_.getMapAreaInfos(this.subarea).superareaID;
   }
   function __get__area()
   {
      var _loc2_ = _global.API.lang;
      return _loc2_.getMapAreaInfos(this.subarea).areaID;
   }
   function __get__subarea()
   {
      var _loc2_ = _global.API.lang;
      return _loc2_.getMapText(this.id).sa;
   }
   function __get__musics()
   {
      var _loc2_ = _global.API.lang;
      return _loc2_.getMapSubAreaText(this.subarea).m;
   }
}
