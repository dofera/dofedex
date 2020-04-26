class dofus.datacenter.FightChallengeData extends Object
{
	function FightChallengeData(§\r\x1d§, showTarget, targetId, basicXpBonus, teamXpBonus, basicDropBonus, teamDropBonus, state)
	{
		super();
		if(_global.isNaN(state))
		{
			this.state = 0;
		}
		else
		{
			this.state = state;
		}
		this.id = loc3;
		this.showTarget = showTarget;
		this.targetId = targetId;
		this.basicXpBonus = basicXpBonus;
		this.teamXpBonus = teamXpBonus;
		this.basicDropBonus = basicDropBonus;
		this.teamDropBonus = teamDropBonus;
		var loc11 = (dofus.utils.Api)_global.API;
		var loc12 = loc11.datacenter.Sprites.getItemAt(targetId).name + " (" + loc11.lang.getText("LEVEL_SMALL") + " " + loc11.datacenter.Sprites.getItemAt(targetId).mc.data.Level + ")";
		this.description = loc11.lang.getFightChallenge(loc3).d.split("%1").join(loc12);
		this.iconPath = dofus.Constants.FIGHT_CHALLENGE_PATH + loc11.lang.getFightChallenge(loc3).g + ".swf";
	}
	function clone()
	{
		return new dofus.datacenter.(this.id,this.showTarget,this.targetId,this.basicXpBonus,this.teamXpBonus,this.basicDropBonus,this.teamDropBonus,this.state);
	}
}
