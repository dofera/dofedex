class ank.battlefield.mc.InteractiveObject extends MovieClip
{
   function InteractiveObject()
   {
      super();
   }
   function initialize(b, oCell, bInteractive)
   {
      this._battlefield = b;
      this._oCell = oCell;
      this._bInteractive = bInteractive != undefined?bInteractive:true;
   }
   function select(bool)
   {
      var _loc3_ = new Color(this);
      var _loc4_ = new Object();
      if(bool)
      {
         _loc4_ = {ra:60,rb:80,ga:60,gb:80,ba:60,bb:80};
      }
      else
      {
         _loc4_ = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
      }
      _loc3_.setTransform(_loc4_);
   }
   function loadExternalClip(sFile, bAutoSize)
   {
      bAutoSize = bAutoSize != undefined?bAutoSize:true;
      this.createEmptyMovieClip("_mcExternal",10);
      this._mclLoader = new MovieClipLoader();
      if(bAutoSize)
      {
         this._mclLoader.addListener(this);
      }
      this._mclLoader.loadClip(sFile,this._mcExternal);
   }
   function __get__cellData()
   {
      return this._oCell;
   }
   function _release(Void)
   {
      if(this._bInteractive)
      {
         this._battlefield.onObjectRelease(this);
      }
   }
   function _rollOver(Void)
   {
      if(this._bInteractive)
      {
         this._battlefield.onObjectRollOver(this);
      }
   }
   function _rollOut(Void)
   {
      if(this._bInteractive)
      {
         this._battlefield.onObjectRollOut(this);
      }
   }
   function onLoadInit(mc)
   {
      var _loc3_ = mc._width;
      var _loc4_ = mc._height;
      var _loc5_ = _loc3_ / _loc4_;
      var _loc6_ = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
      if(_loc5_ == _loc6_)
      {
         mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
         mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
      }
      else if(_loc5_ > _loc6_)
      {
         mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
         mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / _loc5_;
      }
      else
      {
         mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE * _loc5_;
         mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
      }
      var _loc7_ = mc.getBounds(mc._parent);
      mc._x = - _loc7_.xMin - mc._width / 2;
      mc._y = - _loc7_.yMin - mc._height;
   }
}
