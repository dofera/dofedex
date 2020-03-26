class dofus.graphics.gapi.controls.FightChallengeIcon extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   var displayUiOnClick = true;
   function FightChallengeIcon()
   {
      super();
   }
   function update()
   {
      switch(this.challenge.state)
      {
         case 1:
            this._ldrState.contentPath = "ChallengeOK";
            break;
         case 2:
            this._ldrState.contentPath = "ChallengeKO";
      }
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initCpt});
   }
   function initCpt()
   {
      this._ldr.contentPath = this.challenge.iconPath;
      this.update();
   }
   function addListeners()
   {
      if(this.displayUiOnClick)
      {
         this.onRelease = this.onEventRelease(this.api,this._parent,this,this.challenge);
      }
      this.onRollOver = this.virtualEvent(this,"over",this);
      this.onRollOut = this.virtualEvent(this,"out",this);
   }
   function onEventRelease(oApi, attachTarget, placer, challenge)
   {
      return function()
      {
         if(attachTarget.FightChallengeViewer.challenge === challenge)
         {
            (MovieClip)attachTarget.FightChallengeViewer.removeMovieClip();
         }
         else
         {
            (MovieClip)attachTarget.FightChallengeViewer.removeMovieClip();
            attachTarget.attachMovie("FightChallengeViewer","FightChallengeViewer",attachTarget.getNextHighestDepth(),{challenge:challenge});
         }
      };
   }
   function over(e)
   {
      var _loc3_ = this.api.lang.getFightChallenge(this.challenge.id);
      var _loc4_ = "<b>" + _loc3_.n + "</b>\n";
      _loc4_ = _loc4_ + (this.challenge.description + "\n");
      _loc4_ = _loc4_ + this.api.lang.getText("LOOT");
      _loc4_ = _loc4_ + (" : +" + (this.challenge.teamDropBonus + this.challenge.basicDropBonus) + "%\n");
      _loc4_ = _loc4_ + this.api.lang.getText("WORD_XP");
      _loc4_ = _loc4_ + (" : +" + (this.challenge.teamXpBonus + this.challenge.basicXpBonus) + "%\n");
      _loc4_ = _loc4_ + (this.api.lang.getText("STATE") + " : ");
      switch(this.challenge.state)
      {
         case 0:
            _loc4_ = _loc4_ + this.api.lang.getText("CURRENT_FIGHT_CHALLENGE");
            break;
         case 1:
            _loc4_ = _loc4_ + this.api.lang.getText("FIGHT_CHALLENGE_DONE");
            break;
         case 2:
            _loc4_ = _loc4_ + this.api.lang.getText("FIGHT_CHALLENGE_FAILED");
      }
      this.gapi.showTooltip(_loc4_,e.target,40);
   }
   function out(e)
   {
      this.gapi.hideTooltip();
   }
   function virtualEvent(context, callback, target)
   {
      return function()
      {
         context[callback]({target:target});
      };
   }
}
