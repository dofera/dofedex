class dofus.datacenter.FightChallengeData extends Object
{
   function FightChallengeData(id, showTarget, targetId, basicXpBonus, teamXpBonus, basicDropBonus, teamDropBonus, state)
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
      this.id = id;
      this.showTarget = showTarget;
      this.targetId = targetId;
      this.basicXpBonus = basicXpBonus;
      this.teamXpBonus = teamXpBonus;
      this.basicDropBonus = basicDropBonus;
      this.teamDropBonus = teamDropBonus;
      var _loc11_ = (dofus.utils.Api)_global.API;
      var _loc12_ = _loc11_.datacenter.Sprites.getItemAt(targetId).name + " (" + _loc11_.lang.getText("LEVEL_SMALL") + " " + _loc11_.datacenter.Sprites.getItemAt(targetId).mc.data.Level + ")";
      this.description = _loc11_.lang.getFightChallenge(id).d.split("%1").join(_loc12_);
      this.iconPath = dofus.Constants.FIGHT_CHALLENGE_PATH + _loc11_.lang.getFightChallenge(id).g + ".swf";
   }
   function clone()
   {
      return new dofus.datacenter.FightChallengeData(this.id,this.showTarget,this.targetId,this.basicXpBonus,this.teamXpBonus,this.basicDropBonus,this.teamDropBonus,this.state);
   }
}
