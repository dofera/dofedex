class dofus.datacenter.NonPlayableCharacter extends ank.battlefield.datacenter.Sprite
{
   function NonPlayableCharacter(sID, clipClass, sGfxFile, cellNum, dir, gfxID, customArtwork)
   {
      super();
      this.api = _global.API;
      if(this.__proto__ == dofus.datacenter.NonPlayableCharacter.prototype)
      {
         this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID,customArtwork);
      }
   }
   function __set__unicID(value)
   {
      this._oNpcText = this.api.lang.getNonPlayableCharactersText(value);
      return this.__get__unicID();
   }
   function __get__name()
   {
      return this.api.lang.fetchString(this._oNpcText.n);
   }
   function __get__actions()
   {
      var _loc2_ = new Array();
      var _loc3_ = this._oNpcText.a;
      var _loc4_ = _loc3_.length;
      while(true)
      {
         _loc4_;
         if(_loc4_-- > 0)
         {
            _loc2_.push({name:this.api.lang.getNonPlayableCharactersActionText(_loc3_[_loc4_]),action:this.getActionFunction(_loc3_[_loc4_])});
            continue;
         }
         break;
      }
      return _loc2_;
   }
   function __get__gfxID()
   {
      return this._gfxID;
   }
   function __set__gfxID(value)
   {
      this._gfxID = value;
      return this.__get__gfxID();
   }
   function __get__extraClipID()
   {
      return this._nExtraClipID;
   }
   function __set__extraClipID(nExtraClipID)
   {
      this._nExtraClipID = nExtraClipID;
      return this.__get__extraClipID();
   }
   function __get__customArtwork()
   {
      return this._nCustomArtwork;
   }
   function __set__customArtwork(nCustomArtwork)
   {
      this._nCustomArtwork = nCustomArtwork;
      return this.__get__customArtwork();
   }
   function initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID, customArtwork)
   {
      super.initialize(sID,clipClass,sGfxFile,cellNum,dir);
      this._gfxID = gfxID;
      this._nCustomArtwork = customArtwork;
   }
   function getActionFunction(nActionID)
   {
      switch(nActionID)
      {
         case 1:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[0,this.id]};
         case 2:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[2,this.id]};
         case 3:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startDialog,params:[this.id]};
         case 4:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[9,this.id]};
         case 5:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[10,this.id]};
         case 6:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[11,this.id]};
         case 7:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[17,this.id]};
         case 8:
            return {object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.startExchange,params:[18,this.id]};
         default:
            return new Object();
      }
   }
}
