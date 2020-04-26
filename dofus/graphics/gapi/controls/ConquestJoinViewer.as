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
	function __set__error(loc2)
	{
		if(loc2 != 0 && this._lblJoinFightDetails.text == undefined)
		{
			return undefined;
		}
		switch(Number(loc2))
		{
			case 0:
				this._lblJoinFightDetails._visible = loc0 = false;
				this._lblJoinFight._visible = loc0;
				this._mcErrorBackground._visible = loc0;
				break;
			case -1:
				this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_NOFIGHT");
				this._lblJoinFightDetails._visible = loc0 = true;
				this._lblJoinFight._visible = loc0;
				this._mcErrorBackground._visible = loc0;
				this._bNoUnsubscribe = true;
				break;
			default:
				switch(null)
				{
					case -2:
						this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_INFIGHT");
						this._lblJoinFightDetails._visible = loc0 = true;
						this._lblJoinFight._visible = loc0;
						this._mcErrorBackground._visible = loc0;
						this._bNoUnsubscribe = true;
						break;
					case -3:
						this._lblJoinFightDetails.text = this.api.lang.getText("CONQUEST_JOIN_FIGHT_NONE");
						this._lblJoinFightDetails._visible = loc0 = true;
						this._lblJoinFight._visible = loc0;
						this._mcErrorBackground._visible = loc0;
						this._bNoUnsubscribe = true;
				}
		}
		return this.__get__error();
	}
	function __set__timer(loc2)
	{
		this._nTimer = loc2;
		this.updateTimer();
		return this.__get__timer();
	}
	function __set__maxTimer(loc2)
	{
		this._nMaxTimer = loc2;
		this.updateTimer();
		return this.__get__maxTimer();
	}
	function __set__timerReference(loc2)
	{
		this._nTimerReference = loc2;
		this.updateTimer();
		return this.__get__timerReference();
	}
	function __set__maxTeamPositions(loc2)
	{
		this._nMaxPlayerCount = loc2;
		this.showButtonsJoin(loc2);
		return this.__get__maxTeamPositions();
	}
	function __set__noUnsubscribe(loc2)
	{
		this._bNoUnsubscribe = loc2;
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
		var loc2 = 0;
		while(loc2 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
		{
			this._btnPlayer._visible = false;
			loc2 = loc2 + 1;
		}
		var loc3 = 0;
		while(loc3 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
		{
			this._btnReservist._visible = false;
			loc3 = loc3 + 1;
		}
	}
	function addListeners()
	{
		this.api.datacenter.Conquest.players.removeEventListener("modelChanged",this);
		this.api.datacenter.Conquest.attackers.removeEventListener("modelChanged",this);
		var loc2 = 0;
		while(loc2 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
		{
			var loc3 = (ank.gapi.controls.Button)this["_btnPlayer" + loc2];
			loc3.addEventListener("click",this);
			loc3.addEventListener("over",this);
			loc3.addEventListener("out",this);
			loc2 = loc2 + 1;
		}
		var loc4 = 0;
		while(loc4 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
		{
			var loc5 = (ank.gapi.controls.Button)this["_btnReservist" + loc4];
			loc5.addEventListener("click",this);
			loc5.addEventListener("over",this);
			loc5.addEventListener("out",this);
			loc4 = loc4 + 1;
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
		var loc2 = this.api.datacenter.Conquest.players;
		var loc3 = 0;
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = loc2[loc5];
			var loc7 = null;
			if(loc6.reservist)
			{
				loc4;
				loc7 = this["_btnReservist" + loc4++];
			}
			else
			{
				loc3;
				loc7 = this["_btnPlayer" + loc3++];
			}
			loc7.iconClip.data = loc6;
			loc7.params = {player:loc6};
			loc5 = loc5 + 1;
		}
		var loc8 = loc3;
		while(loc8 < dofus.graphics.gapi.controls.ConquestJoinViewer.TEAM_COUNT)
		{
			var loc9 = this["_btnPlayer" + loc8];
			loc9.iconClip.data = null;
			loc9.params = new Object();
			loc8 = loc8 + 1;
		}
		var loc10 = loc4;
		while(loc10 < dofus.graphics.gapi.controls.ConquestJoinViewer.RESERVIST_COUNT)
		{
			var loc11 = this["_btnReservist" + loc10];
			loc11.iconClip.data = null;
			loc11.params = new Object();
			loc10 = loc10 + 1;
		}
	}
	function updateAttackers()
	{
		this._lblAttackersCount._visible = true;
		this._lblAttackersTitle._visible = true;
		this._lblAttackersTitle.text = this.api.lang.getText("ATTACKERS");
		var loc2 = this.api.datacenter.Conquest.attackers.length;
		this._lblAttackersCount.text = String(loc2);
		this._btnAttackers._visible = loc2 > 0;
	}
	function updateTimer()
	{
		if(!_global.isNaN(this._nTimer) && (this._nTimer > 0 && (!_global.isNaN(this._nMaxTimer) && (this._nMaxTimer > 0 && (!_global.isNaN(this._nTimerReference) && this._nTimerReference > 0)))))
		{
			var loc2 = this._nTimer - (getTimer() - this._nTimerReference);
			var loc3 = this._nMaxTimer / 1000;
			if(loc2 > 0)
			{
				this._vcTimer.startTimer(loc2 / 1000,loc3);
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
	function showButtonsJoin(loc2)
	{
		var loc3 = 0;
		while(loc3 < loc2)
		{
			this["_btnPlayer" + loc3]._visible = true;
			loc3 = loc3 + 1;
		}
		var loc4 = loc3;
		while(loc4 < 7)
		{
			this["_btnPlayer" + loc4]._visible = false;
			loc4 = loc4 + 1;
		}
	}
	function click(loc2)
	{
		if(this.api.datacenter.Player.cantInteractWithPrism)
		{
			return undefined;
		}
		var loc3 = loc2.target.params.player;
		if(loc3 != undefined)
		{
			if(loc3.id == this.api.datacenter.Player.ID)
			{
				this.api.network.Conquest.prismFightLeave();
			}
			else
			{
				var loc4 = this.api.datacenter.Conquest.players.findFirstItem("id",this.api.datacenter.Player.ID);
				if(loc4.index == -1)
				{
					return undefined;
				}
				if(loc3.reservist)
				{
					if(loc4.item.reservist)
					{
						return undefined;
					}
					var loc5 = this.api.ui.createPopupMenu();
					loc5.addStaticItem(loc3.name);
					loc5.addItem(this.api.lang.getText("CONQUEST_SWITCH_AS_RESERVIST"),this.api.network.Conquest,this.api.network.Conquest.switchPlaces,[loc3.id]);
					loc5.show(_root._xmouse,_root._ymouse);
				}
				else if(loc4.item.reservist)
				{
					var loc6 = this.api.ui.createPopupMenu();
					loc6.addStaticItem(loc3.name);
					loc6.addItem(this.api.lang.getText("CONQUEST_SWITCH_AS_PLAYER"),this.api.network.Conquest,this.api.network.Conquest.switchPlaces,[loc3.id]);
					loc6.show(_root._xmouse,_root._ymouse);
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
	function modelChanged(loc2)
	{
		this.api.ui.hideTooltip();
		this.updateAttackers();
		this.updatePlayers();
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) !== this._btnAttackers)
		{
			var loc7 = loc2.target.params.player;
			if(loc7 != undefined)
			{
				this.api.ui.showTooltip(loc7.name + " (" + loc7.level + ")",loc2.target,-20);
			}
		}
		else
		{
			if(!this._lblAttackersCount._visible)
			{
				return undefined;
			}
			var loc3 = this.api.datacenter.Conquest.attackers.length;
			if(loc3 == 0)
			{
				return undefined;
			}
			var loc4 = new String();
			var loc5 = 0;
			while(loc5 < loc3)
			{
				var loc6 = this.api.datacenter.Conquest.attackers[loc5];
				loc4 = loc4 + ("\n" + loc6.name + " (" + loc6.level + ")");
				loc5 = loc5 + 1;
			}
			this.api.ui.showTooltip(this.api.lang.getText("ATTACKERS") + " : " + loc4,loc2.target,40);
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
	function endTimer(loc2)
	{
		this._vcTimer.stopTimer();
		this.showButtonsJoin(0);
		this.updateAttackers();
	}
}
