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
	function addChallenge(loc2)
	{
		this._aChallengeList.push(loc2);
		this.updateList();
	}
	function cleanChallenge()
	{
		var loc2 = 0;
		while(loc2 < this._aChallengeIcon.length)
		{
			(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[loc2].unloadMovie();
			(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[loc2].removeMovieClip();
			loc2 = loc2 + 1;
		}
		this._aChallengeIcon = new Array();
		this._aChallengeList = new ank.utils.();
		this.FightChallengeViewer.unloadMovie();
		this._visible = false;
	}
	function updateChallenge(loc2, loc3)
	{
		var loc4 = 0;
		while(loc4 < this._aChallengeIcon.length)
		{
			if((dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[loc4].challenge.id == loc2)
			{
				(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[loc4].challenge.state = !loc3?2:1;
				(dofus.graphics.gapi.controls.FightChallengeIcon)this._aChallengeIcon[loc4].update();
				this.FightChallengeViewer.update();
			}
			loc4 = loc4 + 1;
		}
		var loc5 = 0;
		while(loc5 < this._aChallengeList.length)
		{
			if((dofus.datacenter.FightChallengeData)this._aChallengeList[loc5].id == loc2)
			{
				this._aChallengeList[loc5].state = !loc3?2:1;
			}
			loc5 = loc5 + 1;
		}
	}
	function init()
	{
		this._aChallengeList = new ank.utils.();
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
		var loc3 = 0;
		while(loc3 < this._aChallengeList.length)
		{
			var loc2 = (dofus.graphics.gapi.controls.FightChallengeIcon)this.attachMovie("FightChallengeIcon","FightChallengeIcon" + loc3,loc3 + 1,{challenge:this._aChallengeList[loc3]});
			loc2._x = this._btnOpenClose._x;
			loc2._y = this._btnOpenClose._y + 15 + (6 + loc2._height) * loc3;
			loc2.addEventListener("over",this);
			this._aChallengeIcon.push(loc2);
			loc2._visible = !this._btnOpenClose.selected;
			loc3 = loc3 + 1;
		}
	}
	function click(loc2)
	{
		var loc3 = 0;
		while(loc3 < this._aChallengeIcon.length)
		{
			this._aChallengeIcon[loc3]._visible = !this._btnOpenClose.selected;
			loc3 = loc3 + 1;
		}
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._btnOpenClose)
		{
			this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"),loc2.target,20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
