class ank.battlefield.PointsHandler
{
   function PointsHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      this._mcBattlefield = b;
      this._mcContainer = c;
      this._oDatacenter = d;
      this._oList = new Object();
   }
   function clear()
   {
      for(var k in this._mcContainer)
      {
         this._mcContainer[k].removeMovieClip();
      }
   }
   function addPoints(sID, nX, nY, sValue, nColor)
   {
      var _loc7_ = this._mcContainer.getNextHighestDepth();
      var _loc8_ = this._mcContainer.attachClassMovie(ank.battlefield.mc.Points,"points" + _loc7_,_loc7_,[this,sID,nY,sValue,nColor]);
      _loc8_._x = nX;
      _loc8_._y = nY;
      if(this._oList[sID] == undefined)
      {
         this._oList[sID] = new Array();
      }
      this._oList[sID].push(_loc8_);
      if(this._oList[sID].length == 1)
      {
         _loc8_.animate();
      }
   }
   function onAnimateFinished(sID)
   {
      var _loc3_ = this._oList[sID];
      _loc3_.shift();
      if(_loc3_.length != 0)
      {
         _loc3_[0].animate();
      }
   }
}
