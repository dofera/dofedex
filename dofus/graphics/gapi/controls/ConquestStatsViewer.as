class dofus.graphics.gapi.controls.ConquestStatsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ConquestStatsViewer";
   function ConquestStatsViewer()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ConquestStatsViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function addListeners()
   {
      this._btnTogglePvP.addEventListener("click",this);
      this._btnTogglePvP.addEventListener("over",this);
      this._btnTogglePvP.addEventListener("out",this);
      this._btnDisgraceSanction.addEventListener("click",this);
      this._btnDisgraceSanction.addEventListener("over",this);
      this._btnDisgraceSanction.addEventListener("out",this);
      this.api.datacenter.Player.addEventListener("rankChanged",this);
      this.api.datacenter.Conquest.addEventListener("bonusChanged",this);
      var ref = this;
      this._mcBonusInteractivity.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcBonusInteractivity.onRollOut = function()
      {
         ref.out({target:this});
      };
      this._mcMalusInteractivity.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcMalusInteractivity.onRollOut = function()
      {
         ref.out({target:this});
      };
   }
   function initTexts()
   {
      this._lblHonour.text = this.api.lang.getText("HONOUR_POINTS");
      this._lblDishonour.text = this.api.lang.getText("DISGRACE_POINTS");
      this._lblBonus.text = this.api.lang.getText("ALIGNED_AREA_MODIFICATORS");
      this._lblType.text = this.api.lang.getText("TYPE");
      this._lblBonusTitle.text = this.api.lang.getText("BONUS");
      this._lblMalusTitle.text = this.api.lang.getText("MALUS");
      this._lblInfos.text = this.api.lang.getText("INFORMATIONS");
      this._txtInfos.text = this.api.lang.getText("RANK_SYSTEM_INFO");
   }
   function initData()
   {
      this.api.network.Conquest.getAlignedBonus();
      this.rankChanged({rank:this.api.datacenter.Player.rank});
   }
   function updateBonus()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = this.api.datacenter.Conquest.alignBonus;
      var _loc4_ = this.api.datacenter.Conquest.rankMultiplicator;
      var _loc5_ = this.api.datacenter.Conquest.alignMalus;
      _loc2_.push({type:this.api.lang.getText("EXPERIMENT"),bonus:(_loc4_.drop != 0?"+" + _loc3_.xp * _loc4_.xp + "% (" + _loc3_.xp + "% x" + _loc4_.xp + ")":"0%"),malus:_loc5_.xp + "%"});
      _loc2_.push({type:this.api.lang.getText("COLLECT"),bonus:(_loc4_.drop != 0?"+" + _loc3_.recolte * _loc4_.recolte + "% (" + _loc3_.recolte + "% x" + _loc4_.recolte + ")":"0%"),malus:_loc5_.recolte + "%"});
      _loc2_.push({type:this.api.lang.getText("LOOT"),bonus:(_loc4_.drop != 0?"+" + _loc3_.drop * _loc4_.drop + "% (" + _loc3_.drop + "% x" + _loc4_.drop + ")":"0%"),malus:_loc5_.drop + "%"});
      this._lstBonuses.dataProvider = _loc2_;
   }
   function bonusChanged(oEvent)
   {
      this.updateBonus();
   }
   function rankChanged(oEvent)
   {
      this._oRank = oEvent.rank;
      var _loc3_ = this.api.lang.getGradeHonourPointsBounds(this._oRank.value);
      this._pbHonour.maximum = !_global.isNaN(_loc3_.max)?_loc3_.max:0;
      this._pbHonour.minimum = !_global.isNaN(_loc3_.min)?_loc3_.min:0;
      this._pbHonour.value = !_global.isNaN(this._oRank.honour)?this._oRank.honour:0;
      this._mcHonour.onRollOver = function()
      {
         this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.honour).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._pbHonour.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
      };
      this._mcHonour.onRollOut = function()
      {
         this._parent.gapi.hideTooltip();
      };
      this._pbDishonour.value = this._oRank.disgrace;
      this._pbDishonour.maximum = this.api.lang.getMaxDisgracePoints();
      this._mcDishonour.onRollOver = function()
      {
         this._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oRank.disgrace).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._pbDishonour.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
      };
      this._mcDishonour.onRollOut = function()
      {
         this._parent.gapi.hideTooltip();
      };
      if(this._oRank.enable && this._lblInfos.text != undefined)
      {
         var _loc4_ = this.api.datacenter.Player.alignment.index;
         this._btnTogglePvP.label = this.api.lang.getText("DISABLE_PVP_SHORT");
      }
      else if(this._lblInfos.text != undefined)
      {
         this._btnTogglePvP.label = this.api.lang.getText("ENABLE_PVP_SHORT");
      }
      this._btnDisgraceSanction._visible = this.api.datacenter.Player.rank.disgrace > 0;
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnDisgraceSanction:
            this.api.kernel.GameManager.showDisgraceSanction();
            break;
         case this._btnTogglePvP:
            if(this.api.datacenter.Player.rank.enable)
            {
               this.api.network.Game.askDisablePVPMode();
            }
            else
            {
               this.api.network.Game.onPVP("",true);
            }
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnTogglePvP:
            this.gapi.showTooltip(this.api.lang.getText(!this._oRank.enable?"ENABLE_PVP":"DISABLE_PVP"),this._btnTogglePvP,-20);
            break;
         case this._btnDisgraceSanction:
            this.gapi.showTooltip(this.api.lang.getText("DISGRACE_SANCTION_TOOLTIP"),this._btnDisgraceSanction,-20);
            break;
         case this._mcBonusInteractivity:
            this.gapi.showTooltip(this.api.lang.getText("CONQUEST_STATS_BONUS"),this._mcBonusInteractivity,-70);
            break;
         case this._mcMalusInteractivity:
            this.gapi.showTooltip(this.api.lang.getText("CONQUEST_STATS_MALUS"),this._mcMalusInteractivity,-40);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
