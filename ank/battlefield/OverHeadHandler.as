class ank.battlefield.OverHeadHandler
{
   function OverHeadHandler(b, c)
   {
      this.initialize(b,c);
   }
   function initialize(b, c)
   {
      this._mcBattlefield = b;
      this._mcContainer = c;
   }
   function clear()
   {
      for(var k in this._mcContainer)
      {
         if(typeof this._mcContainer[k] == "movieclip")
         {
            this._mcContainer[k].swapDepths(0);
            this._mcContainer[k].removeMovieClip();
         }
      }
   }
   function addOverHeadItem(sID, nX, nY, mcSprite, sLayerName, fClassName, aParams, nDelay)
   {
      var _loc10_ = this._mcContainer["oh" + sID];
      var _loc11_ = this._mcBattlefield.getZoom();
      if(_loc10_ == undefined)
      {
         _loc10_ = this._mcContainer.attachClassMovie(ank.battlefield.mc.OverHead,"oh" + sID,mcSprite.getDepth(),[mcSprite,_loc11_,this._mcBattlefield]);
      }
      _loc10_._x = nX;
      _loc10_._y = nY;
      if(_loc11_ < 100)
      {
         _loc10_._xscale = _loc10_._yscale = 10000 / _loc11_;
      }
      _loc10_.addItem(sLayerName,fClassName,aParams,nDelay);
   }
   function removeOverHeadLayer(sID, sLayerName)
   {
      var _loc4_ = this._mcContainer["oh" + sID];
      _loc4_.removeLayer(sLayerName);
   }
   function removeOverHead(sID)
   {
      var _loc3_ = this._mcContainer["oh" + sID];
      _loc3_.remove();
   }
}
