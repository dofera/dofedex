class ank.battlefield.ZoneHandler
{
   function ZoneHandler(b, c)
   {
      this.initialize(b,c);
   }
   function initialize(b, c)
   {
      this._mcBattlefield = b;
      this._mcContainer = c;
      this.clear();
   }
   function clear(Void)
   {
      this._mcZones.removeMovieClip();
      this._mcZones = this._mcContainer.createEmptyMovieClip("zones",10);
      this._nNextLayerDepth = 0;
   }
   function clearZone(nCellNum, radius, layer)
   {
      nCellNum = Number(nCellNum);
      radius = Number(radius);
      if(nCellNum < 0)
      {
         return undefined;
      }
      if(nCellNum > this._mcBattlefield.mapHandler.getCellCount())
      {
         return undefined;
      }
      var _loc5_ = nCellNum * 1000 + radius * 100;
      this._mcZones[layer]["zone" + _loc5_].clear();
   }
   function clearZoneLayer(layer)
   {
      this._mcZones[layer].removeMovieClip();
   }
   function drawZone(nCellNum, radiusIn, radiusOut, layer, col, shape)
   {
      nCellNum = Number(nCellNum);
      radiusIn = Number(radiusIn);
      radiusOut = Number(radiusOut);
      col = Number(col);
      if(nCellNum < 0)
      {
         return undefined;
      }
      if(nCellNum > this._mcBattlefield.mapHandler.getCellCount())
      {
         return undefined;
      }
      if(_global.isNaN(radiusIn) || _global.isNaN(radiusOut))
      {
         return undefined;
      }
      var _loc8_ = nCellNum * 1000 + radiusOut * 100;
      if(this._mcZones[layer] == undefined)
      {
         this._nNextLayerDepth = this._nNextLayerDepth + 1;
         this._mcZones.createEmptyMovieClip(layer,this._nNextLayerDepth);
      }
      this._mcZones[layer].__proto__ = MovieClip.prototype;
      this._mcZones[layer].cacheAsBitmap = this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Zone"];
      var _loc9_ = this._mcZones[layer].attachClassMovie(ank.battlefield.mc.Zone,"zone" + _loc8_,_loc8_,[this._mcBattlefield.mapHandler]);
      switch(shape)
      {
         case "C":
            if(radiusIn == 0)
            {
               _loc9_.drawCircle(radiusOut,col,nCellNum);
            }
            else
            {
               if(radiusIn > 0)
               {
                  radiusIn = radiusIn - 1;
               }
               _loc9_.drawRing(radiusIn,radiusOut,col,nCellNum);
            }
            break;
         case "X":
            if(radiusIn == 0)
            {
               _loc9_.drawCross(radiusOut,col,nCellNum);
            }
            else
            {
               var _loc10_ = this._mcBattlefield.mapHandler;
               var _loc12_ = _loc10_.getWidth();
               var _loc13_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,nCellNum);
               var _loc11_ = nCellNum - _loc12_ * radiusIn;
               if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).y == _loc13_.y)
               {
                  _loc9_.drawLine(radiusOut - radiusIn,col,_loc11_,nCellNum,true);
               }
               _loc11_ = nCellNum - (_loc12_ - 1) * radiusIn;
               if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).x == _loc13_.x)
               {
                  _loc9_.drawLine(radiusOut - radiusIn,col,_loc11_,nCellNum,true);
               }
               _loc11_ = nCellNum + _loc12_ * radiusIn;
               if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).y == _loc13_.y)
               {
                  _loc9_.drawLine(radiusOut - radiusIn,col,_loc11_,nCellNum,true);
               }
               _loc11_ = nCellNum + (_loc12_ - 1) * radiusIn;
               if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).x == _loc13_.x)
               {
                  _loc9_.drawLine(radiusOut - radiusIn,col,_loc11_,nCellNum,true);
               }
            }
            break;
         default:
            _loc9_.drawCircle(radiusOut,col,nCellNum);
      }
      this.moveZoneTo(_loc9_,nCellNum);
   }
   function moveZoneTo(zone, nCellNum)
   {
      var _loc4_ = this._mcBattlefield.mapHandler.getCellData(nCellNum);
      zone._x = _loc4_.x;
      zone._y = _loc4_.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc4_.groundLevel - 7);
   }
}
