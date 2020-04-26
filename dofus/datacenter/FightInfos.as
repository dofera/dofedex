class dofus.datacenter.FightInfos extends Object
{
	function FightInfos(loc3, loc4)
	{
		super();
		this.initialize(loc3,loc4);
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
		var loc2 = 0;
		for(var k in this._eaTeam1Players)
		{
			loc2 = loc2 + this._eaTeam1Players[k].level;
		}
		return loc2;
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
		var loc2 = 0;
		for(var k in this._eaTeam2Players)
		{
			loc2 = loc2 + this._eaTeam2Players[k].level;
		}
		return loc2;
	}
	function initialize(loc2, loc3)
	{
		this.api = _global.API;
		this._nID = loc2;
		this.duration = loc3;
	}
	function addTeam(§\x05\x1a§, §\x1e\x1d\b§, §\n\x04§, nCount)
	{
		switch(loc2)
		{
			case 1:
				this._nTeam1Type = loc3;
				this._nTeam1AlignmentIndex = loc4;
				this._nTeam1Count = nCount;
				break;
			case 2:
				this._nTeam2Type = loc3;
				this._nTeam2AlignmentIndex = loc4;
				this._nTeam2Count = nCount;
		}
	}
	function addPlayers(loc2, loc3)
	{
		switch(loc2)
		{
			case 1:
				this._eaTeam1Players = loc3;
				break;
			case 2:
				this._eaTeam2Players = loc3;
		}
	}
}
