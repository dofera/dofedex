class dofus.datacenter.TutorialWaiting extends dofus.datacenter.TutorialBloc
{
   function TutorialWaiting(sID, nTimeout, aCases)
   {
      super(sID,dofus.datacenter.TutorialBloc.TYPE_WAITING);
      this._nTimeout = nTimeout;
      this.setCases(aCases);
   }
   function __get__timeout()
   {
      return this._nTimeout != undefined?this._nTimeout:0;
   }
   function __get__cases()
   {
      return this._oCases;
   }
   function setCases(aCases)
   {
      this._oCases = new Object();
      var _loc3_ = 0;
      while(_loc3_ < aCases.length)
      {
         var _loc4_ = aCases[_loc3_];
         var _loc5_ = _loc4_[0];
         var _loc6_ = _loc4_[1];
         var _loc7_ = _loc4_[2];
         var _loc8_ = new dofus.datacenter.TutorialWaitingCase(_loc5_,_loc6_,_loc7_);
         this._oCases[_loc5_] = _loc8_;
         _loc3_ = _loc3_ + 1;
      }
   }
}
