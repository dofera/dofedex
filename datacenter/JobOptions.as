class dofus.datacenter.JobOptions extends Object
{
   function JobOptions(nParams, nMinSlot, nMaxSlot)
   {
      super();
      this._nParams = nParams;
      this._nMinSlot = nMinSlot <= 1?2:nMinSlot;
      this._nMaxSlot = nMaxSlot;
   }
   function __get__isNotFree()
   {
      return (this._nParams & 1) == 1;
   }
   function __get__isFreeIfFailed()
   {
      return (this._nParams & 2) == 2;
   }
   function __get__ressourcesNeeded()
   {
      return (this._nParams & 4) == 4;
   }
   function __get__minSlots()
   {
      return this._nMinSlot;
   }
   function __get__maxSlots()
   {
      return this._nMaxSlot;
   }
}
