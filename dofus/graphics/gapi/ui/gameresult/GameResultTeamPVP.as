class dofus.graphics.gapi.ui.gameresult.GameResultTeamPVP extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "GameResultPlayerPVPNoHonour";
   function GameResultTeamPVP()
   {
      super();
   }
   function __set__title(sTitle)
   {
      this._sTitle = sTitle;
      return this.__get__title();
   }
   function __set__dataProvider(eaDataProvider)
   {
      this._eaDataProvider = eaDataProvider;
      return this.__get__dataProvider();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.gameresult.GameResultTeamPVP.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.initData});
      this._lstPlayers._visible = false;
   }
   function addListeners()
   {
   }
   function initTexts()
   {
      this._lblWinLoose.text = this._sTitle;
      this._lblName.text = this.api.lang.getText("NAME_BIG");
      this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
      this._lblKama.text = this.api.lang.getText("KAMAS");
      this._lblHonour.text = this.api.lang.getText("HONOUR_POINTS");
      this._lblRank.text = this.api.lang.getText("RANK");
      this._lblItems.text = this.api.lang.getText("WIN_ITEMS");
      if(!this.api.datacenter.Basics.aks_current_server.isHardcore())
      {
         this._lblDisgrace.text = this.api.lang.getText("DISGRACE_POINTS");
      }
      else
      {
         this._lblDisgrace.text = this.api.lang.getText("WIN_XP");
      }
   }
   function initData()
   {
      if(this.api.datacenter.Basics.aks_current_server.isHardcore())
      {
         this._lstPlayers.cellRenderer = "GameResultPlayerPVPNoHonour";
      }
      else
      {
         this._lstPlayers.cellRenderer = "GameResultPlayerPVP";
      }
      var _loc2_ = this._eaDataProvider.length;
      this._lstPlayers.dataProvider = this._eaDataProvider;
      this._lstPlayers.setSize(undefined,Math.min(_loc2_,dofus.graphics.gapi.ui.GameResult.MAX_VISIBLE_PLAYERS_IN_TEAM) * this._lstPlayers.rowHeight);
      this._lstPlayers._visible = true;
   }
   function itemRollOver(oEvent)
   {
   }
   function itemRollOut(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
