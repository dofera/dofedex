class dofus.datacenter.LaunchedSpell
{
   function LaunchedSpell(nSpellID, sSpriteOnID)
   {
      this.initialize(nSpellID,sSpriteOnID);
   }
   function __set__remainingTurn(nRemainingTurn)
   {
      this._nRemainingTurn = Number(nRemainingTurn);
      return this.__get__remainingTurn();
   }
   function __get__remainingTurn()
   {
      return this._nRemainingTurn;
   }
   function __get__spriteOnID()
   {
      return this._sSpriteOnID;
   }
   function __get__spell()
   {
      return this._oSpell;
   }
   function initialize(nSpellID, sSpriteOnID)
   {
      this._oSpell = _global.API.datacenter.Player.Spells.findFirstItem("ID",nSpellID).item;
      this._sSpriteOnID = sSpriteOnID;
      var _loc4_ = this._oSpell.delayBetweenLaunch;
      if(_loc4_ == undefined)
      {
         _loc4_ = 0;
      }
      if(_loc4_ >= 63)
      {
         this._nRemainingTurn = Number.MAX_VALUE;
      }
      else
      {
         this._nRemainingTurn = _loc4_;
      }
   }
}
