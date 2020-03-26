class ank.battlefield.utils.Pathfinding
{
   function Pathfinding()
   {
   }
   static function pathFind(mapHandler, nCellBegin, nCellEnd, oParams)
   {
      if(nCellBegin == undefined)
      {
         return null;
      }
      if(nCellEnd == undefined)
      {
         return null;
      }
      var _loc6_ = oParams.bAllDirections != undefined?oParams.bAllDirections:true;
      var _loc7_ = oParams.nMaxLength != undefined?oParams.nMaxLength:500;
      var _loc8_ = oParams.bIgnoreSprites != undefined?oParams.bIgnoreSprites:false;
      var _loc9_ = oParams.bCellNumOnly != undefined?oParams.bCellNumOnly:false;
      var _loc10_ = oParams.bWithBeginCellNum != undefined?oParams.bWithBeginCellNum:false;
      var _loc11_ = mapHandler.getWidth();
      if(_loc6_)
      {
         var _loc12_ = 8;
         var _loc13_ = [1,_loc11_,_loc11_ * 2 - 1,_loc11_ - 1,-1,- _loc11_,- _loc11_ * 2 + 1,- _loc11_ - 1];
         var _loc14_ = [1.5,1,1.5,1,1.5,1,1.5,1];
      }
      else
      {
         _loc12_ = 4;
         _loc13_ = [_loc11_,_loc11_ - 1,- _loc11_,- _loc11_ - 1];
         _loc14_ = [1,1,1,1];
      }
      var _loc15_ = mapHandler.getCellsData();
      var _loc16_ = new Object();
      var _loc17_ = new Object();
      var _loc18_ = false;
      var _loc19_ = _loc16_["oCell" + nCellBegin] = new Object();
      _loc16_["oCell" + nCellBegin] = new Object().num = nCellBegin;
      _loc16_["oCell" + nCellBegin] = new Object().g = 0;
      _loc16_["oCell" + nCellBegin] = new Object().v = 0;
      _loc16_["oCell" + nCellBegin] = new Object().h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,nCellBegin,nCellEnd);
      _loc16_["oCell" + nCellBegin] = new Object().f = _loc16_["oCell" + nCellBegin] = new Object().h;
      _loc16_["oCell" + nCellBegin] = new Object().l = _loc15_[nCellBegin].groundLevel;
      _loc16_["oCell" + nCellBegin] = new Object().m = _loc15_[nCellBegin].movement;
      _loc16_["oCell" + nCellBegin] = new Object().parent = null;
      while(!_loc18_)
      {
         var _loc20_ = null;
         var _loc21_ = 500000;
         for(var k in _loc16_)
         {
            if(_loc16_[k].f < _loc21_)
            {
               _loc21_ = _loc16_[k].f;
               _loc20_ = k;
            }
         }
         var _loc22_ = _loc16_[_loc20_];
         delete register16.register20;
         if(_loc22_.num == nCellEnd)
         {
            var _loc23_ = new Array();
            while(_loc22_.num != nCellBegin)
            {
               if(_loc22_.m == 0)
               {
                  _loc23_ = new Array();
               }
               else if(_loc9_)
               {
                  _loc23_.splice(0,0,_loc22_.num);
               }
               else
               {
                  _loc23_.splice(0,0,{num:_loc22_.num,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,_loc22_.parent.num,_loc22_.num)});
               }
               _loc22_ = _loc22_.parent;
            }
            if(_loc10_)
            {
               if(_loc9_)
               {
                  _loc23_.splice(0,0,nCellBegin);
               }
               else
               {
                  _loc23_.splice(0,0,{num:nCellBegin,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,_loc22_.parent.num,nCellBegin)});
               }
            }
            return _loc23_;
         }
         var _loc24_ = false;
         var _loc25_ = 0;
         while(_loc25_ < _loc12_)
         {
            var _loc26_ = _loc22_.num + _loc13_[_loc25_];
            if(Math.abs(_loc15_[_loc26_].x - _loc15_[_loc22_.num].x) <= 53)
            {
               var _loc27_ = _loc15_[_loc26_];
               var _loc28_ = _loc27_.groundLevel;
               var _loc29_ = !_loc8_?_loc27_.spriteOnID == undefined?true:false:true;
               _loc24_ = !(_loc26_ == nCellEnd && _loc27_.movement == 1)?false:true;
               var _loc30_ = _loc22_.l == undefined || Math.abs(_loc28_ - _loc22_.l) < 2;
               if(_loc30_ && (_loc27_.active && _loc29_))
               {
                  var _loc31_ = "oCell" + _loc26_;
                  var _loc32_ = _loc22_.v + _loc14_[_loc25_] + (!(_loc27_.movement == 0 || _loc27_.movement == 1)?0:1000 + (_loc25_ % 2 != 0?0:3)) + (!(_loc27_.movement == 1 && _loc24_)?(_loc25_ == _loc22_.d?0:0.5) + (5 - _loc27_.movement) / 3:-1000);
                  var _loc33_ = _loc22_.g + _loc14_[_loc25_];
                  var _loc34_ = null;
                  if(_loc16_[_loc31_])
                  {
                     _loc34_ = _loc16_[_loc31_].v;
                  }
                  else if(_loc17_[_loc31_])
                  {
                     _loc34_ = _loc17_[_loc31_].v;
                  }
                  if((_loc34_ == null || _loc34_ > _loc32_) && _loc33_ <= _loc7_)
                  {
                     if(_loc17_[_loc31_])
                     {
                        delete register17.register31;
                     }
                     var _loc35_ = new Object();
                     _loc35_.num = _loc26_;
                     _loc35_.g = _loc33_;
                     _loc35_.v = _loc32_;
                     _loc35_.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,_loc26_,nCellEnd);
                     _loc35_.f = _loc35_.v + _loc35_.h;
                     _loc35_.d = _loc25_;
                     _loc35_.l = _loc28_;
                     _loc35_.m = _loc27_.movement;
                     _loc35_.parent = _loc22_;
                     _loc16_[_loc31_] = _loc35_;
                  }
               }
            }
            _loc25_ = _loc25_ + 1;
         }
         _loc17_["oCell" + _loc22_.num] = {v:_loc22_.v};
         _loc18_ = true;
         for(var k in _loc16_)
         {
            _loc18_ = false;
            break;
         }
      }
      return null;
   }
   static function goalDistEstimate(mapHandler, nCell1, nCell2)
   {
      var _loc5_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,nCell1);
      var _loc6_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,nCell2);
      var _loc7_ = Math.abs(_loc5_.x - _loc6_.x);
      var _loc8_ = Math.abs(_loc5_.y - _loc6_.y);
      return Math.sqrt(Math.pow(_loc7_,2) + Math.pow(_loc8_,2));
   }
   static function goalDistance(mapHandler, nCell1, nCell2)
   {
      var _loc5_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,nCell1);
      var _loc6_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,nCell2);
      var _loc7_ = Math.abs(_loc5_.x - _loc6_.x);
      var _loc8_ = Math.abs(_loc5_.y - _loc6_.y);
      return _loc7_ + _loc8_;
   }
   static function getCaseCoordonnee(mapHandler, nNum)
   {
      var _loc4_ = mapHandler.getWidth();
      var _loc5_ = Math.floor(nNum / (_loc4_ * 2 - 1));
      var _loc6_ = nNum - _loc5_ * (_loc4_ * 2 - 1);
      var _loc7_ = _loc6_ % _loc4_;
      var _loc8_ = new Object();
      _loc8_.y = _loc5_ - _loc7_;
      _loc8_.x = (nNum - (_loc4_ - 1) * _loc8_.y) / _loc4_;
      return _loc8_;
   }
   static function getDirection(mapHandler, nCell1, nCell2)
   {
      var _loc5_ = mapHandler.getWidth();
      var _loc6_ = [1,_loc5_,_loc5_ * 2 - 1,_loc5_ - 1,-1,- _loc5_,- _loc5_ * 2 + 1,- _loc5_ - 1];
      var _loc7_ = nCell2 - nCell1;
      var _loc8_ = 7;
      while(_loc8_ >= 0)
      {
         if(_loc6_[_loc8_] == _loc7_)
         {
            return _loc8_;
         }
         _loc8_ = _loc8_ - 1;
      }
      var _loc9_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,nCell1);
      var _loc10_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,nCell2);
      var _loc11_ = _loc10_.x - _loc9_.x;
      var _loc12_ = _loc10_.y - _loc9_.y;
      if(_loc11_ == 0)
      {
         if(_loc12_ > 0)
         {
            return 3;
         }
         return 7;
      }
      if(_loc11_ > 0)
      {
         return 1;
      }
      return 5;
   }
   static function getDirectionFromCoordinates(x1, y1, x2, y2, bAllDirections)
   {
      var _loc7_ = Math.atan2(y2 - y1,x2 - x1);
      if(bAllDirections)
      {
         if(_loc7_ >= (- Math.PI) / 8 && _loc7_ < Math.PI / 8)
         {
            return 0;
         }
         if(_loc7_ >= Math.PI / 8 && _loc7_ < Math.PI / 3)
         {
            return 1;
         }
         if(_loc7_ >= Math.PI / 3 && _loc7_ < 2 * Math.PI / 3)
         {
            return 2;
         }
         if(_loc7_ >= 2 * Math.PI / 3 && _loc7_ < 7 * Math.PI / 8)
         {
            return 3;
         }
         if(_loc7_ >= 7 * Math.PI / 8 || _loc7_ < -7 * Math.PI / 8)
         {
            return 4;
         }
         if(_loc7_ >= -7 * Math.PI / 8 && _loc7_ < -2 * Math.PI / 3)
         {
            return 5;
         }
         if(_loc7_ >= -2 * Math.PI / 3 && _loc7_ < (- Math.PI) / 3)
         {
            return 6;
         }
         if(_loc7_ >= (- Math.PI) / 3 && _loc7_ < (- Math.PI) / 8)
         {
            return 7;
         }
      }
      else
      {
         if(_loc7_ >= 0 && _loc7_ < Math.PI / 2)
         {
            return 1;
         }
         if(_loc7_ >= Math.PI / 2 && _loc7_ <= Math.PI)
         {
            return 3;
         }
         if(_loc7_ >= - Math.PI && _loc7_ < (- Math.PI) / 2)
         {
            return 5;
         }
         if(_loc7_ >= (- Math.PI) / 2 && _loc7_ < 0)
         {
            return 7;
         }
      }
      return 1;
   }
   static function getArroundCellNum(mapHandler, nCellNum, nDirectionModerator, nIndex)
   {
      var _loc6_ = mapHandler.getWidth();
      var _loc7_ = [1,_loc6_,_loc6_ * 2 - 1,_loc6_ - 1,-1,- _loc6_,- _loc6_ * 2 + 1,- _loc6_ - 1];
      var _loc8_ = 0;
      switch(nIndex % 8)
      {
         case 0:
            _loc8_ = 2;
            break;
         case 1:
            _loc8_ = 6;
            break;
         case 2:
            _loc8_ = 4;
            break;
         case 3:
            _loc8_ = 0;
            break;
         case 4:
            _loc8_ = 3;
            break;
         case 5:
            _loc8_ = 5;
            break;
         case 6:
            _loc8_ = 1;
            break;
         case 7:
            _loc8_ = 7;
      }
      _loc8_ = (_loc8_ + nDirectionModerator) % 8;
      var _loc9_ = nCellNum + _loc7_[_loc8_];
      var _loc10_ = mapHandler.getCellsData();
      var _loc11_ = _loc10_[_loc9_];
      if(_loc11_.active && (_loc10_[_loc9_] != undefined && Math.abs(_loc10_[_loc9_].x - _loc10_[nCellNum].x) <= 53))
      {
         return _loc9_;
      }
      return nCellNum;
   }
   static function convertHeightToFourDirection(nDirection)
   {
      return nDirection | 1;
   }
   static function getSlopeOk(slope1, level1, slope2, level2, dir)
   {
      switch(dir)
      {
         case 0:
            if(((slope1 - 1 & 2) >> 1) + level1 != (slope2 - 1 & 1) + level2)
            {
               return false;
            }
            break;
         case 1:
            if(((slope1 - 1 & 4) >> 2) + level1 != ((slope2 - 1 & 2) >> 1) + level2)
            {
               return false;
            }
            if(((slope1 - 1 & 8) >> 3) + level1 != (slope2 - 1 & 1) + level2)
            {
               return false;
            }
            break;
         case 2:
            if(((slope1 - 1 & 8) >> 3) + level1 != ((slope2 - 1 & 2) >> 1) + level2)
            {
               return false;
            }
            break;
         case 3:
            if(((slope1 - 1 & 8) >> 3) + level1 != ((slope2 - 1 & 4) >> 2) + level2)
            {
               return false;
            }
            if((slope1 - 1 & 1) + level1 != ((slope2 - 1 & 2) >> 1) + level2)
            {
               return false;
            }
            break;
         case 4:
            if((slope1 - 1 & 1) + level1 != ((slope2 - 1 & 4) >> 2) + level2)
            {
               return false;
            }
            break;
         case 5:
            if((slope1 - 1 & 1) + level1 != ((slope2 - 1 & 8) >> 3) + level2)
            {
               return false;
            }
            if(((slope1 - 1 & 2) >> 1) + level1 != ((slope2 - 1 & 4) >> 2) + level2)
            {
               return false;
            }
            break;
         case 6:
            if(((slope1 - 1 & 2) >> 1) + level1 != ((slope2 - 1 & 8) >> 3) + level2)
            {
               return false;
            }
            break;
         case 7:
            if(((slope1 - 1 & 2) >> 1) + level1 != (slope2 - 1 & 1) + level2)
            {
               return false;
            }
            if(((slope1 - 1 & 4) >> 2) + level1 != ((slope2 - 1 & 8) >> 3) + level2)
            {
               return false;
            }
            break;
      }
      return true;
   }
   static function checkView(mapHandler, cell1, cell2)
   {
      var _loc5_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell1);
      var _loc6_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell2);
      var _loc7_ = mapHandler.getCellData(cell1);
      var _loc8_ = mapHandler.getCellData(cell2);
      var _loc9_ = !_loc7_.spriteOnID?0:1.5;
      var _loc10_ = !_loc8_.spriteOnID?0:1.5;
      _loc9_ = _loc9_ + (!_loc7_.carriedSpriteOnId?0:1.5);
      _loc10_ = _loc10_ + (!_loc8_.carriedSpriteOnId?0:1.5);
      _loc5_.z = mapHandler.getCellHeight(cell1) + _loc9_;
      _loc6_.z = mapHandler.getCellHeight(cell2) + _loc10_;
      var _loc11_ = _loc6_.z - _loc5_.z;
      var _loc12_ = Math.max(Math.abs(_loc5_.y - _loc6_.y),Math.abs(_loc5_.x - _loc6_.x));
      var _loc13_ = (_loc5_.y - _loc6_.y) / (_loc5_.x - _loc6_.x);
      var _loc14_ = _loc5_.y - _loc13_ * _loc5_.x;
      var _loc15_ = _loc6_.x - _loc5_.x >= 0?1:-1;
      var _loc16_ = _loc6_.y - _loc5_.y >= 0?1:-1;
      var _loc17_ = _loc5_.y;
      var _loc18_ = _loc5_.x;
      var _loc19_ = _loc6_.x * _loc15_;
      var _loc20_ = _loc6_.y * _loc16_;
      var _loc27_ = _loc5_.x + 0.5 * _loc15_;
      while(_loc27_ * _loc15_ <= _loc19_)
      {
         var _loc25_ = _loc13_ * _loc27_ + _loc14_;
         if(_loc16_ > 0)
         {
            var _loc21_ = Math.round(_loc25_);
            var _loc22_ = Math.ceil(_loc25_ - 0.5);
         }
         else
         {
            _loc21_ = Math.ceil(_loc25_ - 0.5);
            _loc22_ = Math.round(_loc25_);
         }
         var _loc26_ = _loc17_;
         while(_loc26_ * _loc16_ <= _loc22_ * _loc16_)
         {
            if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,_loc27_ - _loc15_ / 2,_loc26_,false,_loc5_,_loc6_,_loc11_,_loc12_))
            {
               return false;
            }
            _loc26_ = _loc26_ + _loc16_;
         }
         _loc17_ = _loc21_;
         _loc27_ = _loc27_ + _loc15_;
      }
      _loc26_ = _loc17_;
      while(_loc26_ * _loc16_ <= _loc6_.y * _loc16_)
      {
         if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,_loc27_ - 0.5 * _loc15_,_loc26_,false,_loc5_,_loc6_,_loc11_,_loc12_))
         {
            return false;
         }
         _loc26_ = _loc26_ + _loc16_;
      }
      if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,_loc27_ - 0.5 * _loc15_,_loc26_ - _loc16_,true,_loc5_,_loc6_,_loc11_,_loc12_))
      {
         return false;
      }
      return true;
   }
   static function checkCellView(mapHandler, x, y, bool, p1, p2, zDiff, d)
   {
      var _loc10_ = ank.battlefield.utils.Pathfinding.getCaseNum(mapHandler,x,y);
      var _loc11_ = mapHandler.getCellData(_loc10_);
      var _loc12_ = Math.max(Math.abs(p1.y - y),Math.abs(p1.x - x));
      var _loc13_ = _loc12_ / d * zDiff + p1.z;
      var _loc14_ = mapHandler.getCellHeight(_loc10_);
      var _loc15_ = !(_loc11_.spriteOnID == undefined || (_loc12_ == 0 || (bool || p2.x == x && p2.y == y)))?true:false;
      if(_loc11_.lineOfSight && (_loc11_.active && (_loc14_ <= _loc13_ && !_loc15_)))
      {
         return true;
      }
      if(bool)
      {
         return true;
      }
      return false;
   }
   static function getCaseNum(mapHandler, x, y)
   {
      var _loc5_ = mapHandler.getWidth();
      return x * _loc5_ + y * (_loc5_ - 1);
   }
   static function checkAlign(mapHandler, cell1, cell2)
   {
      var _loc5_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell1);
      var _loc6_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell2);
      if(_loc5_.x == _loc6_.x)
      {
         return true;
      }
      if(_loc5_.y == _loc6_.y)
      {
         return true;
      }
      return false;
   }
   static function checkRange(mapHandler, nCell1, nCell2, bLineOnly, nRangeMin, nRangeMax, nRangeModerator)
   {
      nRangeMin = Number(nRangeMin);
      nRangeMax = Number(nRangeMax);
      nRangeModerator = Number(nRangeModerator);
      if(nRangeMax != 0)
      {
         nRangeMax = nRangeMax + nRangeModerator;
         nRangeMax = Math.max(nRangeMin,nRangeMax);
      }
      if(bLineOnly)
      {
         if(!ank.battlefield.utils.Pathfinding.checkAlign(mapHandler,nCell1,nCell2))
         {
            return false;
         }
      }
      if(ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,nCell1,nCell2) > nRangeMax || ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,nCell1,nCell2) < nRangeMin)
      {
         return false;
      }
      return true;
   }
}
