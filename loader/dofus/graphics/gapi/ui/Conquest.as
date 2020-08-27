class dofus.graphics.gapi.ui.Conquest extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Conquest";
	var _sCurrentTab = "Stats";
	function Conquest()
	{
		super();
	}
	function __set__currentTab(var2)
	{
		this._sCurrentTab = var2;
		return this.__get__currentTab();
	}
	function sharePropertiesWithTab(var2)
	{
		for(var i in var2)
		{
			this._mcTabViewer[i] = var2[i];
		}
	}
	function setBalance(var2, var3)
	{
		this._nWorldBalance = var2;
		this._nAreaBalance = var3;
		this.addToQueue({object:this,method:this.updateBalance});
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Conquest.CLASS_NAME);
	}
	function callClose()
	{
		switch(this._sCurrentTab)
		{
			case "Zones":
				this.api.network.Conquest.worldInfosLeave();
				break;
			case "Join":
				if(!(dofus.graphics.gapi.controls.ConquestJoinViewer)this._mcTabViewer.noUnsubscribe)
				{
					this.api.network.Conquest.prismInfosLeave();
					break;
				}
		}
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this._mcPlacer._visible = false;
		this._mcPvpActive._visible = false;
		this._mcPvpInactive._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.setCurrentTab,params:[this._sCurrentTab]});
	}
	function addListeners()
	{
		this.api.datacenter.Player.addEventListener("rankChanged",this);
		this.api.datacenter.Player.addEventListener("alignmentChanged",this);
		this._btnClose.addEventListener("click",this);
		this._btnTabJoin.addEventListener("click",this);
		this._btnTabStats.addEventListener("click",this);
		this._btnTabZones.addEventListener("click",this);
		this._ctrAlignment.addEventListener("over",this);
		this._ctrAlignment.addEventListener("out",this);
		var ref = this;
		this._mcBalanceInteractivity.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcBalanceInteractivity.onRollOut = function()
		{
			ref.out({target:this});
		};
	}
	function initTexts()
	{
		this._lblTitle.text = this.api.lang.getText("CONQUEST_WORD");
		this._lblGrade.text = this.api.lang.getText("RANK");
		this._lblBalance.text = this.api.lang.getText("BALANCE_WORD");
		this._btnTabStats.label = this.api.lang.getText("STATS");
		this._btnTabZones.label = this.api.lang.getText("ZONES_WORD");
		this._btnTabJoin.label = this.api.lang.getText("DEFEND");
	}
	function initData()
	{
		this.rankChanged({rank:this.api.datacenter.Player.rank});
		this.alignmentChanged({alignment:this.api.datacenter.Player.alignment});
		this.api.network.Conquest.requestBalance();
	}
	function setCurrentTab(var2)
	{
		this._mcComboBoxPopup.removeMovieClip();
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		switch(this._sCurrentTab)
		{
			case "Zones":
				this.api.network.Conquest.worldInfosLeave();
				break;
			case "Join":
				if(!(dofus.graphics.gapi.controls.ConquestJoinViewer)this._mcTabViewer.noUnsubscribe)
				{
					this.api.network.Conquest.prismInfosLeave();
					break;
				}
		}
		this._sCurrentTab = var2;
		this.updateCurrentTabInformations();
	}
	function updateCurrentTabInformations()
	{
		this._mcTabViewer.removeMovieClip();
		if((var var0 = this._sCurrentTab) !== "Stats")
		{
			switch(null)
			{
				case "Zones":
					this.attachMovie("ConquestZonesViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
					this.api.network.Conquest.worldInfosJoin();
					break;
				case "Join":
					this.attachMovie("ConquestJoinViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
					this.api.network.Conquest.prismInfosJoin();
			}
		}
		else
		{
			this.attachMovie("ConquestStatsViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
		}
	}
	function updateBalance()
	{
		var var2 = this.api.lang.getAlignmentBalance();
		var var3 = new String();
		for(var i in var2)
		{
			if(this._nWorldBalance >= var2[i].s && this._nWorldBalance <= var2[i].e)
			{
				var3 = String(var2[i].n);
				this._sBalanceDescription = String(var2[i].d);
			}
		}
		this._lblBalanceValue.text = this._nWorldBalance + "%" + (var3.length <= 0?"":" (" + var3 + ")");
	}
	function destroy()
	{
		switch(this._sCurrentTab)
		{
			case "Zones":
				this.api.network.Conquest.worldInfosLeave();
				break;
			case "Join":
				this.api.network.Conquest.prismInfosLeave();
		}
	}
	function over(var2)
	{
		switch(var2.target)
		{
			case this._ctrAlignment:
				this.gapi.showTooltip(this.api.datacenter.Player.alignment.name,var2.target,var2.target.height + 5);
				break;
			case this._mcBalanceInteractivity:
				var var3 = new String();
				if(this._sBalanceDescription.length > 0)
				{
					var3 = var3 + this._sBalanceDescription;
				}
				if(this._nAreaBalance != undefined && (!_global.isNaN(this._nAreaBalance) && this._nAreaBalance > 0))
				{
					var3 = var3 + ("\n\n" + this.api.lang.getText("CONQUEST_ZONE_BALANCE") + ": " + this._nAreaBalance + "%");
				}
				this.gapi.showTooltip(var3,var2.target,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this._btnClose:
				this.callClose();
				break;
			case this._btnTabJoin:
			case this._btnTabStats:
			case this._btnTabZones:
				this.setCurrentTab(var2.target._name.substr(7));
		}
	}
	function rankChanged(var2)
	{
		this._rRank = (dofus.datacenter.Rank)var2.rank;
		if(this._rRank.enable && this._lblStats.text != undefined)
		{
			var var3 = this.api.datacenter.Player.alignment.index;
			if(var3 == 0)
			{
				this._lblGradeValue.text = this.api.lang.getRankLongName(0,0);
			}
			else
			{
				this._lblGradeValue.text = var2.rank.value + " (" + this.api.lang.getRankLongName(var3,this._rRank.value) + ")";
			}
			this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("ACTIVE") + ")";
			this._mcPvpActive._visible = true;
			this._mcPvpInactive._visible = false;
		}
		else if(this._lblStats.text != undefined)
		{
			this._lblGradeValue.text = "-";
			this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("INACTIVE") + ")";
			this._mcPvpActive._visible = false;
			this._mcPvpInactive._visible = true;
		}
	}
	function alignmentChanged(var2)
	{
		this._ctrAlignment.contentPath = var2.alignment.iconFile;
	}
}
