class dofus.datacenter.TutorialIf extends dofus.datacenter.TutorialBloc
{
   function TutorialIf(sID, mLeft, sOperator, mRight, mNextBlocTrueID, mNextBlocFalseID)
   {
      super(sID,dofus.datacenter.TutorialBloc.TYPE_IF);
      this._mLeft = mLeft;
      this._sOperator = sOperator;
      this._mRight = mRight;
      this._mNextBlocTrueID = mNextBlocTrueID;
      this._mNextBlocFalseID = mNextBlocFalseID;
   }
   function __get__left()
   {
      return this._mLeft;
   }
   function __get__operator()
   {
      return this._sOperator;
   }
   function __get__right()
   {
      return this._mRight;
   }
   function __get__nextBlocTrueID()
   {
      return this._mNextBlocTrueID;
   }
   function __get__nextBlocFalseID()
   {
      return this._mNextBlocFalseID;
   }
}
