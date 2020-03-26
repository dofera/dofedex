class dofus.graphics.gapi.controls.alignmentviewer.RankViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "RankViewer";
   function RankViewer()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.alignmentviewer.RankViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this._mcPvpActive._visible = false;
      this._mcPvpInactive._visible = false;
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._lblStats.text = this.api.lang.getText("PVP_MODE");
      this._lblInfos.text = this.api.lang.getText("INFORMATIONS");
      this._lblDisgrace.text = this.api.lang.getText("DISGRACE_POINTS");
      this._lblHonour.text = this.api.lang.getText("HONOUR_POINTS");
      this._lblRank.text = this.api.lang.getText("RANK");
      this._txtInfos.text = this.api.lang.getText("RANK_SYSTEM_INFO");
   }
   function addListeners()
   {
      this.api.datacenter.Player.addEventListener("rankChanged",this);
      this._btnEnabled.addEventListener("click",this);
      this._btnEnabled.addEventListener("over",this);
      this._btnEnabled.addEventListener("out",this);
      this._btnDisgraceSanction.addEventListener("click",this);
      this._btnDisgraceSanction.addEventListener("over",this);
      this._btnDisgraceSanction.addEventListener("out",this);
   }
   function initData()
   {
      this._pbDisgrace.maximum = this.api.lang.getMaxDisgracePoints();
      this.rankChanged({rank:this.api.datacenter.Player.rank});
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnEnabled":
            if(this.api.datacenter.Player.rank.enable)
            {
               this.api.network.Game.askDisablePVPMode();
            }
            else
            {
               this.api.network.Game.onPVP("",true);
            }
            break;
         case "_btnDisgraceSanction":
            this.api.kernel.GameManager.showDisgraceSanction();
      }
   }
   function rankChanged(oEvent)
   {
      this._oRank = oEvent.rank;
      var _loc3_ = this.api.lang.getGradeHonourPointsBounds(this._oRank.value);
      this._pbHonour.maximum = _loc3_.max;
      this._pbHonour.minimum = _loc3_.min;
      this._pbHonour.value = this._oRank.honour;
      this._mcHonour.onRollOver = function()
      {
         this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.honour).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._pbHonour.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
      };
      this._mcHonour.onRollOut = function()
      {
         this._parent.gapi.hideTooltip();
      };
      this._pbDisgrace.value = this._oRank.disgrace;
      this._mcDisgrace.onRollOver = function()
      {
         this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.disgrace).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._pbDisgrace.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
      };
      this._mcDisgrace.onRollOut = function()
      {
         this._parent.gapi.hideTooltip();
      };
      if(this._oRank.enable && this._lblRankDisabled.text != undefined)
      {
         var _loc4_ = this.api.datacenter.Player.alignment.index;
         if(_loc4_ == 0)
         {
            this._lblRankValue.text = this.api.lang.getRankLongName(0,0);
         }
         else
         {
            this._lblRankValue.text = oEvent.rank.value + " (" + this.api.lang.getRankLongName(_loc4_,this._oRank.value) + ")";
         }
         this._lblDisgrace._visible = true;
         this._mcDisgrace._visible = true;
         this._pbDisgrace._visible = true;
         this._lblRank.text = this.api.lang.getText("RANK");
         this._lblRankDisabled.text = "";
         this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("ACTIVE") + ")";
         this._mcPvpActive._visible = true;
         this._mcPvpInactive._visible = false;
         this._btnEnabled.label = this.api.lang.getText("DISABLE");
      }
      else if(this._lblRankValue.text != undefined)
      {
         this._lblDisgrace._visible = false;
         this._mcDisgrace._visible = false;
         this._pbDisgrace._visible = false;
         this._lblRankValue.text = "";
         this._lblRank.text = "";
         this._lblRankDisabled.text = this.api.lang.getText("PVP_MODE_DISABLED");
         this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("INACTIVE") + ")";
         this._mcPvpActive._visible = false;
         this._mcPvpInactive._visible = true;
         this._btnEnabled.label = this.api.lang.getText("ENABLE");
      }
      this._btnDisgraceSanction._visible = this.api.datacenter.Player.rank.disgrace > 0;
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnEnabled":
            this.gapi.showTooltip(this.api.lang.getText(!this._oRank.enable?"ENABLE_PVP":"DISABLE_PVP"),this._btnEnabled,-20);
            break;
         case "_btnDisgraceSanction":
            this.gapi.showTooltip(this.api.lang.getText("DISGRACE_SANCTION_TOOLTIP"),this._btnDisgraceSanction,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
