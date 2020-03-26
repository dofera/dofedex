class ank.battlefield.PointerHandler
{
   function PointerHandler(b, c)
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
      this.hide();
      this._aShapes = new Array();
   }
   function hide(Void)
   {
      this._mcZones.removeMovieClip();
      this._mcZones = this._mcContainer.createEmptyMovieClip("zones",2);
      this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Pointers"];
   }
   function addShape(sShape, mSize, nColor, nCellNumRef)
   {
      this._aShapes.push({shape:sShape,size:mSize,col:nColor,cellNumRef:nCellNumRef});
   }
   function draw(nCellNum)
   {
      var _loc3_ = this._aShapes;
      if(_loc3_.length == 0)
      {
         return undefined;
      }
      this.hide();
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         this._mcZones.__proto__ = MovieClip.prototype;
         var _loc5_ = this._mcZones.attachClassMovie(ank.battlefield.mc.Zone,"zone" + _loc4_,10 * _loc4_,[this._mcBattlefield.mapHandler]);
         switch(_loc3_[_loc4_].shape)
         {
            case "P":
               _loc5_.drawCircle(0,_loc3_[_loc4_].col,nCellNum);
               break;
            case "C":
               if(typeof _loc3_[_loc4_].size == "number")
               {
                  _loc5_.drawCircle(_loc3_[_loc4_].size,_loc3_[_loc4_].col,nCellNum);
               }
               else if(_loc3_[_loc4_].size[0] == 0 && !_global.isNaN(Number(_loc3_[_loc4_].size[1])))
               {
                  _loc5_.drawCircle(Number(_loc3_[_loc4_].size[1]),_loc3_[_loc4_].col,nCellNum);
               }
               else
               {
                  var _loc6_ = 0;
                  if(_loc3_[_loc4_].size[0] > 0)
                  {
                     _loc6_ = -1;
                  }
                  _loc5_.drawRing(_loc3_[_loc4_].size[0] + _loc6_,_loc3_[_loc4_].size[1],_loc3_[_loc4_].col,nCellNum);
               }
               break;
            case "D":
               var _loc7_ = -1;
               var _loc8_ = -1;
               if(typeof _loc3_[_loc4_].size == "number")
               {
                  _loc8_ = Number(_loc3_[_loc4_].size);
                  _loc7_ = _loc8_ % 2 != 0?0:1;
               }
               else
               {
                  _loc7_ = Number(_loc3_[_loc4_].size[1]);
                  _loc8_ = Number(_loc3_[_loc4_].size[0]);
               }
               var _loc9_ = _loc7_;
               while(_loc9_ < _loc8_)
               {
                  _loc5_.drawRing(_loc9_ + 1,_loc9_,_loc3_[_loc4_].col,nCellNum);
                  _loc9_ = _loc9_ + 2;
               }
               break;
            case "L":
               _loc5_.drawLine(_loc3_[_loc4_].size,_loc3_[_loc4_].col,nCellNum,_loc3_[_loc4_].cellNumRef);
               break;
            case "X":
               if(typeof _loc3_[_loc4_].size == "number")
               {
                  _loc5_.drawCross(_loc3_[_loc4_].size,_loc3_[_loc4_].col,nCellNum);
               }
               else
               {
                  var _loc10_ = this._mcBattlefield.mapHandler;
                  var _loc12_ = _loc10_.getWidth();
                  var _loc13_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,nCellNum);
                  var _loc11_ = nCellNum - _loc12_ * _loc3_[_loc4_].size[0];
                  if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).y == _loc13_.y)
                  {
                     _loc5_.drawLine(_loc3_[_loc4_].size[1] - _loc3_[_loc4_].size[0],_loc3_[_loc4_].col,_loc11_,nCellNum,true);
                  }
                  _loc11_ = nCellNum - (_loc12_ - 1) * _loc3_[_loc4_].size[0];
                  if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).x == _loc13_.x)
                  {
                     _loc5_.drawLine(_loc3_[_loc4_].size[1] - _loc3_[_loc4_].size[0],_loc3_[_loc4_].col,_loc11_,nCellNum,true);
                  }
                  _loc11_ = nCellNum + _loc12_ * _loc3_[_loc4_].size[0];
                  if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).y == _loc13_.y)
                  {
                     _loc5_.drawLine(_loc3_[_loc4_].size[1] - _loc3_[_loc4_].size[0],_loc3_[_loc4_].col,_loc11_,nCellNum,true);
                  }
                  _loc11_ = nCellNum + (_loc12_ - 1) * _loc3_[_loc4_].size[0];
                  if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(_loc10_,_loc11_).x == _loc13_.x)
                  {
                     _loc5_.drawLine(_loc3_[_loc4_].size[1] - _loc3_[_loc4_].size[0],_loc3_[_loc4_].col,_loc11_,nCellNum,true);
                  }
               }
               break;
            case "T":
               _loc5_.drawLine(_loc3_[_loc4_].size,_loc3_[_loc4_].col,nCellNum,_loc3_[_loc4_].cellNumRef,false,true);
               break;
            case "R":
               _loc5_.drawRectangle(_loc3_[_loc4_].size[0],_loc3_[_loc4_].size[1],_loc3_[_loc4_].col,nCellNum);
               break;
            case "O":
               _loc5_.drawRing(_loc3_[_loc4_].size,_loc3_[_loc4_].size - 1,_loc3_[_loc4_].col,nCellNum);
         }
         this.movePointerTo(_loc5_,nCellNum);
         _loc4_ = _loc4_ + 1;
      }
   }
   function movePointerTo(mcZone, nCellNum)
   {
      var _loc4_ = this._mcBattlefield.mapHandler.getCellData(nCellNum);
      mcZone._x = _loc4_.x;
      mcZone._y = _loc4_.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc4_.groundLevel - 7);
   }
}
