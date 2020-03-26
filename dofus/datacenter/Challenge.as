class dofus.datacenter.Challenge extends Object
{
   function Challenge(nID, nFightType)
   {
      super();
      this.initialize(nID,nFightType);
   }
   function initialize(nID, nFightType)
   {
      this._nID = nID;
      this._nFightType = nFightType;
      this._teams = new Object();
   }
   function addTeam(t)
   {
      this._teams[t.id] = t;
      t.setChallenge(this);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__fightType()
   {
      return this._nFightType;
   }
   function __get__teams()
   {
      return this._teams;
   }
   function __get__count()
   {
      var _loc2_ = 0;
      for(var k in this._teams)
      {
         _loc2_ = _loc2_ + this._teams[k].count;
      }
      return _loc2_;
   }
}
