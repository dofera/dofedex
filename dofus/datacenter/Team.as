class dofus.datacenter.Team extends ank.battlefield.datacenter.Sprite
{
	static var OPT_BLOCK_JOINER = "BlockJoiner";
	static var OPT_BLOCK_SPECTATOR = "BlockSpectator";
	static var OPT_BLOCK_JOINER_EXCEPT_PARTY_MEMBER = "BlockJoinerExceptPartyMember";
	static var OPT_NEED_HELP = "NeedHelp";
	function Team(sID, §\x0f\x14§, §\x1e\x13\x16§, §\b\x1a§, §\b\b§, §\x1e\x1d\b§, §\n\x05§)
	{
		super();
		this.initialize(sID,loc4,loc5,loc6,loc7,loc8,loc9);
	}
	function initialize(sID, §\x0f\x14§, §\x1e\x13\x16§, §\b\x1a§, §\b\b§, §\x1e\x1d\b§, §\n\x05§)
	{
		super.initialize(sID,loc4,loc5,loc6);
		this.color1 = loc7;
		this._nType = Number(loc8);
		this._oAlignment = new dofus.datacenter.(Number(loc9));
		this._aPlayers = new Object();
		this.options = new Object();
	}
	function setChallenge(loc2)
	{
		this._oChallenge = loc2;
	}
	function addPlayer(loc2)
	{
		this._aPlayers[loc2.id] = loc2;
	}
	function removePlayer(loc2)
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
		var loc2 = new String();
		for(var loc2 in this._aPlayers)
		{
		}
		return loc2.substr(1);
	}
	function __get__totalLevel()
	{
		var loc2 = 0;
		for(var k in this._aPlayers)
		{
			loc2 = loc2 + Number(this._aPlayers[k].level);
		}
		return loc2;
	}
	function __get__count()
	{
		var loc2 = 0;
		for(var loc2 in this._aPlayers)
		{
		}
		return loc2;
	}
	function __get__challenge()
	{
		return this._oChallenge;
	}
	function __get__enemyTeam()
	{
		var loc2 = this._oChallenge.teams;
		§§enumerate(loc2);
		while((var loc0 = §§enumeration()) != null)
		{
			if(k != this.id)
			{
				var loc3 = k;
				break;
			}
		}
		return loc2[loc3];
	}
}
