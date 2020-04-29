class dofus.graphics.gapi.ui.GameResult extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GameResult";
	static var MAX_PLAYERS = 11;
	static var MAX_VISIBLE_PLAYERS_IN_TEAM = 6;
	function GameResult()
	{
		super();
	}
	function __set__data(var2)
	{
		this._oData = var2;
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
		var var2 = this._oData.winners.length;
		var var3 = this._oData.loosers.length;
		var var4 = this._oData.collectors.length;
		var var5 = var2 + var3 + var4;
		var var6 = Math.min(var2,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65 + Math.min(var3,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65;
		if(var4 > 0)
		{
			var6 = var6 + (Math.min(var4,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 65);
		}
		var var7 = var6 + 32;
		var var8 = ((var5 <= dofus.graphics.gapi.ui.GameResult.MAX_PLAYERS?this.gapi.screenHeight:550) - var7) / 2;
		var var9 = this._winBackground._x + 10;
		var var10 = var8 + 32;
		var var11 = Math.min(var2,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + var10;
		var var12 = Math.min(var3,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * 20 + 55 + var11;
		if((var var0 = this._oData.fightType) !== 0)
		{
			if(var0 === 1)
			{
				var var13 = "UI_GameResultTeamPVP";
			}
		}
		else
		{
			var13 = "UI_GameResultTeam";
		}
		this.attachMovie(var13,"_tWinners",10,{dataProvider:this._oData.winners,title:this.api.lang.getText("WINNERS"),_x:var9,_y:var10});
		this.attachMovie(var13,"_tLoosers",20,{dataProvider:this._oData.loosers,title:this.api.lang.getText("LOOSERS"),_x:var9,_y:var11});
		if(var4 > 0)
		{
			this.attachMovie(var13,"_tCollectors",30,{dataProvider:this._oData.collectors,title:this.api.lang.getText("GUILD_TAXCOLLECTORS"),_x:var9,_y:var12});
		}
		this._winBackground._y = var8;
		this._winBackground.setSize(undefined,var7);
		this._lblDuration._y = var8 + 5;
		this._btnClose._y = this._winBackground._y + this._winBackground._height;
		this._lblBonus._y = this._winBackground._y + 25;
		this._sdStars._y = this._winBackground._y + 30;
		if(this._oData.challenges && this._oData.challenges.length)
		{
			this._lblChallenges._y = this._lblBonus._y + 17;
			this._mcChallengesPlacer._y = this._lblBonus._y + 18;
			var var15 = 0;
			while(var15 < this._oData.challenges.length)
			{
				var var14 = (dofus.graphics.gapi.controls.FightChallengeIcon)this.attachMovie("FightChallengeIcon","fci" + var15,this.getNextHighestDepth(),{challenge:this._oData.challenges[var15],displayUiOnClick:false});
				var14._height = var0 = 17;
				var14._width = var0;
				var14._x = var15 * (var14._width + 5) + this._mcChallengesPlacer._x;
				var14._y = this._mcChallengesPlacer._y;
				var15 = var15 + 1;
			}
		}
	}
	function click(var2)
	{
		this.callClose();
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._sdStars)
		{
			this.gapi.showTooltip(this.api.lang.getText("GAME_RESULTS_BONUS_TOOLTIP",[this._sdStars.value]),this._sdStars,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
