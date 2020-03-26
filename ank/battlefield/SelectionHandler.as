class ank.battlefield.SelectionHandler
{
   function SelectionHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      this._mcBattlefield = b;
      this._oDatacenter = d;
      this._mcContainer = c;
      this.clear();
   }
   function clear(Void)
   {
      for(var k in this._mcContainer.Select)
      {
         var _loc3_ = this._mcContainer.Select[k];
         if(_loc3_ != undefined)
         {
            var _loc4_ = _loc3_.inObjectClips;
            for(var l in _loc4_)
            {
               _loc4_[l].removeMovieClip();
            }
         }
         _loc3_.removeMovieClip();
      }
   }
   function clearLayer(sLayer)
   {
      if(sLayer == undefined)
      {
         sLayer = "default";
      }
      var _loc3_ = this._mcContainer.Select[sLayer];
      if(_loc3_ != undefined)
      {
         var _loc4_ = _loc3_.inObjectClips;
         for(var k in _loc4_)
         {
            _loc4_[k].removeMovieClip();
         }
      }
      _loc3_.removeMovieClip();
   }
   function select(bSelected, nCellNum, nColor, sLayer, nAlpha)
   {
      var _loc7_ = this._mcBattlefield.mapHandler.getCellData(nCellNum);
      if(sLayer == undefined)
      {
         sLayer = "default";
      }
      var _loc8_ = this._mcContainer.Select[sLayer];
      if(_loc8_ == undefined)
      {
         _loc8_ = this._mcContainer.Select.createEmptyMovieClip(sLayer,this._mcContainer.Select.getNextHighestDepth());
         _loc8_.inObjectClips = new Array();
      }
      if(_loc7_ != undefined && _loc7_.x != undefined)
      {
         var _loc9_ = _loc7_.movement > 1 && _loc7_.layerObject2Num != 0;
         var _loc10_ = "cell" + String(nCellNum);
         if(bSelected)
         {
            if(_loc9_)
            {
               var _loc12_ = this._mcContainer.Object2["select" + nCellNum];
               if(_loc12_ == undefined)
               {
                  _loc12_ = this._mcContainer.Object2.createEmptyMovieClip("select" + nCellNum,nCellNum * 100 + 2);
               }
               var _loc11_ = _loc12_[sLayer];
               if(_loc11_ == undefined)
               {
                  _loc11_ = _loc12_.attachMovie("s" + _loc7_.groundSlope,sLayer,_loc12_.getNextHighestDepth());
               }
               _loc8_.inObjectClips.push(_loc11_);
            }
            else
            {
               _loc11_ = _loc8_.attachMovie("s" + _loc7_.groundSlope,_loc10_,nCellNum * 100);
            }
            _loc11_._x = _loc7_.x;
            _loc11_._y = _loc7_.y;
            var _loc13_ = new Color(_loc11_);
            _loc13_.setRGB(Number(nColor));
            _loc11_._alpha = nAlpha == undefined?100:nAlpha;
         }
         else if(_loc9_)
         {
            this._mcContainer.Object2["select" + nCellNum][sLayer].unloadMovie();
            this._mcContainer.Object2["select" + nCellNum][sLayer].removeMovieClip();
         }
         else
         {
            _loc8_[_loc10_].unloadMovie();
            _loc8_[_loc10_].removeMovieClip();
         }
      }
   }
   function selectMultiple(bSelect, aCellList, nColor, sLayer, nAlpha)
   {
      for(var i in aCellList)
      {
         this.select(bSelect,aCellList[i],nColor,sLayer,nAlpha);
      }
   }
   function getLayers()
   {
      var _loc2_ = new Array();
      for(var k in this._mcContainer.Select)
      {
         var _loc3_ = this._mcContainer.Select[k];
         if(_loc3_ != undefined)
         {
            _loc2_.push(_loc3_._name);
         }
      }
      return _loc2_;
   }
}
