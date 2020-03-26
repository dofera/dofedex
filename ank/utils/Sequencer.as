class ank.utils.Sequencer extends Object
{
   var _nTimeModerator = 1;
   function Sequencer(timeout)
   {
      super();
      this.initialize(timeout);
   }
   function initialize(nTimeout)
   {
      this._nTimeout = nTimeout != undefined?nTimeout:10000;
      this._unicID = String(getTimer()) + random(10000);
      this._nActionIndex = 0;
      this.clear();
   }
   function clear(Void)
   {
      this._aActions = new Array();
      this._bPlaying = false;
      this._nTimeModerator = 1;
      ank.utils.Timer.removeTimer(this,"sequencer");
   }
   function setTimeModerator(nTimeModerator)
   {
      this._nTimeModerator = nTimeModerator;
   }
   function addAction(bWaitEnd, mRefObject, fFunction, aParams, nDuration)
   {
      var _loc7_ = new Object();
      _loc7_.id = this.getActionIndex();
      _loc7_.waitEnd = bWaitEnd;
      _loc7_.object = mRefObject;
      _loc7_.fn = fFunction;
      _loc7_.parameters = aParams;
      _loc7_.duration = nDuration;
      this._aActions.push(_loc7_);
   }
   function execute(bForced)
   {
      if(this._bPlaying && bForced == undefined)
      {
         return undefined;
      }
      this._bPlaying = true;
      var _loc3_ = true;
      while(_loc3_)
      {
         if(this._aActions.length > 0)
         {
            var _loc4_ = this._aActions[0];
            if(_loc4_.waitEnd)
            {
               _loc4_.object[this._unicID] = _loc4_.id;
            }
            _loc4_.fn.apply(_loc4_.object,_loc4_.parameters);
            if(!_loc4_.waitEnd)
            {
               this.onActionEnd(true);
            }
            else
            {
               _loc3_ = false;
               ank.utils.Timer.setTimer(_loc4_.object,"sequencer",this,this.onActionTimeOut,_loc4_.duration == undefined?this._nTimeout:_loc4_.duration * this._nTimeModerator,[_loc4_.id]);
            }
         }
         else
         {
            _loc3_ = false;
            this.stop();
         }
      }
   }
   function stop()
   {
      this._bPlaying = false;
   }
   function isPlaying()
   {
      return this._bPlaying;
   }
   function clearAllNextActions(Void)
   {
      this._aActions.splice(1);
      ank.utils.Timer.removeTimer(this,"sequencer");
   }
   function onActionTimeOut(nActionID)
   {
      if(nActionID != undefined && this._aActions[0].id != nActionID)
      {
         return undefined;
      }
      this.onActionEnd(false);
   }
   function onActionEnd(bDontCallExecute)
   {
      if(this._aActions.length == 0)
      {
         return undefined;
      }
      if(this._aActions[0].waitEnd)
      {
         ank.utils.Timer.removeTimer(this._aActions[0].object,"sequencer");
      }
      this._aActions.shift();
      if(this._aActions.length == 0)
      {
         this.clear();
         this.onSequenceEnd();
      }
      else if(bDontCallExecute != true)
      {
         if(this._bPlaying)
         {
            this.execute(true);
         }
      }
   }
   function toString()
   {
      return "Sequencer unicID:" + this._unicID + " playing:" + this._bPlaying + " actionsCount:" + this._aActions.length + " currentActionID:" + this._aActions[0].id + " currentActionObject:" + this._aActions[0].object;
   }
   function getActionIndex(Void)
   {
      this._nActionIndex = this._nActionIndex + 1;
      if(this._nActionIndex > 10000)
      {
         this._nActionIndex = 0;
      }
      return this._nActionIndex;
   }
}
