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
		this._eaPlayers = new ank.utils.();
		this._eaAttackers = new ank.utils.();
	}
	function __get__alignBonus()
	{
		return this._cbdAlignBonus;
	}
	function __set__alignBonus(loc2)
	{
		this._cbdAlignBonus = loc2;
		this.dispatchEvent({type:"bonusChanged"});
		return this.__get__alignBonus();
	}
	function __get__alignMalus()
	{
		return this._cbdAlignMalus;
	}
	function __set__alignMalus(loc2)
	{
		this._cbdAlignMalus = loc2;
		this.dispatchEvent({type:"bonusChanged"});
		return this.__get__alignMalus();
	}
	function __get__rankMultiplicator()
	{
		return this._cbdRankMultiplicator;
	}
	function __set__rankMultiplicator(loc2)
	{
		this._cbdRankMultiplicator = loc2;
		this.dispatchEvent({type:"bonusChanged"});
		return this.__get__rankMultiplicator();
	}
	function __get__players()
	{
		return this._eaPlayers;
	}
	function __set__players(loc2)
	{
		this._eaPlayers = loc2;
		return this.__get__players();
	}
	function __get__attackers()
	{
		return this._eaAttackers;
	}
	function __set__attackers(loc2)
	{
		this._eaAttackers = loc2;
		return this.__get__attackers();
	}
	function __get__worldDatas()
	{
		return this._cwdDatas;
	}
	function __set__worldDatas(loc2)
	{
		this._cwdDatas = loc2;
		this.dispatchEvent({type:"worldDataChanged",value:loc2});
		return this.__get__worldDatas();
	}
}
