class dofus.datacenter.Crafter extends Object
{
   function Crafter(sId, sName)
   {
      super();
      this.api = _global.API;
      this.id = sId;
      this._sName = sName;
   }
   function __get__name()
   {
      return this._sName;
   }
   function __set__name(sName)
   {
      this._sName = sName;
      return this.__get__name();
   }
   function __get__job()
   {
      return this._oJob;
   }
   function __set__job(value)
   {
      this._oJob = value;
      return this.__get__job();
   }
   function __get__breedId()
   {
      return this._nBreedId;
   }
   function __set__breedId(nBreedId)
   {
      this._nBreedId = nBreedId;
      return this.__get__breedId();
   }
   function __get__gfxFile()
   {
      var _loc2_ = this._nBreedId * 10 + this._nSex;
      return dofus.Constants.CLIPS_PERSOS_PATH + _loc2_ + ".swf";
   }
   function __get__gfxBreedFile()
   {
      return dofus.Constants.GUILDS_MINI_PATH + (this._nBreedId * 10 + this._nSex) + ".swf";
   }
   function __get__sex()
   {
      return this._nSex;
   }
   function __set__sex(value)
   {
      this._nSex = Number(value);
      return this.__get__sex();
   }
   function __get__color1()
   {
      return this._nColor1;
   }
   function __set__color1(value)
   {
      this._nColor1 = Number(value);
      return this.__get__color1();
   }
   function __get__color2()
   {
      return this._nColor2;
   }
   function __set__color2(value)
   {
      this._nColor2 = Number(value);
      return this.__get__color2();
   }
   function __get__color3()
   {
      return this._nColor3;
   }
   function __set__color3(value)
   {
      this._nColor3 = Number(value);
      return this.__get__color3();
   }
   function __get__accessories()
   {
      return this._aAccessories;
   }
   function __set__accessories(value)
   {
      this._aAccessories = value;
      return this.__get__accessories();
   }
   function __set__mapId(nMapId)
   {
      this._nMapId = nMapId;
      return this.__get__mapId();
   }
   function __get__subarea()
   {
      if(this._nMapId == 0)
      {
         return undefined;
      }
      var _loc2_ = this.api.lang.getMapText(this._nMapId);
      var _loc3_ = this.api.lang.getMapSubAreaText(_loc2_.sa);
      var _loc4_ = this.api.lang.getMapAreaText(_loc3_.a);
      return !(_loc3_.n.charAt(0) == "/" && _loc3_.n.charAt(1) == "/")?_loc4_.n + " (" + _loc3_.n + ")":_loc4_.n;
   }
   function __get__coord()
   {
      if(this._nMapId == 0)
      {
         return undefined;
      }
      var _loc2_ = this.api.lang.getMapText(this._nMapId);
      return {x:_loc2_.x,y:_loc2_.y};
   }
}
