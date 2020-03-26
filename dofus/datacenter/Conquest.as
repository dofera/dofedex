class dofus.datacenter.Conquest extends Object
{
   function Conquest()
   {
      super();
      this.clear();
      mx.events.EventDispatcher.initialize(this);
   }
   function clear()
   {
      this._eaPlayers = new ank.utils.ExtendedArray();
      this._eaAttackers = new ank.utils.ExtendedArray();
   }
   function __get__alignBonus()
   {
      return this._cbdAlignBonus;
   }
   function __set__alignBonus(cbd)
   {
      this._cbdAlignBonus = cbd;
      this.dispatchEvent({type:"bonusChanged"});
      return this.__get__alignBonus();
   }
   function __get__alignMalus()
   {
      return this._cbdAlignMalus;
   }
   function __set__alignMalus(cbd)
   {
      this._cbdAlignMalus = cbd;
      this.dispatchEvent({type:"bonusChanged"});
      return this.__get__alignMalus();
   }
   function __get__rankMultiplicator()
   {
      return this._cbdRankMultiplicator;
   }
   function __set__rankMultiplicator(cbd)
   {
      this._cbdRankMultiplicator = cbd;
      this.dispatchEvent({type:"bonusChanged"});
      return this.__get__rankMultiplicator();
   }
   function __get__players()
   {
      return this._eaPlayers;
   }
   function __set__players(value)
   {
      this._eaPlayers = value;
      return this.__get__players();
   }
   function __get__attackers()
   {
      return this._eaAttackers;
   }
   function __set__attackers(value)
   {
      this._eaAttackers = value;
      return this.__get__attackers();
   }
   function __get__worldDatas()
   {
      return this._cwdDatas;
   }
   function __set__worldDatas(value)
   {
      this._cwdDatas = value;
      this.dispatchEvent({type:"worldDataChanged",value:value});
      return this.__get__worldDatas();
   }
}
