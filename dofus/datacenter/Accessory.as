class dofus.datacenter.Accessory extends Object
{
   function Accessory(nUnicID, nType, nFrame)
   {
      super();
      this.api = _global.API;
      this.initialize(nUnicID,nType,nFrame);
   }
   function __get__unicID()
   {
      return this._nUnicID;
   }
   function __get__type()
   {
      if(this._nType != undefined)
      {
         return this._nType;
      }
      return this._oItemText.t;
   }
   function __get__gfxID()
   {
      return this._oItemText.g;
   }
   function __get__gfx()
   {
      return this.type + "_" + this.gfxID;
   }
   function __get__frame()
   {
      return this._nFrame;
   }
   function initialize(nUnicID, nType, nFrame)
   {
      this._nUnicID = nUnicID;
      if(nFrame != undefined)
      {
         this._nFrame = nFrame;
      }
      if(nType != undefined)
      {
         this._nType = nType;
      }
      this._oItemText = this.api.lang.getItemUnicText(nUnicID);
   }
}
