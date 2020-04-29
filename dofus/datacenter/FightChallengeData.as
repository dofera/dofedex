class dofus.datacenter.FightChallengeData extends Object
{
	function FightChallengeData(§\r\x1b§, showTarget, targetId, basicXpBonus, teamXpBonus, basicDropBonus, teamDropBonus, state)
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
		this.id = var3;
		this.showTarget = showTarget;
		this.targetId = targetId;
		this.basicXpBonus = basicXpBonus;
		this.teamXpBonus = teamXpBonus;
		this.basicDropBonus = basicDropBonus;
		this.teamDropBonus = teamDropBonus;
		var var11 = (dofus.utils.Api)_global.API;
		var var12 = var11.datacenter.Sprites.getItemAt(targetId).name + " (" + var11.lang.getText("LEVEL_SMALL") + " " + var11.datacenter.Sprites.getItemAt(targetId).mc.data.Level + ")";
		this.description = var11.lang.getFightChallenge(var3).d.split("%1").join(var12);
		this.iconPath = dofus.Constants.FIGHT_CHALLENGE_PATH + var11.lang.getFightChallenge(var3).g + ".swf";
	}
	function clone()
	{
		return new dofus.datacenter.(this.id,this.showTarget,this.targetId,this.basicXpBonus,this.teamXpBonus,this.basicDropBonus,this.teamDropBonus,this.state);
	}
}
