class dofus.graphics.gapi.ui.FightsInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "FightsInfos";
	function FightsInfos()
	{
		super();
	}
	function __get__fights()
	{
		return this._eaFights;
	}
	function addFightTeams(var2, var3, var4)
	{
		var var6 = this._eaFights.findFirstItem("id",var2);
		if(var6.index != -1)
		{
			var var5 = var6.item;
		}
		var5.addPlayers(1,var3);
		var5.addPlayers(2,var4);
		this.showTeamInfos(true,this._oSelectedFight);
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.FightsInfos.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this._eaFights = new ank.utils.();
		this.showTeamInfos(false);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this.api.network.Fights,method:this.api.network.Fights.getList});
		this.setMovieClipColor(this._mcSquare1,dofus.Constants.TEAMS_COLOR[0]);
		this.setMovieClipColor(this._mcSquare2,dofus.Constants.TEAMS_COLOR[1]);
	}
	function initTexts()
	{
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnJoin.label = this.api.lang.getText("JOIN_SMALL");
		this._winBg.title = this.api.lang.getText("CURRENT_FIGTHS");
		this._dgFights.columnsNames = [this.api.lang.getText("FIGHTERS_COUNT"),this.api.lang.getText("DURATION")];
		this._lblPlayers.text = this.api.lang.getText("FIGHTERS");
		this._txtSelectFight.text = this.api.lang.getText("SELECT_FIGHT_FOR_SPECTATOR");
		if(this._lblTeam1Level.text != undefined)
		{
			this._lblTeam1Level.text = "";
		}
		if(this._lblTeam2Level.text != undefined)
		{
			this._lblTeam2Level.text = "";
		}
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnJoin.addEventListener("click",this);
		this._dgFights.addEventListener("itemSelected",this);
		this._lstTeam1.addEventListener("itemSelected",this);
		this._lstTeam2.addEventListener("itemSelected",this);
	}
	function initData()
	{
		this._dgFights.dataProvider = this._eaFights;
	}
	function showTeamInfos(var2, var3)
	{
		this._lblTeam1Level._visible = var2;
		this._lblTeam2Level._visible = var2;
		this._lstTeam1._visible = var2;
		this._lstTeam2._visible = var2;
		this._mcBackTeam._visible = var2;
		this._mcSquare1._visible = var2;
		this._mcSquare2._visible = var2;
		this._txtSelectFight._visible = !var2;
		this._btnJoin.enabled = var2;
		if(var2)
		{
			this._lblTeam1Level.text = this.api.lang.getText("LEVEL") + " " + var3.team1Level;
			this._lblTeam2Level.text = this.api.lang.getText("LEVEL") + " " + var3.team2Level;
			this._lstTeam1.dataProvider = var3.team1Players;
			this._lstTeam2.dataProvider = var3.team2Players;
		}
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnJoin":
				this.api.network.GameActions.joinChallenge(this._oSelectedFight.id);
				this.callClose();
		}
	}
	function itemSelected(var2)
	{
		if((var var0 = var2.target._name) !== "_dgFights")
		{
			if(var2.row.item.type == "player")
			{
				var var3 = var2.row.item.name;
				if(this.api.datacenter.Player.isAuthorized && Key.isDown(Key.SHIFT))
				{
					var var4 = "";
					var var5 = false;
					var var6 = 0;
					while(var6 < this._lstTeam1.dataProvider.length)
					{
						var var7 = this._lstTeam1.dataProvider[var6].name;
						if(var7 == var3)
						{
							var5 = true;
						}
						var4 = var4 + (var7 + ",");
						var6 = var6 + 1;
					}
					if(!var5)
					{
						var4 = "";
						var var8 = 0;
						while(var8 < this._lstTeam2.dataProvider.length)
						{
							var var9 = this._lstTeam2.dataProvider[var8].name;
							if(var9 == var3)
							{
								var5 = true;
							}
							var4 = var4 + (var9 + ",");
							var8 = var8 + 1;
						}
					}
					if(var5)
					{
						var4 = var4.substring(0,var4.length - 1);
						this.api.kernel.GameManager.showTeamAdminPopupMenu(var4);
					}
				}
				else
				{
					this.api.kernel.GameManager.showPlayerPopupMenu(undefined,var3);
				}
			}
		}
		else
		{
			this._oSelectedFight = var2.row.item;
			if(this._oSelectedFight.hasTeamPlayers)
			{
				this.showTeamInfos(true,this._oSelectedFight);
			}
			else
			{
				this.api.network.Fights.getDetails(this._oSelectedFight.id);
				this.showTeamInfos(false);
			}
		}
	}
}
