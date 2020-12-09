class dofus.graphics.gapi.ui.FightChallenge extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "FightChallenge";
	function FightChallenge()
	{
		super();
	}
	function __get__challenges()
	{
		return this._aChallengeList;
	}
	function addChallenge(§\x0f\x02§)
	{
		this._aChallengeList.push(var2);
		this.updateList();
	}
	function cleanChallenge()
	{
		var var2 = 0;
		while(var2 < this._aChallengeIcon.length)
		{
			(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[var2].unloadMovie();
			(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[var2].removeMovieClip();
			var2 = var2 + 1;
		}
		this._aChallengeIcon = new Array();
		this._aChallengeList = new ank.utils.
();
		this.FightChallengeViewer.unloadMovie();
		this._visible = false;
	}
	function updateChallenge(§\r\b§, §\x1e\f\x0e§)
	{
		var var4 = 0;
		while(var4 < this._aChallengeIcon.length)
		{
			if((dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[var4].challenge.id == var2)
			{
				(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[var4].challenge.state = !var3?2:1;
				(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[var4].update();
				this.FightChallengeViewer.update();
			}
			var4 = var4 + 1;
		}
		var var5 = 0;
		while(var5 < this._aChallengeList.length)
		{
			if((dofus.datacenter.FightChallengeData)this._aChallengeList[var5].id == var2)
			{
				this._aChallengeList[var5].state = !var3?2:1;
			}
			var5 = var5 + 1;
		}
	}
	function init()
	{
		this._aChallengeList = new ank.utils.
();
		super.init(false,dofus.graphics.gapi.ui.FightChallenge.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnOpenClose.addEventListener("click",this);
		this._btnOpenClose.addEventListener("over",this);
		this._btnOpenClose.addEventListener("out",this);
	}
	function updateList()
	{
		this._aChallengeIcon = new Array();
		this._visible = this._aChallengeList.length > 0;
		var var3 = 0;
		while(var3 < this._aChallengeList.length)
		{
			var var2 = (dofus.graphics.gapi.controls.FightChallengeIcon)this.attachMovie("FightChallengeIcon","FightChallengeIcon" + var3,var3 + 1,{challenge:this._aChallengeList[var3]});
			var2._x = this._btnOpenClose._x;
			var2._y = this._btnOpenClose._y + 15 + (6 + var2._height) * var3;
			var2.addEventListener("over",this);
			this._aChallengeIcon.push(var2);
			var2._visible = !this._btnOpenClose.selected;
			var3 = var3 + 1;
		}
	}
	function click(§\x10\x1a§)
	{
		var var3 = 0;
		while(var3 < this._aChallengeIcon.length)
		{
			this._aChallengeIcon[var3]._visible = !this._btnOpenClose.selected;
			var3 = var3 + 1;
		}
	}
	function over(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target) === this._btnOpenClose)
		{
			this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"),var2.target,20);
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
}
