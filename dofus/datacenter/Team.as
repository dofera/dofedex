class dofus.datacenter.Team extends ank.battlefield.datacenter.Sprite
{
	static var OPT_BLOCK_JOINER = "BlockJoiner";
	static var OPT_BLOCK_SPECTATOR = "BlockSpectator";
	static var OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER = "BlockJoinerExceptPartyMember";
	static var OPT_NEED_HELP = "NeedHelp";
	function Team(sID, §\x0f\x12§, §\x1e\x13\x14§, §\b\x18§, §\b\x06§, §\x1e\x1d\x06§, §\n\x03§)
	{
		super();
		this.initialize(sID,var4,var5,var6,var7,var8,var9);
	}
	function initialize(sID, §\x0f\x12§, §\x1e\x13\x14§, §\b\x18§, §\b\x06§, §\x1e\x1d\x06§, §\n\x03§)
	{
		super.initialize(sID,var4,var5,var6);
		this.color1 = var7;
		this._nType = Number(var8);
		this._oAlignment = new dofus.datacenter.(Number(var9));
		this._aPlayers = new Object();
		this.options = new Object();
	}
	function setChallenge(var2)
	{
		this._oChallenge = var2;
	}
	function addPlayer(var2)
	{
		this._aPlayers[var2.id] = var2;
	}
	function removePlayer(var2)
	{
		delete this._aPlayers.register2;
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
		var var2 = new String();
		for(var k in this._aPlayers)
		{
			var2 = var2 + ("\n" + this._aPlayers[k].name + "(" + this._aPlayers[k].level + ")");
		}
		return var2.substr(1);
	}
	function __get__totalLevel()
	{
		var var2 = 0;
		for(var k in this._aPlayers)
		{
			var2 = var2 + Number(this._aPlayers[k].level);
		}
		return var2;
	}
	function __get__count()
	{
		var var2 = 0;
		for(var k in this._aPlayers)
		{
			var2 = var2 + 1;
		}
		return var2;
	}
	function __get__challenge()
	{
		return this._oChallenge;
	}
	function __get__enemyTeam()
	{
		var var2 = this._oChallenge.teams;
		for(var k in var2)
		{
			if(k != this.id)
			{
				var var3 = k;
				break;
			}
		}
		return var2[var3];
	}
}
