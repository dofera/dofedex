class dofus.datacenter.Team extends ank.battlefield.datacenter.Sprite
{
   static var OPT_BLOCK_JOINER = "BlockJoiner";
   static var OPT_BLOCK_SPECTATOR = "BlockSpectator";
   static var OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER = "BlockJoinerExceptPartyMember";
   static var OPT_NEED_HELP = "NeedHelp";
   function Team(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
   {
      super();
      this.initialize(sID,fClipClass,sGfxFile,nCellNum,nColor1,nType,nAlignment);
   }
   function initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
   {
      super.initialize(sID,fClipClass,sGfxFile,nCellNum);
      this.color1 = nColor1;
      this._nType = Number(nType);
      this._oAlignment = new dofus.datacenter.Alignment(Number(nAlignment));
      this._aPlayers = new Object();
      this.options = new Object();
   }
   function setChallenge(oChallenge)
   {
      this._oChallenge = oChallenge;
   }
   function addPlayer(oPlayer)
   {
      this._aPlayers[oPlayer.id] = oPlayer;
   }
   function removePlayer(nID)
   {
      delete this._aPlayers.nID;
   }
   function __get__type()
   {
      return this._nType;
   }
   function __get__alignment()
   {
      return this._oAlignment;
   }
   function __get__name()
   {
      var _loc2_ = new String();
      for(var k in this._aPlayers)
      {
         _loc2_ = _loc2_ + ("\n" + this._aPlayers[k].name + "(" + this._aPlayers[k].level + ")");
      }
      return _loc2_.substr(1);
   }
   function __get__totalLevel()
   {
      var _loc2_ = 0;
      for(var k in this._aPlayers)
      {
         _loc2_ = _loc2_ + Number(this._aPlayers[k].level);
      }
      return _loc2_;
   }
   function __get__count()
   {
      var _loc2_ = 0;
      for(var k in this._aPlayers)
      {
         _loc2_ = _loc2_ + 1;
      }
      return _loc2_;
   }
   function __get__challenge()
   {
      return this._oChallenge;
   }
   function __get__enemyTeam()
   {
      var _loc2_ = this._oChallenge.teams;
      for(var k in _loc2_)
      {
         if(k != this.id)
         {
            var _loc3_ = k;
            break;
         }
      }
      return _loc2_[_loc3_];
   }
}
