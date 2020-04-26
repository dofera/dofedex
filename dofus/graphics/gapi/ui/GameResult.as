class dofus.graphics.gapi.ui.GameResult extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GameResult";
	static var MAX_PLAYERS = 11;
	static var MAX_VISIBLE_PLAYERS_IN_TEAM = 6;
	function GameResult()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		return this.__get__data();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.GameResult.CLASS_NAME);
		this._lblBonus._visible = false;
		this._sdStars._visible = false;
		this._lblChallenges._visible = false;
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.gapi.unloadLastUIAutoHideComponent();
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("GAME_RESULTS");
		this._lblDuration.text = this.api.kernel.GameManager.getDurationString(this._oData.duration,true);
		if(this.api.datacenter.Basics.aks_game_end_bonus != undefined && this.api.datacenter.Basics.aks_game_end_bonus > 0)
		{
			this._lblBonus._visible = true;
			this._sdStars._visible = true;
			this._lblBonus.text = this.api.lang.getText("GAME_RESULTS_BONUS") + " :";
			this._sdStars.value = this.api.datacenter.Basics.aks_game_end_bonus;
			this.api.datacenter.Basics.aks_game_end_bonus = -1;
		}
		if(this._oData.challenges && this._oData.challenges.length)
		{
			this._lblChallenges._visible = true;
			this._lblChallenges.text = this.api.lang.getText("FIGHT_CHALLENGE_BONUS") + " :";
		}
		this._btnClose.label = this.api.lang.getText("CLOSE");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._sdStars.addEventListener("over",this);
		this._sdStars.addEventListener("out",this);
	}
	function initData()
	{
		var loc2 = this._oData.winners.length;
		var loc3 = this._oData.loosers.length;
		var loc4 = this._oData.collectors.length;
		var loc5 = loc2 + loc3 + loc4;
		var loc6 = Math.min(loc2,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65 + Math.min(loc3,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65;
		if(loc4 > 0)
		{
			loc6 = loc6 + (Math.min(loc4,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65);
		}
		var loc7 = loc6 + 32;
		var loc8 = ((loc5 <= dofus.graphics.gapi.ui.GameResult.MAX_PLAYERS?this.gapi.screenHeight:550) - loc7) / 2;
		var loc9 = this._winBackground._x + 10;
		var loc10 = loc8 + 32;
		var loc11 = Math.min(loc2,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + loc10;
		var loc12 = Math.min(loc3,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + loc11;
		switch(this._oData.fightType)
		{
			case 0:
				var loc13 = "UI_GameResultTeam";
				break;
			case 1:
				loc13 = "UI_GameResultTeamPVP";
		}
		this.attachMovie(loc13,"_tWinners",10,{dataProvider:this._oData.winners,title:this.api.lang.getText("WINNERS"),_x:loc9,_y:loc10});
		this.attachMovie(loc13,"_tLoosers",20,{dataProvider:this._oData.loosers,title:this.api.lang.getText("LOOSERS"),_x:loc9,_y:loc11});
		if(loc4 > 0)
		{
			this.attachMovie(loc13,"_tCollectors",30,{dataProvider:this._oData.collectors,title:this.api.lang.getText("GUILD_TAXCOLLECTORS"),_x:loc9,_y:loc12});
		}
		this._winBackground._y = loc8;
		this._winBackground.setSize(undefined,loc7);
		this._lblDuration._y = loc8 + 5;
		this._btnClose._y = this._winBackground._y + this._winBackground._height;
		this._lblBonus._y = this._winBackground._y + 25;
		this._sdStars._y = this._winBackground._y + 30;
		if(this._oData.challenges && this._oData.challenges.length)
		{
			this._lblChallenges._y = this._lblBonus._y + 17;
			this._mcChallengesPlacer._y = this._lblBonus._y + 18;
			var loc15 = 0;
			while(loc15 < this._oData.challenges.length)
			{
				var loc14 = (dofus.graphics.gapi.controls.FightChallengeIcon)this.attachMovie("FightChallengeIcon","fci" + loc15,this.getNextHighestDepth(),{challenge:this._oData.challenges[loc15],displayUiOnClick:false});
				loc14._height = loc0 = 17;
				loc14._width = loc0;
				loc14._x = loc15 * (loc14._width + 5) + this._mcChallengesPlacer._x;
				loc14._y = this._mcChallengesPlacer._y;
				loc15 = loc15 + 1;
			}
		}
	}
	function click(loc2)
	{
		this.callClose();
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._sdStars)
		{
			this.gapi.showTooltip(this.api.lang.getText("GAME_RESULTS_BONUS_TOOLTIP",[this._sdStars.value]),this._sdStars,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
