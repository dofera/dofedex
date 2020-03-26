class ank.battlefield.utils.SpriteDepthFinder
{
   function SpriteDepthFinder()
   {
   }
   static function getFreeDepthOnCell(mapHandler, oSprites, nCellNum, bGhostView)
   {
      if(nCellNum < 0)
      {
         ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être < 0.");
         nCellNum = 0;
      }
      if(nCellNum > mapHandler.getCellCount())
      {
         ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être > " + mapHandler.getCellCount());
         nCellNum = 0;
      }
      var _loc6_ = mapHandler.getCellData(nCellNum).allSpritesOn;
      var _loc7_ = new Object();
      for(var k in _loc6_)
      {
         _loc7_[oSprites.getItemAt(k).mc.getDepth()] = true;
      }
      var _loc8_ = nCellNum * 100 + ank.battlefield.Constants.FIRST_SPRITE_DEPTH_ON_CELL + (!bGhostView?0:ank.battlefield.Constants.MAX_DEPTH_IN_MAP);
      var _loc9_ = 0;
      while(_loc9_ < ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
      {
         if(_loc7_[_loc8_ + _loc9_] != true)
         {
            break;
         }
         _loc9_ = _loc9_ + 1;
      }
      if(_loc9_ == ank.battlefield.Constants.MAX_SPRITES_ON_CELL - 1 && _loc7_[_loc8_ + _loc9_] == true)
      {
         ank.utils.Logger.err("[getFreeDepthOnCell] plus de place sur cette cellule");
      }
      return _loc8_ + _loc9_;
   }
}
