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
	function onEventRelease(§\x1e\x1b\x1c§, attachTarget, §\x1e\x18\n§, challenge)
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
	function over(loc2)
	{
		var loc3 = this.api.lang.getFightChallenge(this.challenge.id);
		var loc4 = "<b>" + loc3.n + "</b>\n";
		loc4 = loc4 + (this.challenge.description + "\n");
		loc4 = loc4 + this.api.lang.getText("LOOT");
		loc4 = loc4 + (" : +" + (this.challenge.teamDropBonus + this.challenge.basicDropBonus) + "%\n");
		loc4 = loc4 + this.api.lang.getText("WORD_XP");
		loc4 = loc4 + (" : +" + (this.challenge.teamXpBonus + this.challenge.basicXpBonus) + "%\n");
		loc4 = loc4 + (this.api.lang.getText("STATE") + " : ");
		if((var loc0 = this.challenge.state) !== 0)
		{
			switch(null)
			{
				case 1:
					loc4 = loc4 + this.api.lang.getText("FIGHT_CHALLENGE_DONE");
					break;
				case 2:
					loc4 = loc4 + this.api.lang.getText("FIGHT_CHALLENGE_FAILED");
			}
		}
		else
		{
			loc4 = loc4 + this.api.lang.getText("CURRENT_FIGHT_CHALLENGE");
		}
		this.gapi.showTooltip(loc4,loc2.target,40);
	}
	function out(loc2)
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
