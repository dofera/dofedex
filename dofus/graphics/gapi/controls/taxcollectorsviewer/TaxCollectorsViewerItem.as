class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerItem extends ank.gapi.core.UIBasicComponent
{
	function TaxCollectorsViewerItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		this._oItem.players.removeEventListener("modelChanged",this);
		this._oItem.attackers.removeEventListener("modelChanged",this);
		this._oItem = loc4;
		if(loc2)
		{
			this._lblName.text = loc4.name;
			this._lblPosition.text = loc4.position;
			this.showStateIcon();
			if(!_global.isNaN(loc4.timer))
			{
				var loc5 = loc4.timer - (getTimer() - loc4.timerReference);
				var loc6 = loc4.maxTimer / 1000;
				if(loc5 > 0)
				{
					this._vcTimer.startTimer(loc5 / 1000,loc6);
					this.showButtonsJoin(!_global.isNaN(loc4.maxPlayerCount)?loc4.maxPlayerCount:0);
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
			loc4.players.addEventListener("modelChanged",this);
			loc4.attackers.addEventListener("modelChanged",this);
			this._btnAttackers.enabled = true;
			this.updateAttackers();
			this.updatePlayers();
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblPosition.text = "";
			this._mcFight._visible = false;
			this._mcEnterFight._visible = false;
			this._mcCollect._visible = false;
			this._btnState._visible = false;
			this.hideButtonsJoin();
			this._vcTimer.stopTimer();
			this._btnAttackers.enabled = false;
			this._lblAttackersCount._visible = false;
		}
		else
		{
			this.hideButtonsJoin();
			this._vcTimer.stopTimer();
		}
	}
	function init()
	{
		super.init(false);
		this._mcFight._visible = false;
		this._mcEnterFight._visible = false;
		this._mcCollect._visible = false;
		this._btnState._visible = false;
		this._btnAttackers.enabled = false;
		this._lblAttackersCount._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this._btnPlayer0._visible = this._btnPlayer1._visible = this._btnPlayer2._visible = this._btnPlayer3._visible = this._btnPlayer4._visible = this._btnPlayer5._visible = this._btnPlayer6._visible = false;
	}
	function addListeners()
	{
		this._btnPlayer0.addEventListener("click",this);
		this._btnPlayer1.addEventListener("click",this);
		this._btnPlayer2.addEventListener("click",this);
		this._btnPlayer3.addEventListener("click",this);
		this._btnPlayer4.addEventListener("click",this);
		this._btnPlayer5.addEventListener("click",this);
		this._btnPlayer6.addEventListener("click",this);
		this._btnPlayer0.addEventListener("over",this);
		this._btnPlayer1.addEventListener("over",this);
		this._btnPlayer2.addEventListener("over",this);
		this._btnPlayer3.addEventListener("over",this);
		this._btnPlayer4.addEventListener("over",this);
		this._btnPlayer5.addEventListener("over",this);
		this._btnPlayer6.addEventListener("over",this);
		this._btnAttackers.addEventListener("over",this);
		this._btnState.addEventListener("over",this);
		this._btnPlayer0.addEventListener("out",this);
		this._btnPlayer1.addEventListener("out",this);
		this._btnPlayer2.addEventListener("out",this);
		this._btnPlayer3.addEventListener("out",this);
		this._btnPlayer4.addEventListener("out",this);
		this._btnPlayer5.addEventListener("out",this);
		this._btnPlayer6.addEventListener("out",this);
		this._btnAttackers.addEventListener("out",this);
		this._btnState.addEventListener("out",this);
		this._vcTimer.addEventListener("endTimer",this);
	}
	function showButtonsJoin(loc2)
	{
		this._mcBackButtons._visible = true;
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
	function hideButtonsJoin()
	{
		this._mcBackButtons._visible = false;
		var loc2 = 0;
		while(loc2 < 7)
		{
			this["_btnPlayer" + loc2]._visible = false;
			loc2 = loc2 + 1;
		}
	}
	function updatePlayers()
	{
		var loc2 = this._oItem.players;
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			var loc4 = this["_btnPlayer" + loc3];
			var loc5 = loc2[loc3];
			loc4.iconClip.data = loc5;
			loc4.params = {player:loc5};
			loc3 = loc3 + 1;
		}
		var loc6 = loc3;
		while(loc6 < 7)
		{
			var loc7 = this["_btnPlayer" + loc6];
			loc7.iconClip.data = null;
			loc7.params = new Object();
			loc6 = loc6 + 1;
		}
	}
	function updateAttackers()
	{
		this._lblAttackersCount._visible = true;
		if(this._oItem.state == 1)
		{
			var loc2 = this._oItem.attackers.length;
			this._lblAttackersCount.text = String(loc2);
			this._btnAttackers._visible = loc2 > 0;
		}
		else
		{
			this._lblAttackersCount.text = "-";
		}
	}
	function showStateIcon()
	{
		this._btnState._visible = true;
		this._mcFight._visible = this._oItem.state == 2;
		this._mcEnterFight._visible = this._oItem.state == 1;
		this._mcCollect._visible = this._oItem.state == 0;
	}
	function click(loc2)
	{
		var loc3 = this._mcList.gapi.api;
		if(loc3.datacenter.Player.cantInteractWithTaxCollector)
		{
			return undefined;
		}
		var loc4 = loc2.target.params.player;
		if(loc4 != undefined)
		{
			if(loc4.id == loc3.datacenter.Player.ID)
			{
				loc3.network.Guild.leaveTaxCollector(this._oItem.id);
			}
		}
		else
		{
			var loc5 = loc3.datacenter.Player.guildInfos;
			if(loc5.isLocalPlayerDefender)
			{
				if(loc5.defendedTaxCollectorID != this._oItem.id)
				{
					loc3.network.Guild.leaveTaxCollector(loc5.defendedTaxCollectorID);
					loc3.network.Guild.joinTaxCollector(this._oItem.id);
				}
			}
			else
			{
				loc3.network.Guild.joinTaxCollector(this._oItem.id);
			}
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnAttackers":
				if(!this._lblAttackersCount._visible)
				{
					return undefined;
				}
				var loc3 = this._oItem.attackers.length;
				if(loc3 == 0)
				{
					return undefined;
				}
				var loc4 = new String();
				var loc5 = 0;
				while(loc5 < loc3)
				{
					var loc6 = this._oItem.attackers[loc5];
					loc4 = loc4 + ("\n" + loc6.name + " (" + loc6.level + ")");
					loc5 = loc5 + 1;
				}
				this._mcList.gapi.showTooltip(this._mcList.gapi.api.lang.getText("ATTACKERS") + " : " + loc4,loc2.target,40);
				break;
			case "_btnState":
				var loc7 = new String();
				switch(this._oItem.state)
				{
					case 0:
						loc7 = this._mcList.gapi.api.lang.getText("TAX_IN_COLLECT");
						break;
					case 1:
						loc7 = this._mcList.gapi.api.lang.getText("TAX_IN_ENTERFIGHT");
						break;
					case 2:
						loc7 = this._mcList.gapi.api.lang.getText("TAX_IN_FIGHT");
				}
				if(this._oItem.showMoreInfo)
				{
					if(this._oItem.callerName != "?")
					{
						loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("OWNER_WORD") + " : " + this._oItem.callerName);
					}
					var loc8 = new Date(this._oItem.startDate);
					if(loc8.getFullYear() != 1970)
					{
						loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_START_DATE",[loc8.getDay(),loc8.getMonth() + 1,loc8.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z,loc8.getHours(),loc8.getMinutes()]));
					}
					if(this._oItem.lastHarvesterName != "?")
					{
						loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("LAST_HARVESTER_NAME") + " : " + this._oItem.lastHarvesterName);
					}
					loc8 = new Date(this._oItem.lastHarvestDate);
					if(loc8.getFullYear() != 1970)
					{
						loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_LAST_DATE",[loc8.getDay(),loc8.getMonth() + 1,loc8.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z,loc8.getHours(),loc8.getMinutes()]));
					}
					var loc9 = new Date();
					var loc10 = this._oItem.nextHarvestDate - loc9.valueOf();
					if(loc10 <= 0)
					{
						loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST"));
					}
					else
					{
						var loc11 = Math.floor(loc10 / 1000 / 60 / 60);
						var loc12 = Math.floor(loc10 / 1000 / 60 - loc11 * 60);
						var loc13 = loc11 + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("HOURS"),"m",loc11 == 1);
						if(loc12 == 0)
						{
							loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN",[loc13,""]));
						}
						else
						{
							var loc14 = this._mcList.gapi.api.lang.getText("AND") + " ";
							var loc15 = loc12 + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("MINUTES"),"m",loc12 == 1);
							loc7 = loc7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN",[loc13,loc14 + loc15]));
						}
					}
				}
				this._mcList.gapi.showTooltip(loc7,loc2.target,40);
				break;
			default:
				var loc16 = loc2.target.params.player;
				if(loc16 != undefined)
				{
					this._mcList.gapi.showTooltip(loc16.name + " (" + loc16.level + ")",loc2.target,-20);
					break;
				}
		}
	}
	function out(loc2)
	{
		this._mcList.gapi.hideTooltip();
	}
	function endTimer(loc2)
	{
		this._vcTimer.stopTimer();
		this.showButtonsJoin(0);
		this._oItem.state = 2;
		this.showStateIcon();
		this.updateAttackers();
		this._mcList.gapi.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
	}
	function modelChanged(loc2)
	{
		this._mcList.gapi.hideTooltip();
		this.updateAttackers();
		this.updatePlayers();
	}
}
