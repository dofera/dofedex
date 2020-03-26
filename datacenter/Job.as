class dofus.datacenter.Job extends Object
{
   function Job(nID, eaSkills, options)
   {
      super();
      this.initialize(nID,eaSkills,options);
   }
   function __set__options(o)
   {
      this._oOptions = o;
      this.dispatchEvent({type:"optionsChanged",value:o});
      return this.__get__options();
   }
   function __get__options()
   {
      return this._oOptions;
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__name()
   {
      return this._oJobText.n;
   }
   function __get__description()
   {
      return this._oJobText.d;
   }
   function __get__iconFile()
   {
      return dofus.Constants.JOBS_ICONS_PATH + this._oJobText.g + ".swf";
   }
   function __get__skills()
   {
      return this._eaSkills;
   }
   function __get__crafts()
   {
      return this._eaCrafts;
   }
   function __set__level(nLevel)
   {
      this._nLevel = nLevel;
      return this.__get__level();
   }
   function __get__level()
   {
      return this._nLevel;
   }
   function __set__xpMin(nXPmin)
   {
      this._nXPmin = nXPmin;
      return this.__get__xpMin();
   }
   function __get__xpMin()
   {
      return this._nXPmin;
   }
   function __set__xp(nXP)
   {
      this._nXP = nXP;
      return this.__get__xp();
   }
   function __get__xp()
   {
      return this._nXP;
   }
   function __set__xpMax(nXPmax)
   {
      this._nXPmax = nXPmax;
      return this.__get__xpMax();
   }
   function __get__xpMax()
   {
      return this._nXPmax <= Math.pow(10,17)?this._nXPmax:this._nXP;
   }
   function __get__specializationOf()
   {
      return this._oJobText.s;
   }
   function initialize(nID, eaSkills, options)
   {
      mx.events.EventDispatcher.initialize(this);
      this.api = _global.API;
      this._nID = nID;
      this._eaSkills = eaSkills;
      this._oOptions = options;
      this._oJobText = this.api.lang.getJobText(nID);
      if(!_global.isNaN(eaSkills.length))
      {
         this._eaCrafts = new ank.utils.ExtendedArray();
         var _loc5_ = new ank.utils.ExtendedArray();
         var _loc6_ = 0;
         while(_loc6_ < eaSkills.length)
         {
            var _loc7_ = _loc5_.findFirstItem("id",eaSkills[_loc6_].id);
            if(_loc7_.index == -1)
            {
               _loc5_.push(eaSkills[_loc6_]);
            }
            else if(_loc7_.item.param1 < eaSkills[_loc6_].param1)
            {
               _loc5_[_loc7_.index] = eaSkills[_loc6_];
            }
            _loc6_ = _loc6_ + 1;
         }
         var _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            var _loc9_ = _loc5_[_loc8_];
            var _loc10_ = _loc9_.craftsList;
            if(_loc10_ != undefined)
            {
               var _loc11_ = 0;
               while(_loc11_ < _loc10_.length)
               {
                  var _loc12_ = _loc10_[_loc11_];
                  var _loc13_ = new dofus.datacenter.Craft(_loc12_,_loc9_);
                  if(_loc13_.itemsCount <= _loc9_.param1)
                  {
                     this._eaCrafts.push(_loc13_);
                  }
                  _loc11_ = _loc11_ + 1;
               }
            }
            this._eaCrafts.sortOn("name");
            _loc8_ = _loc8_ + 1;
         }
      }
   }
   function getMaxSkillSlot()
   {
      var _loc2_ = -1;
      var _loc3_ = 0;
      while(_loc3_ < this._eaSkills.length)
      {
         var _loc4_ = this._eaSkills[_loc3_];
         if(_loc4_.param1 > _loc2_)
         {
            _loc2_ = _loc4_.param1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
}
