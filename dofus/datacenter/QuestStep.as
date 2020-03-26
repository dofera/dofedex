class dofus.datacenter.QuestStep extends Object
{
   function QuestStep(nID, nState, eaObjectives, aPreviousSteps, aNextSteps, nDialogID, aDialogParams)
   {
      super();
      this.initialize(nID,nState,eaObjectives,aPreviousSteps,aNextSteps,nDialogID,aDialogParams);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__name()
   {
      return this.api.lang.getQuestStepText(this._nID).n;
   }
   function __get__description()
   {
      return this.api.lang.getQuestStepText(this._nID).d;
   }
   function __get__objectives()
   {
      return this._eaObjectives;
   }
   function __get__allSteps()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = 0;
      while(_loc3_ < this._aPreviousSteps.length)
      {
         _loc2_.push(new dofus.datacenter.QuestStep(this._aPreviousSteps[_loc3_],2));
         _loc3_ = _loc3_ + 1;
      }
      _loc2_.push(this);
      var _loc4_ = 0;
      while(_loc4_ < this._aNextSteps.length)
      {
         _loc2_.push(new dofus.datacenter.QuestStep(this._aNextSteps[_loc4_],0));
         _loc4_ = _loc4_ + 1;
      }
      return _loc2_;
   }
   function __get__rewards()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = this.api.lang.getQuestStepText(this._nID).r;
      if(_loc3_[0] != undefined)
      {
         _loc2_.push({iconFile:"UI_QuestXP",label:_loc3_[0]});
      }
      if(_loc3_[1] != undefined)
      {
         _loc2_.push({iconFile:"UI_QuestKamaSymbol",label:_loc3_[1]});
      }
      if(_loc3_[2] != undefined)
      {
         var _loc4_ = _loc3_[2];
         var _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            var _loc6_ = Number(_loc4_[_loc5_][0]);
            var _loc7_ = _loc4_[_loc5_][1];
            var _loc8_ = new dofus.datacenter.Item(0,_loc6_,_loc7_);
            _loc2_.push({iconFile:_loc8_.iconFile,label:(_loc7_ == 0?"":"x" + _loc7_ + " ") + _loc8_.name});
            _loc5_ = _loc5_ + 1;
         }
      }
      if(_loc3_[3] != undefined)
      {
         var _loc9_ = _loc3_[3];
         var _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            var _loc11_ = Number(_loc9_[_loc10_]);
            _loc2_.push({iconFile:dofus.Constants.EMOTES_ICONS_PATH + _loc11_ + ".swf",label:this.api.lang.getEmoteText(_loc11_).n});
            _loc10_ = _loc10_ + 1;
         }
      }
      if(_loc3_[4] != undefined)
      {
         var _loc12_ = _loc3_[4];
         var _loc13_ = 0;
         while(_loc13_ < _loc12_.length)
         {
            var _loc14_ = Number(_loc12_[_loc13_]);
            var _loc15_ = new dofus.datacenter.Job(_loc14_);
            _loc2_.push({iconFile:_loc15_.iconFile,label:_loc15_.name});
            _loc13_ = _loc13_ + 1;
         }
      }
      if(_loc3_[5] != undefined)
      {
         var _loc16_ = _loc3_[5];
         var _loc17_ = 0;
         while(_loc17_ < _loc16_.length)
         {
            var _loc18_ = Number(_loc16_[_loc17_]);
            var _loc19_ = new dofus.datacenter.Spell(_loc18_,1);
            _loc2_.push({iconFile:_loc19_.iconFile,label:_loc19_.name});
            _loc17_ = _loc17_ + 1;
         }
      }
      return _loc2_;
   }
   function __get__dialogID()
   {
      return this._nDialogID;
   }
   function __get__dialogParams()
   {
      return this._aDialogParams;
   }
   function __get__isFinished()
   {
      return this._nState == 2;
   }
   function __get__isCurrent()
   {
      return this._nState == 1;
   }
   function __get__isNotDo()
   {
      return this._nState == 0;
   }
   function __get__hasPrevious()
   {
      return true;
   }
   function __get__hasNext()
   {
      return true;
   }
   function initialize(nID, nState, eaObjectives, aPreviousSteps, aNextSteps, nDialogID, aDialogParams)
   {
      this.api = _global.API;
      this._nID = nID;
      this._nState = nState;
      this._eaObjectives = eaObjectives;
      this._aPreviousSteps = aPreviousSteps;
      this._aNextSteps = aNextSteps;
      this._nDialogID = nDialogID;
      this._aDialogParams = aDialogParams;
   }
}
