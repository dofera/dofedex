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
		var var2 = (dofus.utils.Api)this.api;
		var var3 = var2.lang.getFightChallenge(this.challenge.id);
		this._winBg.title = var2.lang.getText("CURRENT_FIGHT_CHALLENGE");
		if(this.challenge.targetId)
		{
			var var4 = var2.datacenter.Sprites.getItemAt(this.challenge.targetId).name + " (" + var2.lang.getText("LEVEL_SMALL") + " " + var2.datacenter.Sprites.getItemAt(this.challenge.targetId).mc.data.Level + ")";
			this._taDesc.text = var3.d.split("%1").join(var4);
		}
		else
		{
			this._taDesc.text = var3.d;
		}
		this._lblTitleDrop.text = var2.lang.getText("LOOT");
		this._lblTitleXp.text = var2.lang.getText("WORD_XP");
		this._lblTitle.text = var3.n;
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
	function click(var2)
	{
		switch(var2.target)
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
					break;
				}
		}
	}
	function over(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._btnView:
				this.gapi.showTooltip(this.api.lang.getText("VIEW_CHALENGE_TARGET"),var2.target,40);
				break;
			default:
				switch(null)
				{
					case this._lblTitleXp:
					case this._lblBonusDrop:
					case this._lblTitleDrop:
						this.gapi.showTooltip(this.api.lang.getText("BASIC_BONUS") + " : " + this.challenge.basicDropBonus + "%\n" + this.api.lang.getText("GROUP_BONUS") + " : " + this.challenge.teamDropBonus + "%",var2.target,40);
						break loop0;
					default:
						if(var0 !== this._mcState)
						{
							break loop0;
						}
						switch(this.challenge.state)
						{
							case 0:
								this.gapi.showTooltip(this.api.lang.getText("CURRENT_FIGHT_CHALLENGE"),var2.target,40);
								break;
							case 1:
								this.gapi.showTooltip(this.api.lang.getText("FIGHT_CHALLENGE_DONE"),var2.target,40);
								break;
							case 2:
								this.gapi.showTooltip(this.api.lang.getText("FIGHT_CHALLENGE_FAILED"),var2.target,40);
						}
						break loop0;
				}
			case this._lblBonusXp:
				this.gapi.showTooltip(this.api.lang.getText("BASIC_BONUS") + " : " + this.challenge.basicXpBonus + "%\n" + this.api.lang.getText("GROUP_BONUS") + " : " + this.challenge.teamXpBonus + "%",var2.target,40);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function change(var2)
	{
		this._lblTitle._y = this._lblTitle._y + (this._lblTitle.height - this._lblTitle.textHeight) / 2;
	}
}
