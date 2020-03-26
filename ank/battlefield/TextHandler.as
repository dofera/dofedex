class ank.battlefield.TextHandler
{
   static var BUBBLE_TYPE_CHAT = 1;
   static var BUBBLE_TYPE_THINK = 2;
   function TextHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      this._mcBattlefield = b;
      this._mcContainer = c;
      this._oDatacenter = d;
   }
   function clear()
   {
      for(var k in this._mcContainer)
      {
         this._mcContainer[k].removeMovieClip();
      }
   }
   function addBubble(sID, nX, nY, sText, type)
   {
      var _loc7_ = (this._oDatacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
      this.removeBubble(sID);
      var _loc8_ = this._mcContainer.attachClassMovie(type != ank.battlefield.TextHandler.BUBBLE_TYPE_THINK?ank.battlefield.mc.Bubble:ank.battlefield.mc.BubbleThink,"bubble" + sID,this._mcContainer.getNextHighestDepth(),[sText,nX,nY,_loc7_]);
      var _loc9_ = this._mcBattlefield.getZoom();
      if(_loc9_ < 100)
      {
         _loc8_._xscale = _loc8_._yscale = 10000 / _loc9_;
      }
   }
   function removeBubble(sID)
   {
      var _loc3_ = this._mcContainer["bubble" + sID];
      _loc3_.remove();
   }
}
