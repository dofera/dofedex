class dofus.graphics.gapi.controls.FightChallengeViewer extends ank.gapi.core.UIAdvancedComponent
{
   var _lastShowAsk = 0;
   function FightChallengeViewer()
   {
      super();
   }
   function update()
   {
      this._mcState.gotoAndStop(this.challenge.state + 1);
   }
   function createChildren()
   {
      this._btnView._visible = this.challenge.showTarget;
      this.update();
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initText});
   }
   function initText()
   {
      var _loc2_ = (dofus.utils.Api)this.api;
      var _loc3_ = _loc2_.lang.getFightChallenge(this.challenge.id);
      this._winBg.title = _loc2_.lang.getText("CURRENT_FIGHT_CHALLENGE");
      if(this.challenge.targetId)
      {
         var _loc4_ = _loc2_.datacenter.Sprites.getItemAt(this.challenge.targetId).name + " (" + _loc2_.lang.getText("LEVEL_SMALL") + " " + _loc2_.datacenter.Sprites.getItemAt(this.challenge.targetId).mc.data.Level + ")";
         this._taDesc.text = _loc3_.d.split("%1").join(_loc4_);
      }
      else
      {
         this._taDesc.text = _loc3_.d;
      }
      this._lblTitleDrop.text = _loc2_.lang.getText("LOOT");
      this._lblTitleXp.text = _loc2_.lang.getText("WORD_XP");
      this._lblTitle.text = _loc3_.n;
      this._lblBonusDrop.text = "+" + (this.challenge.teamDropBonus + this.challenge.basicDropBonus) + "%";
      this._lblBonusXp.text = "+" + (this.challenge.teamXpBonus + this.challenge.basicXpBonus) + "%";
   }
   function addListeners()
   {
      this._lblTitle.addEventListener("change",this);
      this._btnClose.addEventListener("click",this);
      this._btnView.addEventListener("click",this);
      this._btnView.onRelease = this.virtualEvent(this,"click",this._btnView);
      this._btnView.onRollOver = this.virtualEvent(this,"over",this._btnView);
      this._btnView.onRollOut = this.virtualEvent(this,"out",this._btnView);
      this._mcState.onRollOver = this.virtualEvent(this,"over",this._mcState);
      this._mcState.onRollOut = this.virtualEvent(this,"out",this._mcState);
      this._lblBonusDrop.onRollOver = this.virtualEvent(this,"over",this._lblBonusDrop);
      this._lblBonusDrop.onRollOut = this.virtualEvent(this,"out",this._lblBonusDrop);
      this._lblTitleDrop.onRollOver = this.virtualEvent(this,"over",this._lblTitleDrop);
      this._lblTitleDrop.onRollOut = this.virtualEvent(this,"out",this._lblTitleDrop);
      this._lblBonusXp.onRollOver = this.virtualEvent(this,"over",this._lblBonusXp);
      this._lblBonusXp.onRollOut = this.virtualEvent(this,"out",this._lblBonusXp);
      this._lblTitleXp.onRollOver = this.virtualEvent(this,"over",this._lblTitleXp);
      this._lblTitleXp.onRollOut = this.virtualEvent(this,"out",this._lblTitleXp);
      this._taDesc.addEventListener("resize",this);
   }
   function virtualEvent(context, callback, target)
   {
      return function()
      {
         context[callback]({target:target});
      };
   }
   function click(e)
   {
      switch(e.target)
      {
         case this._btnClose:
            this.unloadMovie();
            break;
         case this._btnView:
            if(getTimer() - this._lastShowAsk >= 1000)
            {
               this.unloadMovie();
               (dofus.utils.Api)this.api.network.Game.showFightChallengeTarget(this.challenge.id);
               this._lastShowAsk = getTimer();
            }
      }
   }
   function over(e)
   {
      switch(e.target)
      {
         case this._btnView:
            this.gapi.showTooltip(this.api.lang.getText("VIEW_CHALENGE_TARGET"),e.target,40);
            break;
         case this._lblBonusXp:
         case this._lblTitleXp:
            this.gapi.showTooltip(this.api.lang.getText("BASIC_BONUS") + " : " + this.challenge.basicXpBonus + "%\n" + this.api.lang.getText("GROUP_BONUS") + " : " + this.challenge.teamXpBonus + "%",e.target,40);
            break;
         case this._lblBonusDrop:
         case this._lblTitleDrop:
            this.gapi.showTooltip(this.api.lang.getText("BASIC_BONUS") + " : " + this.challenge.basicDropBonus + "%\n" + this.api.lang.getText("GROUP_BONUS") + " : " + this.challenge.teamDropBonus + "%",e.target,40);
            break;
         case this._mcState:
            switch(this.challenge.state)
            {
               case 0:
                  this.gapi.showTooltip(this.api.lang.getText("CURRENT_FIGHT_CHALLENGE"),e.target,40);
                  break;
               case 1:
                  this.gapi.showTooltip(this.api.lang.getText("FIGHT_CHALLENGE_DONE"),e.target,40);
                  break;
               case 2:
                  this.gapi.showTooltip(this.api.lang.getText("FIGHT_CHALLENGE_FAILED"),e.target,40);
            }
      }
   }
   function out(e)
   {
      this.gapi.hideTooltip();
   }
   function change(e)
   {
      this._lblTitle._y = this._lblTitle._y + (this._lblTitle.height - this._lblTitle.textHeight) / 2;
   }
}
