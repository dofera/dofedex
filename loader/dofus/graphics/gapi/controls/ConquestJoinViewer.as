class dofus.graphics.gapi.controls.ConquestJoinViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ConquestJoinViewer";
	static var TEAM_COUNT = 7;
	static var RESERVIST_COUNT = 35;
	var _nTimer = -1;
	var _nMaxTimer = -1;
	var _nTimerReference = -1;
	function ConquestJoinViewer()
	{
		super();
	}
	function __set__error(var2)
	{
		if(var2 != 0 && this._lblJoinFightDetails.text == undefined)
		{
			return undefined;
		}
		switch(Number(var2))
		{
			case 0:
				this._lblJoinFightDetails._visible = var0 = false;
				this._lblJoinFight._visible = var0;
				this._mcErrorBackground._visible = var0;
				break;
			case -1:
				this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_NOFIGHT");
				this._lblJoinFightDetails._visible = var0 = true;
				this._lblJoinFight._visible = var0;
				this._mcErrorBackground._visible = var0;
				this._bNoUnsubscribe = true;
				break;
			case -2:
				this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_INFIGHT");
				this._lblJoinFightDetails._visible = var0 = true;
				this._lblJoinFight._visible = var0;
				this._mcErrorBackground._visible = var0;
				this._bNoUnsubscribe = true;
				break;
			case -3:
				this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_NONE");
				this._lblJoinFightDetails._visible = var0 = true;
				this._lblJoinFight._visible = var0;
				this._mcErrorBackground._visible = var0;
				this._bNoUnsubscribe = true;
		}
		return this.__get__error();
	}
	function __set__timer(var2)
	{
		this._nTimer = var2;
		this.updateTimer();
		return this.__get__timer();
	}
	function __set__maxTimer(var2)
	{
		this._nMaxTimer = var2;
		this.updateTimer();
		return this.__get__maxTimer();
	}
	function __set__timerReference(var2)
	{
		this._nTimerReference = var2;
		this.updateTimer();
		return this.__get__timerReference();
	}
	function __set__maxTeamPositions(var2)
	{
		this._nMaxPlayerCount = var2;
		this.showButtonsJoin(var2);
		return this.__get__maxTeamPositions();
	}
	function __set__noUnsubscribe(var2)
	{
		this._bNoUnsubscribe = var2;
		return this.__get__noUnsubscribe();
	}
	function __get__noUnsubscribe()
	{
		return this._bNoUnsubscribe;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ConquestJoinViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		var var2 = 0;
		while(var2 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
		{
			this._btnPlayer._visible = false;
			var2 = var2 + 1;
		}
		var var3 = 0;
		while(var3 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
		{
			this._btnReservist._visible = false;
			var3 = var3 + 1;
		}
	}
	function addListeners()
	{
		this.api.datacenter.Conquest.players.removeEventListener("modelChanged",this);
		this.api.datacenter.Conquest.attackers.removeEventListener("modelChanged",this);
		var var2 = 0;
		while(var2 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
		{
			var var3 = (ank.gapi.controls.Button)this["_btnPlayer" + var2];
			var3.addEventListener("click",this);
			var3.addEventListener("over",this);
			var3.addEventListener("out",this);
			var2 = var2 + 1;
		}
		var var4 = 0;
		while(var4 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
		{
			var var5 = (ank.gapi.controls.Button)this["_btnReservist" + var4];
			var5.addEventListener("click",this);
			var5.addEventListener("over",this);
			var5.addEventListener("out",this);
			var4 = var4 + 1;
		}
		this._btnAttackers.addEventListener("over",this);
		this._btnAttackers.addEventListener("out",this);
		this.api.datacenter.Conquest.players.addEventListener("modelChanged",this);
		this.api.datacenter.Conquest.attackers.addEventListener("modelChanged",this);
		this._vcTimer.addEventListener("endTimer",this);
	}
	function initTexts()
	{
		this._lblTeam.text = this.api.lang.getText("CONQUEST_JOIN_FIGHTERS");
		this._lblReservists.text = this.api.lang.getText("CONQUEST_JOIN_RESERVISTS");
		this._lblJoinFight.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT");
		this._lblJoinFightDetails.text = this.api.lang.getText("LOADING");
	}
	function updatePlayers()
	{
		var var2 = this.api.datacenter.Conquest.players;
		var var3 = 0;
		var var4 = 0;
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2[var5];
			var var7 = null;
			if(var6.reservist)
			{
				var4;
				var7 = this["_btnReservist" + var4++];
			}
			else
			{
				var3;
				var7 = this["_btnPlayer" + var3++];
			}
			var7.iconClip.data = var6;
			var7.params = {player:var6};
			var5 = var5 + 1;
		}
		var var8 = var3;
		while(var8 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
		{
			var var9 = this["_btnPlayer" + var8];
			var9.iconClip.data = null;
			var9.params = new Object();
			var8 = var8 + 1;
		}
		var var10 = var4;
		while(var10 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
		{
			var var11 = this["_btnReservist" + var10];
			var11.iconClip.data = null;
			var11.params = new Object();
			var10 = var10 + 1;
		}
	}
	function updateAttackers()
	{
		this._lblAttackersCount._visible = true;
		this._lblAttackersTitle._visible = true;
		this._lblAttackersTitle.text = this.api.lang.getText("ATTACKERS");
		var var2 = this.api.datacenter.Conquest.attackers.length;
		this._lblAttackersCount.text = String(var2);
		this._btnAttackers._visible = var2 > 0;
	}
	function updateTimer()
	{
		if(!_global.isNaN(this._nTimer) && (this._nTimer > 0 && (!_global.isNaN(this._nMaxTimer) && (this._nMaxTimer > 0 && (!_global.isNaN(this._nTimerReference) && this._nTimerReference > 0)))))
		{
			var var2 = this._nTimer - (getTimer() - this._nTimerReference);
			var var3 = this._nMaxTimer / 1000;
			if(var2 > 0)
			{
				this._vcTimer.startTimer(var2 / 1000,var3);
				this.showButtonsJoin(!_global.isNaN(this._nMaxPlayerCount)?this._nMaxPlayerCount:0);
			}
			else
			{
				this._vcTimer.stopTimer();
				this.showButtonsJoin(0);
			}
		}
		else
		{
			this._vcTimer.stopTimer();
			this.showButtonsJoin(0);
		}
	}
	function showButtonsJoin(var2)
	{
		var var3 = 0;
		while(var3 < var2)
		{
			this["_btnPlayer" + var3]._visible = true;
			var3 = var3 + 1;
		}
		var var4 = var3;
		while(var4 < 7)
		{
			this["_btnPlayer" + var4]._visible = false;
			var4 = var4 + 1;
		}
	}
	function click(var2)
	{
		if(this.api.datacenter.Player.cantInteractWithPrism)
		{
			return undefined;
		}
		var var3 = var2.target.params.player;
		if(var3 != undefined)
		{
			if(var3.id == this.api.datacenter.Player.ID)
			{
				this.api.network.Conquest.prismFightLeave();
			}
			else
			{
				var var4 = this.api.datacenter.Conquest.players.findFirstItem("id",this.api.datacenter.Player.ID);
				if(var4.index == -1)
				{
					return undefined;
				}
				if(var3.reservist)
				{
					if(var4.item.reservist)
					{
						return undefined;
					}
					var var5 = this.api.ui.createPopupMenu();
					var5.addStaticItem(var3.name);
					var5.addItem(this.api.lang.getText("CONQUEST_SWITCH_AS_RESERVIST"),this.api.network.Conquest,this.api.network.Conquest.switchPlaces,[var3.id]);
					var5.show(_root._xmouse,_root._ymouse);
				}
				else if(var4.item.reservist)
				{
					var var6 = this.api.ui.createPopupMenu();
					var6.addStaticItem(var3.name);
					var6.addItem(this.api.lang.getText("CONQUEST_SWITCH_AS_PLAYER"),this.api.network.Conquest,this.api.network.Conquest.switchPlaces,[var3.id]);
					var6.show(_root._xmouse,_root._ymouse);
				}
				else
				{
					return undefined;
				}
			}
		}
		else
		{
			this.api.network.Conquest.prismFightJoin();
		}
	}
	function modelChanged(var2)
	{
		this.api.ui.hideTooltip();
		this.updateAttackers();
		this.updatePlayers();
	}
	function over(var2)
	{
		if((var var0 = var2.target) !== this._btnAttackers)
		{
			var var7 = var2.target.params.player;
			if(var7 != undefined)
			{
				this.api.ui.showTooltip(var7.name + " (" + var7.level + ")",var2.target,-20);
			}
		}
		else
		{
			if(!this._lblAttackersCount._visible)
			{
				return undefined;
			}
			var var3 = this.api.datacenter.Conquest.attackers.length;
			if(var3 == 0)
			{
				return undefined;
			}
			var var4 = new String();
			var var5 = 0;
			while(var5 < var3)
			{
				var var6 = this.api.datacenter.Conquest.attackers[var5];
				var4 = var4 + ("\n" + var6.name + " (" + var6.level + ")");
				var5 = var5 + 1;
			}
			this.api.ui.showTooltip(this.api.lang.getText("ATTACKERS") + " : " + var4,var2.target,40);
		}
	}
	function out(var2)
	{
		this.api.ui.hideTooltip();
	}
	function endTimer(var2)
	{
		this._vcTimer.stopTimer();
		this.showButtonsJoin(0);
		this.updateAttackers();
	}
}
