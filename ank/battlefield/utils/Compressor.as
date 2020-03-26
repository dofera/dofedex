class ank.battlefield.utils.Compressor extends ank.utils.Compressor
{
   function Compressor()
   {
      super();
   }
   static function uncompressMap(mapID, name, width, height, backgroundNum, sData, oMap, bForced)
   {
      if(oMap == undefined)
      {
         return undefined;
      }
      var _loc10_ = new Array();
      var _loc11_ = sData.length;
      var _loc13_ = 0;
      var _loc14_ = 0;
      while(_loc14_ < _loc11_)
      {
         var _loc12_ = ank.battlefield.utils.Compressor.uncompressCell(sData.substring(_loc14_,_loc14_ + 10),bForced,0);
         _loc12_.num = _loc13_;
         _loc10_.push(_loc12_);
         _loc13_ = _loc13_ + 1;
         _loc14_ = _loc14_ + 10;
      }
      oMap.id = Number(mapID);
      oMap.name = name;
      oMap.width = Number(width);
      oMap.height = Number(height);
      oMap.backgroundNum = backgroundNum;
      oMap.data = _loc10_;
   }
   static function uncompressCell(sData, bForced, nPermanentLevel)
   {
      if(bForced == undefined)
      {
         bForced = false;
      }
      if(nPermanentLevel == undefined)
      {
         nPermanentLevel = 0;
      }
      else
      {
         nPermanentLevel = Number(nPermanentLevel);
      }
      var _loc5_ = new ank.battlefield.datacenter.Cell();
      var _loc6_ = sData.split("");
      var _loc7_ = _loc6_.length - 1;
      var _loc8_ = new Array();
      while(_loc7_ >= 0)
      {
         _loc8_[_loc7_] = ank.utils.Compressor._self._hashCodes[_loc6_[_loc7_]];
         _loc7_ = _loc7_ - 1;
      }
      _loc5_.active = !((_loc8_[0] & 32) >> 5)?false:true;
      if(_loc5_.active || bForced)
      {
         _loc5_.nPermanentLevel = nPermanentLevel;
         _loc5_.lineOfSight = !(_loc8_[0] & 1)?false:true;
         _loc5_.layerGroundRot = (_loc8_[1] & 48) >> 4;
         _loc5_.groundLevel = _loc8_[1] & 15;
         _loc5_.movement = (_loc8_[2] & 56) >> 3;
         _loc5_.layerGroundNum = ((_loc8_[0] & 24) << 6) + ((_loc8_[2] & 7) << 6) + _loc8_[3];
         _loc5_.groundSlope = (_loc8_[4] & 60) >> 2;
         _loc5_.layerGroundFlip = !((_loc8_[4] & 2) >> 1)?false:true;
         _loc5_.layerObject1Num = ((_loc8_[0] & 4) << 11) + ((_loc8_[4] & 1) << 12) + (_loc8_[5] << 6) + _loc8_[6];
         _loc5_.layerObject1Rot = (_loc8_[7] & 48) >> 4;
         _loc5_.layerObject1Flip = !((_loc8_[7] & 8) >> 3)?false:true;
         _loc5_.layerObject2Flip = !((_loc8_[7] & 4) >> 2)?false:true;
         _loc5_.layerObject2Interactive = !((_loc8_[7] & 2) >> 1)?false:true;
         _loc5_.layerObject2Num = ((_loc8_[0] & 2) << 12) + ((_loc8_[7] & 1) << 12) + (_loc8_[8] << 6) + _loc8_[9];
         _loc5_.layerObjectExternal = "";
         _loc5_.layerObjectExternalInteractive = false;
      }
      return _loc5_;
   }
   static function compressMap(oMap)
   {
      if(oMap == undefined)
      {
         return undefined;
      }
      var _loc3_ = new Array();
      var _loc4_ = oMap.data;
      var _loc5_ = _loc4_.length;
      var _loc6_ = 0;
      while(_loc6_ < _loc5_)
      {
         _loc3_.push(ank.battlefield.utils.Compressor.compressCell(_loc4_[_loc6_]));
         _loc6_ = _loc6_ + 1;
      }
      return _loc3_.join("");
   }
   static function compressCell(oCell)
   {
      var _loc4_ = new Array(0,0,0,0,0,0,0,0,0,0);
      _loc4_[0] = (!oCell.active?0:1) << 5;
      _loc4_[0] = _loc4_[0] | (!oCell.lineOfSight?0:1);
      _loc4_[0] = _loc4_[0] | (oCell.layerGroundNum & 1536) >> 6;
      _loc4_[0] = _loc4_[0] | (oCell.layerObject1Num & 8192) >> 11;
      _loc4_[0] = _loc4_[0] | (oCell.layerObject2Num & 8192) >> 12;
      _loc4_[1] = (oCell.layerGroundRot & 3) << 4;
      _loc4_[1] = _loc4_[1] | oCell.groundLevel & 15;
      _loc4_[2] = (oCell.movement & 7) << 3;
      _loc4_[2] = _loc4_[2] | oCell.layerGroundNum >> 6 & 7;
      _loc4_[3] = oCell.layerGroundNum & 63;
      _loc4_[4] = (oCell.groundSlope & 15) << 2;
      _loc4_[4] = _loc4_[4] | (!oCell.layerGroundFlip?0:1) << 1;
      _loc4_[4] = _loc4_[4] | oCell.layerObject1Num >> 12 & 1;
      _loc4_[5] = oCell.layerObject1Num >> 6 & 63;
      _loc4_[6] = oCell.layerObject1Num & 63;
      _loc4_[7] = (oCell.layerObject1Rot & 3) << 4;
      _loc4_[7] = _loc4_[7] | (!oCell.layerObject1Flip?0:1) << 3;
      _loc4_[7] = _loc4_[7] | (!oCell.layerObject2Flip?0:1) << 2;
      _loc4_[7] = _loc4_[7] | (!oCell.layerObject2Interactive?0:1) << 1;
      _loc4_[7] = _loc4_[7] | oCell.layerObject2Num >> 12 & 1;
      _loc4_[8] = oCell.layerObject2Num >> 6 & 63;
      _loc4_[9] = oCell.layerObject2Num & 63;
      var _loc5_ = _loc4_.length - 1;
      while(_loc5_ >= 0)
      {
         _loc4_[_loc5_] = ank.utils.Compressor.encode64(_loc4_[_loc5_]);
         _loc5_ = _loc5_ - 1;
      }
      var _loc3_ = _loc4_.join("");
      return _loc3_;
   }
   static function compressPath(aFullPathData, bWithFirst)
   {
      var _loc4_ = new String();
      var _loc5_ = ank.battlefield.utils.Compressor.makeLightPath(aFullPathData,bWithFirst);
      var _loc11_ = _loc5_.length;
      var _loc6_ = 0;
      while(_loc6_ < _loc11_)
      {
         var _loc7_ = _loc5_[_loc6_];
         var _loc8_ = _loc7_.dir & 7;
         var _loc9_ = (_loc7_.num & 4032) >> 6;
         var _loc10_ = _loc7_.num & 63;
         _loc4_ = _loc4_ + ank.utils.Compressor.encode64(_loc8_);
         _loc4_ = _loc4_ + ank.utils.Compressor.encode64(_loc9_);
         _loc4_ = _loc4_ + ank.utils.Compressor.encode64(_loc10_);
         _loc6_ = _loc6_ + 1;
      }
      return _loc4_;
   }
   static function makeLightPath(aFullPath, bWithFirst)
   {
      if(aFullPath == undefined)
      {
         ank.utils.Logger.err("Le chemin est vide");
         return new Array();
      }
      var _loc4_ = new Array();
      if(bWithFirst)
      {
         _loc4_.push(aFullPath[0]);
      }
      var _loc6_ = aFullPath.length - 1;
      while(_loc6_ >= 0)
      {
         if(aFullPath[_loc6_].dir != _loc5_)
         {
            _loc4_.splice(0,0,aFullPath[_loc6_]);
            var _loc5_ = aFullPath[_loc6_].dir;
         }
         _loc6_ = _loc6_ - 1;
      }
      return _loc4_;
   }
   static function extractFullPath(mapHandler, compressedData)
   {
      var _loc4_ = new Array();
      var _loc5_ = compressedData.split("");
      var _loc7_ = compressedData.length;
      var _loc8_ = mapHandler.getCellCount();
      var _loc6_ = 0;
      while(_loc6_ < _loc7_)
      {
         _loc5_[_loc6_] = ank.utils.Compressor.decode64(_loc5_[_loc6_]);
         _loc5_[_loc6_ + 1] = ank.utils.Compressor.decode64(_loc5_[_loc6_ + 1]);
         _loc5_[_loc6_ + 2] = ank.utils.Compressor.decode64(_loc5_[_loc6_ + 2]);
         var _loc9_ = (_loc5_[_loc6_ + 1] & 15) << 6 | _loc5_[_loc6_ + 2];
         if(_loc9_ < 0)
         {
            ank.utils.Logger.err("Case pas sur carte");
            return null;
         }
         if(_loc9_ > _loc8_)
         {
            ank.utils.Logger.err("Case pas sur carte");
            return null;
         }
         _loc4_.push({num:_loc9_,dir:_loc5_[_loc6_]});
         _loc6_ = _loc6_ + 3;
      }
      return ank.battlefield.utils.Compressor.makeFullPath(mapHandler,_loc4_);
   }
   static function makeFullPath(mapHandler, aLightPath)
   {
      var _loc4_ = new Array();
      var _loc6_ = 0;
      var _loc7_ = mapHandler.getWidth();
      var _loc8_ = [1,_loc7_,_loc7_ * 2 - 1,_loc7_ - 1,-1,- _loc7_,- _loc7_ * 2 + 1,- _loc7_ - 1];
      var _loc5_ = aLightPath[0].num;
      _loc4_[_loc6_] = _loc5_;
      var _loc9_ = 1;
      while(_loc9_ < aLightPath.length)
      {
         var _loc10_ = aLightPath[_loc9_].num;
         var _loc11_ = aLightPath[_loc9_].dir;
         var _loc12_ = 2 * _loc7_ + 1;
         while(_loc4_[_loc6_] != _loc10_)
         {
            _loc5_ = _loc5_ + _loc8_[_loc11_];
            _loc4_[_loc6_ = _loc6_ + 1] = _loc5_;
            if((_loc12_ = _loc12_ - 1) < 0)
            {
               ank.utils.Logger.err("Chemin impossible");
               return null;
            }
         }
         _loc5_ = _loc10_;
         _loc9_ = _loc9_ + 1;
      }
      return _loc4_;
   }
}
