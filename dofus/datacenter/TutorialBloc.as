class dofus.datacenter.TutorialBloc extends Object
{
   static var TYPE_ACTION = 0;
   static var TYPE_WAITING = 1;
   static var TYPE_IF = 2;
   function TutorialBloc(sID, nType)
   {
      super();
      this._sID = sID;
      this._nType = nType;
   }
   function __get__id()
   {
      return this._sID;
   }
   function __get__type()
   {
      return this._nType;
   }
}
