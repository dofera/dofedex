class dofus.datacenter.TutorialWaitingCase extends Object
{
   static var CASE_TIMEOUT = "TIMEOUT";
   static var CASE_DEFAULT = "DEFAULT";
   function TutorialWaitingCase(sCode, aParams, mNextBlocID)
   {
      super();
      this._sCode = sCode;
      this._aParams = aParams;
      this._mNextBlocID = mNextBlocID;
   }
   function __get__code()
   {
      return this._sCode;
   }
   function __get__params()
   {
      return this._aParams;
   }
   function __get__nextBlocID()
   {
      return this._mNextBlocID;
   }
}
