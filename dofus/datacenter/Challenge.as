class dofus.datacenter.Challenge extends Object
{
	function Challenge(loc3, loc4)
	{
		super();
		this.initialize(loc3,loc4);
	}
	function initialize(loc2, loc3)
	{
		this._nID = loc2;
		this._nFightType = loc3;
		this._teams = new Object();
	}
	function addTeam(loc2)
	{
		this._teams[loc2.id] = loc2;
		loc2.setChallenge(this);
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
		var loc2 = 0;
		for(var k in this._teams)
		{
			loc2 = loc2 + this._teams[k].count;
		}
		return loc2;
	}
}
