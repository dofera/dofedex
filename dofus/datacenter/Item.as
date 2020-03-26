class dofus.datacenter.Item extends Object
{
   static var LEVEL_STEP = [0,10,21,33,46,60,75,91,108,126,145,165,186,208,231,255,280,306,333,361];
   static var DATE_ID = 0;
   function Item(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
   {
      super();
      this.initialize(nID,nUnicID,nQuantity,nPosition,sEffects,nPrice,nSkin,nMood);
   }
   function __get__label()
   {
      return this._nQuantity <= 1?undefined:this._nQuantity;
   }
   function __get__ID()
   {
      return this._nID;
   }
   function __get__unicID()
   {
      return this._nUnicID;
   }
   function __get__compressedEffects()
   {
      return this._sEffects;
   }
   function __set__Quantity(value)
   {
      if(_global.isNaN(Number(value)))
      {
         return undefined;
      }
      this._nQuantity = Number(value);
      return this.__get__Quantity();
   }
   function __get__Quantity()
   {
      return this._nQuantity;
   }
   function __set__remainingHours(nRemainingHours)
   {
      this._nRemainingHours = nRemainingHours;
      return this.__get__remainingHours();
   }
   function __get__remainingHours()
   {
      return this._nRemainingHours;
   }
   function __set__position(value)
   {
      if(_global.isNaN(Number(value)))
      {
         return undefined;
      }
      this._nPosition = Number(value);
      return this.__get__position();
   }
   function __get__position()
   {
      return this._nPosition;
   }
   function __set__priceMultiplicator(value)
   {
      if(_global.isNaN(Number(value)))
      {
         return undefined;
      }
      this._nPriceMultiplicator = Number(value);
      return this.__get__priceMultiplicator();
   }
   function __get__priceMultiplicator()
   {
      return this._nPriceMultiplicator;
   }
   function __get__name()
   {
      return ank.utils.PatternDecoder.getDescription(this.api.lang.fetchString(this._oUnicInfos.n),this.api.lang.getItemUnicStringText());
   }
   function __get__description()
   {
      var _loc2_ = this.api.lang.getItemTypeText(this.type).n;
      var _loc3_ = "";
      if(this.isFromItemSet)
      {
         var _loc4_ = new dofus.datacenter.ItemSet(this.itemSetID);
         _loc3_ = "<u>" + _loc4_.name + " (" + this.api.lang.getText("ITEM_TYPE") + " : " + _loc2_ + ")</u>\n";
      }
      else
      {
         _loc3_ = "<u>" + this.api.lang.getText("ITEM_TYPE") + " : " + _loc2_ + "</u>\n";
      }
      return _loc3_ + ank.utils.PatternDecoder.getDescription(this.api.lang.fetchString(this._oUnicInfos.d),this.api.lang.getItemUnicStringText());
   }
   function __get__type()
   {
      if(this._nRealType)
      {
         return this._nRealType;
      }
      return Number(this._oUnicInfos.t);
   }
   function __set__type(nType)
   {
      this._nRealType = nType;
      return this.__get__type();
   }
   function __get__realType()
   {
      return Number(this._oUnicInfos.t);
   }
   function __get__enhanceable()
   {
      return !!this._oUnicInfos.fm;
   }
   function __get__style()
   {
      if(this.isFromItemSet)
      {
         return "ItemSet";
      }
      if(this.isEthereal)
      {
         return "Ethereal";
      }
      return "";
   }
   function __get__needTwoHands()
   {
      return this._oUnicInfos.tw == true;
   }
   function __get__isEthereal()
   {
      return this._oUnicInfos.et == true;
   }
   function __get__isHidden()
   {
      return this._oUnicInfos.h == true;
   }
   function __get__etherealResistance()
   {
      if(this.isEthereal)
      {
         for(var k in this._aEffects)
         {
            var _loc2_ = this._aEffects[k];
            if(_loc2_[0] == 812)
            {
               return new dofus.datacenter.Effect(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
            }
         }
      }
      return new Array();
   }
   function __get__isFromItemSet()
   {
      return this._oUnicInfos.s != undefined;
   }
   function __get__itemSetID()
   {
      return this._oUnicInfos.s;
   }
   function __get__typeText()
   {
      return this.api.lang.getItemTypeText(this.type);
   }
   function __get__superType()
   {
      return this.typeText.t;
   }
   function __get__superTypeText()
   {
      return this.api.lang.getItemSuperTypeText(this.superType);
   }
   function __get__iconFile()
   {
      return dofus.Constants.ITEMS_PATH + this.type + "/" + this.gfx + ".swf";
   }
   function __get__effects()
   {
      return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects);
   }
   function __get__visibleEffects()
   {
      return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects,true);
   }
   function __get__canUse()
   {
      return this._oUnicInfos.u != undefined?true:false;
   }
   function __get__canTarget()
   {
      return this._oUnicInfos.ut != undefined?true:false;
   }
   function __get__canDestroy()
   {
      return this.superType != 14 && !this.isCursed;
   }
   function __get__canDrop()
   {
      return this.superType != 14 && !this.isCursed;
   }
   function __get__canMoveToShortut()
   {
      return this.canUse == true || this.canTarget == true;
   }
   function __get__level()
   {
      return Number(this._oUnicInfos.l);
   }
   function __get__gfx()
   {
      if(this._sGfx)
      {
         return this._sGfx;
      }
      return this._oUnicInfos.g;
   }
   function __set__gfx(sGfx)
   {
      this._sGfx = sGfx;
      return this.__get__gfx();
   }
   function __get__realGfx()
   {
      return this._sRealGfx;
   }
   function __get__price()
   {
      if(this._nPrice == undefined)
      {
         return Math.max(0,Math.round(Number(this._oUnicInfos.p) * (this._nPriceMultiplicator != undefined?this._nPriceMultiplicator:0)));
      }
      return this._nPrice;
   }
   function __get__weight()
   {
      return Number(this._oUnicInfos.w);
   }
   function __get__isCursed()
   {
      return this._oUnicInfos.m;
   }
   function __get__normalHit()
   {
      return this._aEffects;
   }
   function __get__criticalHitBonus()
   {
      return this.getItemFightEffectsText(0);
   }
   function __get__apCost()
   {
      return this.getItemFightEffectsText(1);
   }
   function __get__rangeMin()
   {
      return this.getItemFightEffectsText(2);
   }
   function __get__rangeMax()
   {
      return this.getItemFightEffectsText(3);
   }
   function __get__criticalHit()
   {
      return this.getItemFightEffectsText(4);
   }
   function __get__criticalFailure()
   {
      return this.getItemFightEffectsText(5);
   }
   function __get__lineOnly()
   {
      return this.getItemFightEffectsText(6);
   }
   function __get__lineOfSight()
   {
      return this.getItemFightEffectsText(7);
   }
   function __get__effectZones()
   {
      return this._aEffectZones;
   }
   function __get__characteristics()
   {
      var _loc2_ = new Array();
      _loc2_.push(this.api.lang.getText("ITEM_AP",[this.apCost]));
      _loc2_.push(this.api.lang.getText("ITEM_RANGE",[(this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax]));
      _loc2_.push(this.api.lang.getText("ITEM_CRITICAL_BONUS",[this.criticalHitBonus <= 0?String(this.criticalHitBonus):"+" + this.criticalHitBonus]));
      _loc2_.push((this.criticalHit == 0?"":this.api.lang.getText("ITEM_CRITICAL",[this.criticalHit])) + (!(this.criticalHit != 0 && this.criticalFailure != 0)?"":" - ") + (this.criticalFailure == 0?"":this.api.lang.getText("ITEM_MISS",[this.criticalFailure])));
      if(this.criticalHit > 0 && this.ID == this.api.datacenter.Player.weaponItem.ID)
      {
         var _loc3_ = this.api.kernel.GameManager.getCriticalHitChance(this.criticalHit);
         _loc2_.push(this.api.lang.getText("ITEM_CRITICAL_REAL",["1/" + _loc3_]));
      }
      return _loc2_;
   }
   function __get__conditions()
   {
      var _loc2_ = [">","<","=","!"];
      var _loc3_ = this._oUnicInfos.c;
      if(_loc3_ == undefined || _loc3_.length == 0)
      {
         return [String(this.api.lang.getText("NO_CONDITIONS"))];
      }
      var _loc4_ = _loc3_.split("&");
      var _loc5_ = new Array();
      var _loc6_ = 0;
      while(_loc6_ < _loc4_.length)
      {
         _loc4_[_loc6_] = new ank.utils.ExtendedString(_loc4_[_loc6_]).replace(["(",")"],["",""]);
         var _loc7_ = _loc4_[_loc6_].split("|");
         var _loc8_ = 0;
         for(; _loc8_ < _loc7_.length; _loc8_ = _loc8_ + 1)
         {
            var _loc11_ = 0;
            while(_loc11_ < _loc2_.length)
            {
               var _loc10_ = _loc2_[_loc11_];
               var _loc9_ = _loc7_[_loc8_].split(_loc10_);
               if(_loc9_.length > 1)
               {
                  break;
               }
               _loc11_ = _loc11_ + 1;
            }
            if(_loc9_ != undefined)
            {
               var _loc12_ = String(_loc9_[0]);
               var _loc13_ = _loc9_[1];
               if(_loc12_ == "PZ")
               {
                  break;
               }
               switch(_loc12_)
               {
                  case "Ps":
                     _loc13_ = this.api.lang.getAlignment(Number(_loc13_)).n;
                  case "PS":
                     _loc13_ = _loc13_ != "1"?this.api.lang.getText("MALE"):this.api.lang.getText("FEMELE");
                  case "Pr":
                     _loc13_ = this.api.lang.getAlignmentSpecialization(Number(_loc13_)).n;
                  case "Pg":
                     var _loc14_ = _loc13_.split(",");
                     if(_loc14_.length == 2)
                     {
                        _loc13_ = this.api.lang.getAlignmentFeat(Number(_loc14_[0])).n + " (" + Number(_loc14_[1]) + ")";
                     }
                     else
                     {
                        _loc13_ = this.api.lang.getAlignmentFeat(Number(_loc13_)).n;
                     }
                  case "PG":
                     _loc13_ = this.api.lang.getClassText(Number(_loc13_)).sn;
                  case "PJ":
                  case "Pj":
                     var _loc15_ = _loc13_.split(",");
                     _loc13_ = this.api.lang.getJobText(_loc15_[0]).n + (_loc15_[1] != undefined?" (" + this.api.lang.getText("LEVEL_SMALL") + " " + _loc15_[1] + ")":"");
                  case "PM":
                     continue;
                  case "PO":
                     var _loc16_ = new dofus.datacenter.Item(-1,Number(_loc13_),1,0,"",0);
                     _loc13_ = _loc16_.name;
                  default:
                     _loc12_ = new ank.utils.ExtendedString(_loc12_).replace(["CS","Cs","CV","Cv","CA","Ca","CI","Ci","CW","Cw","CC","Cc","CA","PG","PJ","Pj","PM","PA","PN","PE","<NO>","PS","PR","PL","PK","Pg","Pr","Ps","Pa","PP","PZ","CM"],this.api.lang.getText("ITEM_CHARACTERISTICS").split(","));
                     var _loc17_ = _loc10_ == "!";
                     _loc10_ = new ank.utils.ExtendedString(_loc10_).replace(["!"],[this.api.lang.getText("ITEM_NO")]);
                     switch(_loc12_)
                     {
                        case "BI":
                           _loc5_.push(this.api.lang.getText("UNUSABLE"));
                           break;
                        case "PO":
                           if(_loc17_)
                           {
                              _loc5_.push(this.api.lang.getText("ITEM_DO_NOT_POSSESS",[_loc13_]) + " <" + _loc10_ + ">");
                           }
                           else
                           {
                              _loc5_.push(this.api.lang.getText("ITEM_DO_POSSESS",[_loc13_]) + " <" + _loc10_ + ">");
                           }
                           break;
                        default:
                           _loc5_.push((_loc8_ <= 0?"":this.api.lang.getText("ITEM_OR") + " ") + _loc12_ + " " + _loc10_ + " " + _loc13_);
                     }
               }
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      return _loc5_;
   }
   function __get__mood()
   {
      return this._nMood;
   }
   function __get__skin()
   {
      return this._nSkin;
   }
   function __set__skin(nSkin)
   {
      this._nSkin = nSkin;
      return this.__get__skin();
   }
   function __get__params()
   {
      if(!this.isLeavingItem)
      {
         return undefined;
      }
      var _loc3_ = this.skin;
      if(_loc3_ == undefined || _global.isNaN(_loc3_))
      {
         _loc3_ = 0;
      }
      switch(this.mood)
      {
         case 1:
            var _loc2_ = "H";
            break;
         case 2:
         case 0:
            _loc2_ = "U";
            break;
         default:
            _loc2_ = "H";
      }
      return {frame:_loc2_ + _loc3_,forceReload:this.isLeavingItem};
   }
   function __get__skineable()
   {
      return this._bIsSkineable;
   }
   function __get__isAssociate()
   {
      return this.skineable && this.realType != 113;
   }
   function __get__realUnicId()
   {
      if(this._nRealUnicId)
      {
         return this._nRealUnicId;
      }
      return this._nUnicID;
   }
   function __get__maxSkin()
   {
      var _loc2_ = 1;
      while(_loc2_ < dofus.datacenter.Item.LEVEL_STEP.length)
      {
         if(this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[_loc2_])
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return dofus.datacenter.Item.LEVEL_STEP.length;
   }
   function __get__currentLivingXp()
   {
      return this._nLivingXp;
   }
   function __get__currentLivingLevelXpMax()
   {
      var _loc2_ = 1;
      while(_loc2_ < dofus.datacenter.Item.LEVEL_STEP.length)
      {
         if(this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[_loc2_])
         {
            return dofus.datacenter.Item.LEVEL_STEP[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function __get__currentLivingLevelXpMin()
   {
      var _loc2_ = 1;
      while(_loc2_ < dofus.datacenter.Item.LEVEL_STEP.length)
      {
         if(this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[_loc2_])
         {
            return dofus.datacenter.Item.LEVEL_STEP[_loc2_ - 1];
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function __get__isSpeakingItem()
   {
      return this.isAssociate || this.realType == 113;
   }
   function __get__isLeavingItem()
   {
      return this.isAssociate || this.realType == 113;
   }
   function __get__canBeExchange()
   {
      return this._bCanBeExchange;
   }
   function initialize(nID, nUnicID, nQuantity, nPosition, sEffects, nPrice, nSkin, nMood)
   {
      this.api = _global.API;
      dofus.datacenter.Item.DATE_ID = dofus.datacenter.Item.DATE_ID - 1;
      this._itemDateId = dofus.datacenter.Item.DATE_ID;
      this._nID = nID;
      this._nUnicID = nUnicID;
      this._nQuantity = nQuantity != undefined?nQuantity:1;
      this._nPosition = nPosition != undefined?nPosition:-1;
      if(nPrice != undefined)
      {
         this._nPrice = nPrice;
      }
      this._bCanBeExchange = true;
      this._oUnicInfos = this.api.lang.getItemUnicText(nUnicID);
      this.setEffects(sEffects);
      this._bIsSkineable = false;
      this.updateDataFromEffect();
      var _loc10_ = this.typeText.z;
      var _loc11_ = _loc10_.split("");
      this._aEffectZones = new Array();
      var _loc12_ = 0;
      while(_loc12_ < _loc11_.length)
      {
         this._aEffectZones.push({shape:_loc11_[_loc12_],size:ank.utils.Compressor.decode64(_loc11_[_loc12_ + 1])});
         _loc12_ = _loc12_ + 2;
      }
      this._itemLevel = this.level;
      this._itemType = this.type;
      this._itemPrice = this.price;
      this._itemName = this.name;
      this._itemWeight = this.weight;
      if(nSkin != undefined)
      {
         this._nSkin = nSkin;
      }
      if(nMood != undefined)
      {
         this._nMood = nMood;
      }
   }
   function setEffects(compressedData)
   {
      this._sEffects = compressedData;
      this._aEffects = new Array();
      var _loc3_ = compressedData.split(",");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].split("#");
         _loc5_[0] = _global.parseInt(_loc5_[0],16);
         _loc5_[1] = _loc5_[1] != "0"?_global.parseInt(_loc5_[1],16):undefined;
         _loc5_[2] = _loc5_[2] != "0"?_global.parseInt(_loc5_[2],16):undefined;
         _loc5_[3] = _loc5_[3] != "0"?_global.parseInt(_loc5_[3],16):undefined;
         _loc5_[4] = _loc5_[4];
         this._aEffects.push(_loc5_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function clone()
   {
      return new dofus.datacenter.Item(this._nID,this._nUnicID,this._nQuantity,this._nPosition,this._sEffects);
   }
   function equals(item)
   {
      return this.unicID == item.unicID;
   }
   function getItemFightEffectsText(nPropertyIndex)
   {
      return this._oUnicInfos.e[nPropertyIndex];
   }
   function updateDataFromEffect()
   {
      for(var k in this._aEffects)
      {
         var _loc2_ = this._aEffects[k];
         switch(_loc2_[0])
         {
            case 974:
               this._nLivingXp = !_loc2_[3]?0:_loc2_[3];
               break;
            case 973:
               this._nRealType = !_loc2_[3]?0:_loc2_[3];
               break;
            case 972:
               this._nSkin = !_loc2_[3]?0:_global.parseInt(_loc2_[3]) - 1;
               this._bIsSkineable = true;
               break;
            case 971:
               this._nMood = !_loc2_[3]?0:_loc2_[3];
               break;
            case 970:
               this._sRealGfx = this._oUnicInfos.g;
               this._sGfx = this.api.lang.getItemUnicText(!_loc2_[3]?0:_loc2_[3]).g;
               this._nRealUnicId = _loc2_[3];
               break;
            case 983:
               this._bCanBeExchange = false;
         }
      }
   }
   static function getItemDescriptionEffects(aEffects, bVisibleOnly)
   {
      var _loc4_ = new Array();
      var _loc5_ = aEffects.length;
      if(typeof aEffects == "object")
      {
         var _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            var _loc7_ = aEffects[_loc6_];
            var _loc8_ = _loc7_[0];
            var _loc9_ = new dofus.datacenter.Effect(_loc8_,_loc7_[1],_loc7_[2],_loc7_[3],_loc7_[4]);
            if(_loc9_.description != undefined)
            {
               if(bVisibleOnly == true)
               {
                  if(_loc9_.showInTooltip)
                  {
                     _loc4_.push(_loc9_);
                  }
               }
               else
               {
                  _loc4_.push(_loc9_);
               }
            }
            _loc6_ = _loc6_ + 1;
         }
         return _loc4_;
      }
      return null;
   }
}
