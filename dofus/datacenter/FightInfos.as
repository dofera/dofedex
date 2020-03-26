class dofus.datacenter.FightInfos extends Object
{
   function FightInfos(nID, nDuration)
   {
      super();
      this.initialize(nID,nDuration);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__durationString()
   {
      return this.api.kernel.GameManager.getDurationString(this.duration);
   }
   function __get__hasTeamPlayers()
   {
      return this._eaTeam1Players != undefined && this._eaTeam2Players != undefined;
   }
   function __get__team1IconFile()
   {
      return dofus.Constants.getTeamFileFromType(this._nTeam1Type,this._nTeam1AlignmentIndex);
   }
   function __get__team1Count()
   {
      return this._nTeam1Count;
   }
   function __get__team1Players()
   {
      return this._eaTeam1Players;
   }
   function __get__team1Level()
   {
      var _loc2_ = 0;
      for(var k in this._eaTeam1Players)
      {
         _loc2_ = _loc2_ + this._eaTeam1Players[k].level;
      }
      return _loc2_;
   }
   function __get__team2IconFile()
   {
      return dofus.Constants.getTeamFileFromType(this._nTeam2Type,this._nTeam2AlignmentIndex);
   }
   function __get__team2Count()
   {
      return this._nTeam2Count;
   }
   function __get__team2Players()
   {
      return this._eaTeam2Players;
   }
   function __get__team2Level()
   {
      var _loc2_ = 0;
      for(var k in this._eaTeam2Players)
      {
         _loc2_ = _loc2_ + this._eaTeam2Players[k].level;
      }
      return _loc2_;
   }
   function initialize(nID, nDuration)
   {
      this.api = _global.API;
      this._nID = nID;
      this.duration = nDuration;
   }
   function addTeam(nIndex, nType, nAlignmentIndex, nCount)
   {
      switch(nIndex)
      {
         case 1:
            this._nTeam1Type = nType;
            this._nTeam1AlignmentIndex = nAlignmentIndex;
            this._nTeam1Count = nCount;
            break;
         case 2:
            this._nTeam2Type = nType;
            this._nTeam2AlignmentIndex = nAlignmentIndex;
            this._nTeam2Count = nCount;
      }
   }
   function addPlayers(nIndex, eaPlayers)
   {
      switch(nIndex)
      {
         case 1:
            this._eaTeam1Players = eaPlayers;
            break;
         case 2:
            this._eaTeam2Players = eaPlayers;
      }
   }
}
