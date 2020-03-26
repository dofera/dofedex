class ank.battlefield.GridHandler
{
   function GridHandler(c, d)
   {
      this.initialize(c,d);
   }
   function initialize(c, d)
   {
      this._mcContainer = c;
      this._oDatacenter = d;
   }
   function draw(bAll)
   {
      this._mcGrid = this._mcContainer.createEmptyMovieClip("mcGrid",10);
      var _loc3_ = this._oDatacenter.Map.data;
      var _loc4_ = ank.battlefield.Constants.CELL_COORD;
      var _loc6_ = new Object();
      this._mcGrid.lineStyle(1,ank.battlefield.Constants.GRID_COLOR,ank.battlefield.Constants.GRID_ALPHA);
      for(var k in _loc3_)
      {
         var _loc5_ = _loc3_[k];
         if(!(!_loc5_.active && !bAll))
         {
            if(_loc5_.movement != 0 && _loc5_.lineOfSight || bAll)
            {
               this._mcGrid.moveTo(_loc4_[_loc5_.groundSlope][0][0] + _loc5_.x,_loc4_[_loc5_.groundSlope][0][1] + _loc5_.y);
               this._mcGrid.lineTo(_loc4_[_loc5_.groundSlope][1][0] + _loc5_.x,_loc4_[_loc5_.groundSlope][1][1] + _loc5_.y);
               this._mcGrid.lineTo(_loc4_[_loc5_.groundSlope][2][0] + _loc5_.x,_loc4_[_loc5_.groundSlope][2][1] + _loc5_.y);
            }
            else
            {
               _loc6_[k] = _loc5_;
            }
         }
      }
      var _loc7_ = this._oDatacenter.Map.width;
      var _loc8_ = [- _loc7_,- _loc7_ - 1];
      for(var k in _loc6_)
      {
         _loc5_ = _loc6_[k];
         var _loc9_ = 0;
         for(; _loc9_ < 2; _loc9_ = _loc9_ + 1)
         {
            var _loc10_ = Number(k) + _loc8_[_loc9_];
            if(_loc6_[_loc10_] == undefined)
            {
               if(!_loc3_[_loc10_].active && !bAll)
               {
                  continue;
               }
               var _loc11_ = (_loc9_ + 1) % 4;
               this._mcGrid.moveTo(_loc4_[_loc5_.groundSlope][_loc9_][0] + _loc5_.x,_loc4_[_loc5_.groundSlope][_loc9_][1] + _loc5_.y);
               this._mcGrid.lineTo(_loc4_[_loc5_.groundSlope][_loc11_][0] + _loc5_.x,_loc4_[_loc5_.groundSlope][_loc11_][1] + _loc5_.y);
            }
         }
      }
      this.bGridVisible = true;
   }
   function clear(Void)
   {
      this._mcGrid.removeMovieClip();
      this.bGridVisible = false;
   }
}
