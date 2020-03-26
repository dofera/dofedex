class dofus.datacenter.Skill extends Object
{
   function Skill(nID, nParam1, nParam2, nParam3, nParam4)
   {
      super();
      this.initialize(nID,nParam1,nParam2,nParam3,nParam4);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__description()
   {
      return this._oSkillText.d;
   }
   function __get__job()
   {
      return this._oSkillText.j;
   }
   function __get__criterion()
   {
      return this._oSkillText.c;
   }
   function __get__item()
   {
      if(this._oSkillText.i == undefined)
      {
         return null;
      }
      return new dofus.datacenter.Item(0,this._oSkillText.i);
   }
   function __get__interactiveObject()
   {
      return this.api.lang.getInteractiveObjectDataText(this._oSkillText.io).n;
   }
   function __get__param1()
   {
      return this._nParam1;
   }
   function __get__param2()
   {
      return this._nParam2;
   }
   function __get__param3()
   {
      return this._nParam3;
   }
   function __get__param4()
   {
      return this._nParam4;
   }
   function __get__craftsList()
   {
      if(this._oCraftsList instanceof Array)
      {
         return this._oCraftsList;
      }
      this._oCraftsList = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this._oSkillText.cl.length)
      {
         var _loc3_ = this.api.lang.getItemUnicText(this._oSkillText.cl[_loc2_]).ep;
         if(_loc3_ <= this.api.datacenter.Basics.aks_current_regional_version && (_loc3_ != undefined && !_global.isNaN(_loc3_)))
         {
            this._oCraftsList.push(this._oSkillText.cl[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      return this._oCraftsList;
   }
   function initialize(nID, nParam1, nParam2, nParam3, nParam4)
   {
      this.api = _global.API;
      this._nID = nID;
      if(nParam1 != 0)
      {
         this._nParam1 = nParam1;
      }
      if(nParam2 != 0)
      {
         this._nParam2 = nParam2;
      }
      if(nParam3 != 0)
      {
         this._nParam3 = nParam3;
      }
      if(nParam4 != 0)
      {
         this._nParam4 = nParam4;
      }
      this._oSkillText = this.api.lang.getSkillText(nID);
      this.skillName = this.description;
   }
   function getState(bJob, bOwner, bForSale, bLocked, bIndoor, bNovice)
   {
      if(this.criterion == undefined || this.criterion.length == 0)
      {
         return "V";
      }
      var _loc8_ = this.criterion.split("?");
      var _loc9_ = _loc8_[0].split("&");
      var _loc10_ = _loc8_[1].split(":");
      var _loc11_ = _loc10_[0];
      var _loc12_ = _loc10_[1];
      var _loc13_ = 0;
      while(_loc13_ < _loc9_.length)
      {
         var _loc14_ = _loc9_[_loc13_];
         var _loc15_ = _loc14_.charAt(0) == "!";
         if(_loc15_)
         {
            _loc14_ = _loc14_.substr(1);
         }
         switch(_loc14_)
         {
            case "J":
               if(_loc15_)
               {
                  bJob = !bJob;
               }
               if(!bJob)
               {
                  return _loc12_;
               }
               break;
            case "O":
               if(_loc15_)
               {
                  bOwner = !bOwner;
               }
               if(!bOwner)
               {
                  return _loc12_;
               }
               break;
            case "S":
               if(_loc15_)
               {
                  bForSale = !bForSale;
               }
               if(!bForSale)
               {
                  return _loc12_;
               }
               break;
            case "L":
               if(_loc15_)
               {
                  bLocked = !bLocked;
               }
               if(!bLocked)
               {
                  return _loc12_;
               }
               break;
            case "I":
               if(_loc15_)
               {
                  bIndoor = !bIndoor;
               }
               if(!bIndoor)
               {
                  return _loc12_;
               }
               break;
            case "N":
               if(_loc15_)
               {
                  bNovice = !bNovice;
               }
               if(!bNovice)
               {
                  return _loc12_;
               }
               break;
         }
         _loc13_ = _loc13_ + 1;
      }
      return _loc11_;
   }
}
