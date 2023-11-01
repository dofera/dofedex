class dofus.datacenter.FightInfos extends Object
{
	function FightInfos(var3, var4)
	{
		super();
		this.initialize(var3,var4);
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
		var var2 = 0;
		var var3 = 0;
		while(var3 < this._eaTeam1Players.length)
		{
			var2 = var2 + this._eaTeam1Players[var3].level;
			var3 = var3 + 1;
		}
		return var2;
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
		var var2 = 0;
		var var3 = 0;
		while(var3 < this._eaTeam2Players.length)
		{
			var2 = var2 + this._eaTeam2Players[var3].level;
			var3 = var3 + 1;
		}
		return var2;
	}
	function initialize(var2, var3)
	{
		this.api = _global.API;
		this._nID = var2;
		this.duration = var3;
	}
	function addTeam(§\x04\n§, §\x1e\x1b\x13§, §\b\x1a§, nCount)
	{
		switch(var2)
		{
			case 1:
				this._nTeam1Type = var3;
				this._nTeam1AlignmentIndex = var4;
				this._nTeam1Count = nCount;
				break;
			case 2:
				this._nTeam2Type = var3;
				this._nTeam2AlignmentIndex = var4;
				this._nTeam2Count = nCount;
		}
	}
	function addPlayers(var2, var3)
	{
		switch(var2)
		{
			case 1:
				this._eaTeam1Players = var3;
				break;
			case 2:
				this._eaTeam2Players = var3;
		}
	}
}
