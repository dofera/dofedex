class dofus.datacenter.CloseCombat extends Object
{
   function CloseCombat(oItem, nClassID)
   {
      super();
      this.initialize(oItem,nClassID);
   }
   function __get__ID()
   {
      return 0;
   }
   function __get__isValid()
   {
      return true;
   }
   function __get__maxLevel()
   {
      return 1;
   }
   function __get__position()
   {
      return 0;
   }
   function __get__item()
   {
      return this._oItem;
   }
   function __get__summonSpell()
   {
      return false;
   }
   function __get__glyphSpell()
   {
      return false;
   }
   function __get__trapSpell()
   {
      return false;
   }
   function __get__iconFile()
   {
      if(this._oItem == undefined)
      {
         return dofus.Constants.DEFAULT_CC_ICON_FILE;
      }
      return this._oItem.iconFile;
   }
   function __get__name()
   {
      return this.api.lang.getText("CC_DAMAGES");
   }
   function __get__apCost()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(2);
      }
      return this._oItem.apCost;
   }
   function __get__rangeMin()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(3);
      }
      return this._oItem.rangeMin;
   }
   function __get__rangeMax()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(4);
      }
      return this._oItem.rangeMax;
   }
   function __get__rangeStr()
   {
      return (this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax;
   }
   function __get__criticalHit()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(5);
      }
      return this._oItem.criticalHit;
   }
   function __get__criticalFailure()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(6);
      }
      return this._oItem.criticalFailure;
   }
   function __get__lineOnly()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(7);
      }
      return this._oItem.lineOnly;
   }
   function __get__lineOfSight()
   {
      if(this._oItem == undefined)
      {
         return this.getDefaultProperty(8);
      }
      return this._oItem.lineOfSight;
   }
   function __get__freeCell()
   {
      return false;
   }
   function __get__canBoostRange()
   {
      return false;
   }
   function __get__classID()
   {
      return -1;
   }
   function __get__launchCountByTurn()
   {
      return 0;
   }
   function __get__launchCountByPlayerTurn()
   {
      return 0;
   }
   function __get__delayBetweenLaunch()
   {
      return 0;
   }
   function __get__descriptionVisibleEffects()
   {
      if(this._oItem == undefined)
      {
         var _loc2_ = this.getDefaultProperty(0);
         return this.api.kernel.GameManager.getSpellDescriptionWithEffects(_loc2_,true,0);
      }
      var _loc3_ = this._oItem.visibleEffects;
      var _loc4_ = new Array();
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         _loc4_.push(_loc3_[_loc5_].description);
         _loc5_ = _loc5_ + 1;
      }
      return _loc4_.join(", ");
   }
   function __get__descriptionNormalHit()
   {
      if(this._oItem == undefined)
      {
         var _loc2_ = this.getDefaultProperty(0);
         return this.api.kernel.GameManager.getSpellDescriptionWithEffects(_loc2_,false,0);
      }
      var _loc3_ = this._oItem.normalHit;
      var _loc4_ = new Array();
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         _loc4_.push(_loc3_.description);
         _loc5_ = _loc5_ + 1;
      }
      return _loc4_.join(", ");
   }
   function __get__descriptionCriticalHit()
   {
      if(this._oItem == undefined)
      {
         var _loc2_ = this.getDefaultProperty(1);
      }
      else
      {
         _loc2_ = this._oItem.criticalHitBonus;
      }
      return this.api.kernel.GameManager.getSpellDescriptionWithEffects(_loc2_,false,0);
   }
   function __get__effectsNormalHit()
   {
      if(this._oItem == undefined)
      {
         var _loc2_ = this.getDefaultProperty(0);
      }
      else
      {
         _loc2_ = this._oItem.normalHit;
      }
      return this.api.kernel.GameManager.getSpellEffects(_loc2_,0);
   }
   function __get__effectsCriticalHit()
   {
      if(this._oItem == undefined)
      {
         var _loc2_ = this.getDefaultProperty(1);
      }
      else
      {
         _loc2_ = this._oItem.criticalHitBonus;
      }
      return this.api.kernel.GameManager.getSpellEffects(_loc2_,0);
   }
   function __get__elements()
   {
      var _loc2_ = {none:false,neutral:false,earth:false,fire:false,water:false,air:false};
      var _loc3_ = this.effectsNormalHit;
      for(var k in _loc3_)
      {
         var _loc4_ = _loc3_[k].element;
         switch(_loc4_)
         {
            case "N":
               _loc2_.neutral = true;
               break;
            case "E":
               _loc2_.earth = true;
               break;
            case "F":
               _loc2_.fire = true;
               break;
            case "W":
               _loc2_.water = true;
               break;
            case "A":
               _loc2_.air = true;
               break;
            default:
               _loc2_.none = true;
         }
      }
      return _loc2_;
   }
   function __get__effectZones()
   {
      return this._aEffectZones;
   }
   function __get__requiredStates()
   {
      return this._aRequiredStates;
   }
   function __get__forbiddenStates()
   {
      return this._aForbiddenStates;
   }
   function __get__needStates()
   {
      return this._aRequiredStates.length > 0 || this._aForbiddenStates.length > 0;
   }
   function initialize(oItem, nClassID)
   {
      this.api = _global.API;
      this._oItem = oItem;
      if(oItem == undefined)
      {
         this._oCloseCombatClassInfos = this.api.lang.getClassText(nClassID).cc;
      }
      var _loc4_ = this.api.lang.getItemTypeText(this._oItem.type).z;
      if(_loc4_ == undefined)
      {
         _loc4_ = "Pa";
      }
      var _loc5_ = _loc4_.split("");
      this._aEffectZones = new Array();
      var _loc6_ = 0;
      while(_loc6_ < _loc5_.length)
      {
         this._aEffectZones.push({shape:_loc5_[_loc6_],size:ank.utils.Compressor.decode64(_loc5_[_loc6_ + 1])});
         _loc6_ = _loc6_ + 2;
      }
      var _loc7_ = this.api.lang.getClassText(this.api.datacenter.Player.Guild).cc;
      this._aRequiredStates = _loc7_[9];
      this._aForbiddenStates = _loc7_[10];
   }
   function getDefaultProperty(nPropertyIndex)
   {
      return this._oCloseCombatClassInfos[nPropertyIndex];
   }
}
