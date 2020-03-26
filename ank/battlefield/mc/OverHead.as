class ank.battlefield.mc.OverHead extends MovieClip
{
   static var TOP_Y = -50;
   static var BOTTOM_Y = 10;
   static var MODERATOR_Y = 15;
   function OverHead(mcSprite, nZoom, mcBattlefield)
   {
      super();
      this._mcBattlefield = mcBattlefield;
      this._mcSprite = mcSprite;
      this._nZoom = nZoom != undefined?nZoom:100;
      this.initialize();
   }
   function __get__top()
   {
      return ank.battlefield.mc.OverHead.TOP_Y * this._nZoom / 100;
   }
   function __get__bottom()
   {
      return ank.battlefield.mc.OverHead.BOTTOM_Y * this._nZoom / 100;
   }
   function __get__moderator()
   {
      return ank.battlefield.mc.OverHead.MODERATOR_Y * this._nZoom / 100;
   }
   function initialize()
   {
      this._nCurrentItemID = 0;
      this.clear();
   }
   function clear()
   {
      this._oLayers = new Object();
      this.clearView();
   }
   function clearView()
   {
      this.createEmptyMovieClip("_mcItems",10);
   }
   function setPosition(nItemsHeight, nMaxWidth)
   {
      var _loc4_ = {x:this._parent._parent._x,y:this._parent._parent._y};
      this._parent._parent.localToGlobal(_loc4_);
      this._x = this._mcSprite._x;
      this._y = this._mcSprite._y;
      var _loc5_ = 100 / this._nZoom;
      var _loc6_ = this.top;
      var _loc7_ = this.moderator;
      nItemsHeight = nItemsHeight * _loc5_;
      if(this._mcSprite._y < - _loc6_ + nItemsHeight - _loc4_.y + _loc7_)
      {
         this._mcItems._y = this._mcItems._y + (this.bottom + nItemsHeight);
         var _loc8_ = 0;
         for(var k in this._oLayers)
         {
            var _loc9_ = this._mcItems["item" + _loc8_];
            _loc9_.reverseClip();
            _loc8_ = _loc8_ + 1;
         }
      }
      else
      {
         var _loc10_ = Math.abs(_loc6_);
         if(this._mcSprite._height > _loc10_ + _loc7_)
         {
            this._mcItems._y = this._mcItems._y + (_loc6_ - _loc7_);
         }
         else if(this._mcSprite._height < _loc10_ - _loc7_)
         {
            this._mcItems._y = this._mcItems._y + (_loc6_ + _loc7_);
         }
         else
         {
            this._mcItems._y = this._mcItems._y + _loc6_;
         }
      }
      var _loc11_ = nMaxWidth * _loc5_ / 2;
      if(this._mcSprite._x < _loc11_ - _loc4_.x)
      {
         this._x = _loc11_;
      }
      if(this._mcSprite._x > this._mcBattlefield.screenWidth * _loc5_ - _loc11_ + _loc4_.x)
      {
         this._x = this._mcBattlefield.screenWidth * _loc5_ - _loc11_;
      }
   }
   function addItem(sLayerName, className, args, delay)
   {
      var _loc6_ = new Object();
      _loc6_.id = this._nCurrentItemID;
      _loc6_.className = className;
      _loc6_.args = args;
      if(delay != undefined)
      {
         ank.utils.Timer.setTimer(_loc6_,"battlefield",this,this.removeItem,delay,[this._nCurrentItemID]);
      }
      this._oLayers[sLayerName] = _loc6_;
      this._nCurrentItemID = this._nCurrentItemID + 1;
      this.refresh();
   }
   function remove(Void)
   {
      this.swapDepths(1);
      this.removeMovieClip();
   }
   function refresh()
   {
      this.clearView();
      var _loc2_ = 0;
      var _loc3_ = 0;
      var _loc4_ = 0;
      for(var k in this._oLayers)
      {
         var _loc5_ = this._oLayers[k];
         var _loc6_ = this._mcItems.attachClassMovie(_loc5_.className,"item" + _loc2_,_loc2_,_loc5_.args);
         _loc3_ = _loc3_ - _loc6_.height;
         _loc4_ = Math.max(_loc4_,_loc6_.width);
         _loc6_._y = _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      this.setPosition(Math.abs(_loc3_),_loc4_);
   }
   function removeLayer(layerName)
   {
      delete this._oLayers.layerName;
      this.refresh();
   }
   function removeItem(nItemID)
   {
      for(var _loc3_ in this._oLayers)
      {
         if(this._oLayers[_loc3_].id == nItemID)
         {
            delete this._oLayers.register3;
            this.refresh();
            break;
         }
      }
   }
}
