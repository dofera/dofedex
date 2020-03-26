class dofus.datacenter.TutorialAction extends dofus.datacenter.TutorialBloc
{
   function TutorialAction(sID, sActionCode, aParams, mNextBlocID, bKeepLastWaitingBloc)
   {
      super(sID,dofus.datacenter.TutorialBloc.TYPE_ACTION);
      this._sActionCode = sActionCode;
      this._aParams = aParams;
      this._mNextBlocID = mNextBlocID;
      this._bKeepLastWaitingBloc = bKeepLastWaitingBloc;
   }
   function __get__actionCode()
   {
      return this._sActionCode;
   }
   function __get__params()
   {
      return this._aParams;
   }
   function __get__nextBlocID()
   {
      return this._mNextBlocID;
   }
   function __get__keepLastWaitingBloc()
   {
      return this._bKeepLastWaitingBloc == true;
   }
}
