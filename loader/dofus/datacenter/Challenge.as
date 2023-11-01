class dofus.datacenter.Challenge extends Object
{
	function Challenge(var2, var3)
	{
		super();
		this.initialize(var3,var4);
	}
	function initialize(var2, var3)
	{
		this._nID = var2;
		this._nFightType = var3;
		this._teams = new Object();
	}
	function addTeam(var2)
	{
		this._teams[var2.id] = var2;
		var2.setChallenge(this);
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
		var var2 = 0;
		for(var k in this._teams)
		{
			var2 = var2 + this._teams[k].count;
		}
		return var2;
	}
}
