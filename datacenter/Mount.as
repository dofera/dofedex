class dofus.datacenter.Mount extends Object
{
   var useCustomColor = false;
   function Mount(nModelID, nChevauchorGfxID, bNewBorn)
   {
      super();
      mx.events.EventDispatcher.initialize(this);
      this.newBorn = bNewBorn;
      this.modelID = nModelID;
      this._lang = _global.API.lang.getMountText(this.modelID);
      this.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + this._lang.g + ".swf";
      this.chevauchorGfxID = nChevauchorGfxID;
   }
   function __set__name(value)
   {
      this._sName = value;
      this.dispatchEvent({type:"nameChanged",name:value});
      return this.__get__name();
   }
   function __get__name()
   {
      return this._sName;
   }
   function __set__pods(value)
   {
      this._nPods = value;
      this.dispatchEvent({type:"podsChanged",pods:value});
      return this.__get__pods();
   }
   function __get__pods()
   {
      return this._nPods;
   }
   function __get__label()
   {
      return this._lang.n;
   }
   function __get__modelName()
   {
      return this._lang.n;
   }
   function __get__gfxID()
   {
      return this._lang.g;
   }
   function __set__chevauchorGfxID(nID)
   {
      this._nChevauchorGfxID = nID;
      this.chevauchorGfxFile = dofus.Constants.CHEVAUCHOR_PATH + nID + ".swf";
      return this.__get__chevauchorGfxID();
   }
   function __get__chevauchorGfxID()
   {
      return this._nChevauchorGfxID;
   }
   function __get__color1()
   {
      if(!_global.isNaN(this.customColor1))
      {
         return this.customColor1;
      }
      return this._lang.c1;
   }
   function __get__color2()
   {
      if(!_global.isNaN(this.customColor2))
      {
         return this.customColor2;
      }
      return this._lang.c2;
   }
   function __get__color3()
   {
      if(!_global.isNaN(this.customColor3))
      {
         return this.customColor3;
      }
      return this._lang.c3;
   }
   function __get__mature()
   {
      return this.maturity == this.maturityMax && (this.maturity != undefined && this.maturityMax != undefined);
   }
   function __get__effects()
   {
      return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects);
   }
   function setEffects(compressedData)
   {
      this._sEffects = compressedData;
      this._aEffects = new Array();
      var _loc3_ = compressedData.split(",");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].split("#");
         _loc5_[0] = _global.parseInt(_loc5_[0],16);
         _loc5_[1] = _loc5_[1] != "0"?_global.parseInt(_loc5_[1],16):undefined;
         _loc5_[2] = _loc5_[2] != "0"?_global.parseInt(_loc5_[2],16):undefined;
         _loc5_[3] = _loc5_[3] != "0"?_global.parseInt(_loc5_[3],16):undefined;
         _loc5_[4] = _loc5_[4];
         this._aEffects.push(_loc5_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function getToolTip()
   {
      var _loc2_ = this.modelName;
      _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("NAME_BIG") + " : " + this.name);
      _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("LEVEL") + " : " + this.level);
      _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("CREATE_SEX") + " : " + (!this.sex?_global.API.lang.getText("ANIMAL_MEN"):_global.API.lang.getText("ANIMAL_WOMEN")));
      _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("MOUNTABLE") + " : " + (!this.mountable?_global.API.lang.getText("NO"):_global.API.lang.getText("YES")));
      _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("WILD") + " : " + (!this.wild?_global.API.lang.getText("NO"):_global.API.lang.getText("YES")));
      if(this.fecondation > 0)
      {
         _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("PREGNANT_SINCE",[this.fecondation]));
      }
      else if(this.fecondable)
      {
         _loc2_ = _loc2_ + ("\n" + _global.API.lang.getText("FECONDABLE"));
      }
      return _loc2_;
   }
}
