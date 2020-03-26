class dofus.managers.GameActionsManager extends dofus.utils.ApiElement
{
   static var STATE_TRANSMITTING = 2;
   static var STATE_IN_PROGRESS = 1;
   static var STATE_READY = 0;
   function GameActionsManager(d, oAPI)
   {
      super();
      this.initialize(d,oAPI);
   }
   function initialize(d, oAPI)
   {
      super.initialize(oAPI);
      this._data = d;
      this.clear();
   }
   function clear(Void)
   {
      this._id = undefined;
      this._bNextAction = false;
      this._state = dofus.managers.GameActionsManager.STATE_READY;
      this._currentType = null;
   }
   function transmittingMove(type, params)
   {
      if(!this.isWaiting())
      {
         this.api.network.GameActions.sendActions(type,params);
         this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
         this._currentType = type;
      }
      else if(this.canCancel(type))
      {
         this.cancel(this._data.lastCellNum);
         this.transmittingMove(type,params);
      }
      else
      {
         ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
      }
   }
   function transmittingOther(type, params)
   {
      if(!this.isWaiting())
      {
         this.api.network.GameActions.sendActions(type,params);
         this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
         this._currentType = type;
      }
      else
      {
         ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci " + type + " " + params);
      }
   }
   function onServerResponse(id)
   {
      this._id = id;
      this._state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
   }
   function cancel(params, bForceStatic)
   {
      this._currentType = null;
      if(this.canCancel())
      {
         this.api.network.GameActions.actionCancel(this._id,params);
         var _loc4_ = this._data.sequencer;
         var _loc5_ = this._data.mc;
         _loc4_.clearAllNextActions();
         if(bForceStatic == true)
         {
            _loc4_.addAction(false,_loc5_,_loc5_.setAnim,["Static"]);
         }
         this.clear();
      }
   }
   function end(bIAmSender)
   {
      if(this._bNextAction == false || !bIAmSender)
      {
         this.clear();
      }
      else
      {
         this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
         this._id = undefined;
      }
   }
   function ack(idAction)
   {
      this.api.network.GameActions.actionAck(idAction);
      this.end(true);
   }
   function isWaiting(Void)
   {
      switch(this._state)
      {
         case dofus.managers.GameActionsManager.STATE_READY:
            return false;
         case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
         case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
            return true;
         default:
            return false;
      }
   }
   function canCancel(type)
   {
      if(type != this._currentType)
      {
         return false;
      }
      if(this._id == undefined)
      {
         return false;
      }
      switch(this._state)
      {
         case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
            return false;
         case dofus.managers.GameActionsManager.STATE_READY:
         case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
            return true;
         default:
            return false;
      }
   }
}
