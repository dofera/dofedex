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
   function addFightTeams(nFightID, eaTeam1, eaTeam2)
   {
      var _loc6_ = this._eaFights.findFirstItem("id",nFightID);
      if(_loc6_.index != -1)
      {
         var _loc5_ = _loc6_.item;
      }
      _loc5_.addPlayers(1,eaTeam1);
      _loc5_.addPlayers(2,eaTeam2);
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
      this._eaFights = new ank.utils.ExtendedArray();
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
   function showTeamInfos(bShow, oFight)
   {
      this._lblTeam1Level._visible = bShow;
      this._lblTeam2Level._visible = bShow;
      this._lstTeam1._visible = bShow;
      this._lstTeam2._visible = bShow;
      this._mcBackTeam._visible = bShow;
      this._mcSquare1._visible = bShow;
      this._mcSquare2._visible = bShow;
      this._txtSelectFight._visible = !bShow;
      this._btnJoin.enabled = bShow;
      if(bShow)
      {
         this._lblTeam1Level.text = this.api.lang.getText("LEVEL") + " " + oFight.team1Level;
         this._lblTeam2Level.text = this.api.lang.getText("LEVEL") + " " + oFight.team2Level;
         this._lstTeam1.dataProvider = oFight.team1Players;
         this._lstTeam2.dataProvider = oFight.team2Players;
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
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
   function itemSelected(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) !== "_dgFights")
      {
         if(oEvent.row.item.type == "player")
         {
            this.api.kernel.GameManager.showPlayerPopupMenu(undefined,oEvent.row.item.name);
         }
      }
      else
      {
         this._oSelectedFight = oEvent.row.item;
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
