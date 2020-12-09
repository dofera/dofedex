class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerItem extends ank.gapi.core.UIBasicComponent
{
	function TaxCollectorsViewerItem()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		this._oItem.players.removeEventListener("modelChanged",this);
		this._oItem.attackers.removeEventListener("modelChanged",this);
		this._oItem = var4;
		if(var2)
		{
			this._lblName.text = var4.name;
			this._lblPosition.text = var4.position;
			this.showStateIcon();
			if(!_global.isNaN(var4.timer))
			{
				var var5 = var4.timer - (getTimer() - var4.timerReference);
				var var6 = var4.maxTimer / 1000;
				if(var5 > 0)
				{
					this._vcTimer.startTimer(var5 / 1000,var6);
					this.showButtonsJoin(!_global.isNaN(var4.maxPlayerCount)?var4.maxPlayerCount:0);
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
			var4.players.addEventListener("modelChanged",this);
			var4.attackers.addEventListener("modelChanged",this);
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
	function showButtonsJoin(§\x01\x1c§)
	{
		this._mcBackButtons._visible = true;
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
	function hideButtonsJoin()
	{
		this._mcBackButtons._visible = false;
		var var2 = 0;
		while(var2 < 7)
		{
			this["_btnPlayer" + var2]._visible = false;
			var2 = var2 + 1;
		}
	}
	function updatePlayers()
	{
		var var2 = this._oItem.players;
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = this["_btnPlayer" + var3];
			var var5 = var2[var3];
			var4.iconClip.data = var5;
			var4.params = {player:var5};
			var3 = var3 + 1;
		}
		var var6 = var3;
		while(var6 < 7)
		{
			var var7 = this["_btnPlayer" + var6];
			var7.iconClip.data = null;
			var7.params = new Object();
			var6 = var6 + 1;
		}
	}
	function updateAttackers()
	{
		this._lblAttackersCount._visible = true;
		if(this._oItem.state == 1)
		{
			var var2 = this._oItem.attackers.length;
			this._lblAttackersCount.text = String(var2);
			this._btnAttackers._visible = var2 > 0;
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
	function click(§\x1e\x19\x18§)
	{
		var var3 = this._mcList.gapi.api;
		if(var3.datacenter.Player.cantInteractWithTaxCollector)
		{
			return undefined;
		}
		var var4 = var2.target.params.player;
		if(var4 != undefined)
		{
			if(var4.id == var3.datacenter.Player.ID)
			{
				var3.network.Guild.leaveTaxCollector(this._oItem.id);
			}
		}
		else
		{
			var var5 = var3.datacenter.Player.guildInfos;
			if(var5.isLocalPlayerDefender)
			{
				if(var5.defendedTaxCollectorID != this._oItem.id)
				{
					var3.network.Guild.leaveTaxCollector(var5.defendedTaxCollectorID);
					var3.network.Guild.joinTaxCollector(this._oItem.id);
				}
			}
			else
			{
				var3.network.Guild.joinTaxCollector(this._oItem.id);
			}
		}
	}
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnAttackers":
				if(!this._lblAttackersCount._visible)
				{
					return undefined;
				}
				var var3 = this._oItem.attackers.length;
				if(var3 == 0)
				{
					return undefined;
				}
				var var4 = new String();
				var var5 = 0;
				while(var5 < var3)
				{
					var var6 = this._oItem.attackers[var5];
					var4 = var4 + ("\n" + var6.name + " (" + var6.level + ")");
					var5 = var5 + 1;
				}
				this._mcList.gapi.showTooltip(this._mcList.gapi.api.lang.getText("ATTACKERS") + " : " + var4,var2.target,40);
				break;
			case "_btnState":
				var var7 = new String();
				switch(this._oItem.state)
				{
					case 0:
						var7 = this._mcList.gapi.api.lang.getText("TAX_IN_COLLECT");
						break;
					case 1:
						var7 = this._mcList.gapi.api.lang.getText("TAX_IN_ENTERFIGHT");
						break;
					default:
						if(var0 !== 2)
						{
							break;
						}
						var7 = this._mcList.gapi.api.lang.getText("TAX_IN_FIGHT");
						break;
				}
				if(this._oItem.showMoreInfo)
				{
					if(this._oItem.callerName != "?")
					{
						var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("OWNER_WORD") + " : " + this._oItem.callerName);
					}
					var var8 = new Date(this._oItem.startDate);
					if(var8.getFullYear() != 1970)
					{
						var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_START_DATE",[var8.getDay(),var8.getMonth() + 1,var8.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z,var8.getHours(),var8.getMinutes()]));
					}
					if(this._oItem.lastHarvesterName != "?")
					{
						var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("LAST_HARVESTER_NAME") + " : " + this._oItem.lastHarvesterName);
					}
					var8 = new Date(this._oItem.lastHarvestDate);
					if(var8.getFullYear() != 1970)
					{
						var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_LAST_DATE",[var8.getDay(),var8.getMonth() + 1,var8.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z,var8.getHours(),var8.getMinutes()]));
					}
					var var9 = new Date();
					var var10 = this._oItem.nextHarvestDate - var9.valueOf();
					if(var10 <= 0)
					{
						var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST"));
					}
					else
					{
						var var11 = Math.floor(var10 / 1000 / 60 / 60);
						var var12 = Math.floor(var10 / 1000 / 60 - var11 * 60);
						var var13 = var11 + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("HOURS"),"m",var11 == 1);
						if(var12 == 0)
						{
							var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN",[var13,""]));
						}
						else
						{
							var var14 = this._mcList.gapi.api.lang.getText("AND") + " ";
							var var15 = var12 + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("MINUTES"),"m",var12 == 1);
							var7 = var7 + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN",[var13,var14 + var15]));
						}
					}
				}
				this._mcList.gapi.showTooltip(var7,var2.target,40);
				break;
			default:
				var var16 = var2.target.params.player;
				if(var16 != undefined)
				{
					this._mcList.gapi.showTooltip(var16.name + " (" + var16.level + ")",var2.target,-20);
					break;
				}
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this._mcList.gapi.hideTooltip();
	}
	function endTimer(§\x1e\x19\x18§)
	{
		this._vcTimer.stopTimer();
		this.showButtonsJoin(0);
		this._oItem.state = 2;
		this.showStateIcon();
		this.updateAttackers();
		this._mcList.gapi.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		this._mcList.gapi.hideTooltip();
		this.updateAttackers();
		this.updatePlayers();
	}
}
