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
	function onEventRelease(§\x1e\x1a\f§, attachTarget, §\x1e\x16\x15§, challenge)
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
	function over(var2)
	{
		var var3 = this.api.lang.getFightChallenge(this.challenge.id);
		var var4 = "<b>" + var3.n + "</b>\n";
		var4 = var4 + (this.challenge.description + "\n");
		var4 = var4 + this.api.lang.getText("LOOT");
		var4 = var4 + (" : +" + (this.challenge.teamDropBonus + this.challenge.basicDropBonus) + "%\n");
		var4 = var4 + this.api.lang.getText("WORD_XP");
		var4 = var4 + (" : +" + (this.challenge.teamXpBonus + this.challenge.basicXpBonus) + "%\n");
		var4 = var4 + (this.api.lang.getText("STATE") + " : ");
		switch(this.challenge.state)
		{
			case 0:
				var4 = var4 + this.api.lang.getText("CURRENT_FIGHT_CHALLENGE");
				break;
			case 1:
				var4 = var4 + this.api.lang.getText("FIGHT_CHALLENGE_DONE");
				break;
			case 2:
				var4 = var4 + this.api.lang.getText("FIGHT_CHALLENGE_FAILED");
		}
		this.gapi.showTooltip(var4,var2.target,40);
	}
	function out(var2)
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
