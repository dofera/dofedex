class dofus.graphics.gapi.ui.StatsJob extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "StatsJob";
   function StatsJob()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.StatsJob.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this._mcViewersPlacer._visible = false;
      this._btnClosePanel._visible = false;
      this.api.datacenter.Player.data.addListener(this);
      this.api.datacenter.Player.addEventListener("levelChanged",this);
      this.api.datacenter.Player.addEventListener("xpChanged",this);
      this.api.datacenter.Player.addEventListener("lpChanged",this);
      this.api.datacenter.Player.addEventListener("lpMaxChanged",this);
      this.api.datacenter.Player.addEventListener("apChanged",this);
      this.api.datacenter.Player.addEventListener("mpChanged",this);
      this.api.datacenter.Player.addEventListener("initiativeChanged",this);
      this.api.datacenter.Player.addEventListener("discernmentChanged",this);
      this.api.datacenter.Player.addEventListener("forceXtraChanged",this);
      this.api.datacenter.Player.addEventListener("vitalityXtraChanged",this);
      this.api.datacenter.Player.addEventListener("wisdomXtraChanged",this);
      this.api.datacenter.Player.addEventListener("chanceXtraChanged",this);
      this.api.datacenter.Player.addEventListener("agilityXtraChanged",this);
      this.api.datacenter.Player.addEventListener("intelligenceXtraChanged",this);
      this.api.datacenter.Player.addEventListener("bonusPointsChanged",this);
      this.api.datacenter.Player.addEventListener("energyChanged",this);
      this.api.datacenter.Player.addEventListener("energyMaxChanged",this);
      this.api.datacenter.Player.addEventListener("alignmentChanged",this);
   }
   function addListeners()
   {
      this._ctrAlignment.addEventListener("click",this);
      this._ctrJob0.addEventListener("click",this);
      this._ctrJob1.addEventListener("click",this);
      this._ctrJob2.addEventListener("click",this);
      this._ctrSpe0.addEventListener("click",this);
      this._ctrSpe1.addEventListener("click",this);
      this._ctrSpe2.addEventListener("click",this);
      this._ctrAlignment.addEventListener("over",this);
      this._ctrJob0.addEventListener("over",this);
      this._ctrJob1.addEventListener("over",this);
      this._ctrJob2.addEventListener("over",this);
      this._ctrSpe0.addEventListener("over",this);
      this._ctrSpe1.addEventListener("over",this);
      this._ctrSpe2.addEventListener("over",this);
      this._ctrAlignment.addEventListener("out",this);
      this._ctrJob0.addEventListener("out",this);
      this._ctrJob1.addEventListener("out",this);
      this._ctrJob2.addEventListener("out",this);
      this._ctrSpe0.addEventListener("out",this);
      this._ctrSpe1.addEventListener("out",this);
      this._ctrSpe2.addEventListener("out",this);
      this._btn10.addEventListener("click",this);
      this._btn10.addEventListener("over",this);
      this._btn10.addEventListener("out",this);
      this._btn11.addEventListener("click",this);
      this._btn11.addEventListener("over",this);
      this._btn11.addEventListener("out",this);
      this._btn12.addEventListener("click",this);
      this._btn12.addEventListener("over",this);
      this._btn12.addEventListener("out",this);
      this._btn13.addEventListener("click",this);
      this._btn13.addEventListener("over",this);
      this._btn13.addEventListener("out",this);
      this._btn14.addEventListener("click",this);
      this._btn14.addEventListener("over",this);
      this._btn14.addEventListener("out",this);
      this._btn15.addEventListener("click",this);
      this._btn15.addEventListener("over",this);
      this._btn15.addEventListener("out",this);
      this.api.datacenter.Game.addEventListener("stateChanged",this);
      this._btnClose.addEventListener("click",this);
      this._btnClosePanel.addEventListener("click",this);
      this._mcMoreStats.onRelease = function()
      {
         this._parent.click({target:this});
      };
   }
   function initData()
   {
      var _loc2_ = this.api.datacenter.Player;
      this.levelChanged({value:_loc2_.Level});
      this.xpChanged({value:_loc2_.XP});
      this.lpChanged({value:_loc2_.LP});
      this.lpMaxChanged({value:_loc2_.LPmax});
      this.apChanged({value:_loc2_.AP});
      this.mpChanged({value:_loc2_.MP});
      this.initiativeChanged({value:_loc2_.Initiative});
      this.discernmentChanged({value:_loc2_.Discernment});
      this.forceXtraChanged({value:_loc2_.ForceXtra});
      this.vitalityXtraChanged({value:_loc2_.VitalityXtra});
      this.wisdomXtraChanged({value:_loc2_.WisdomXtra});
      this.chanceXtraChanged({value:_loc2_.ChanceXtra});
      this.agilityXtraChanged({value:_loc2_.AgilityXtra});
      this.intelligenceXtraChanged({value:_loc2_.IntelligenceXtra});
      this.bonusPointsChanged({value:_loc2_.BonusPoints});
      this.energyChanged({value:_loc2_.Energy});
      this.alignmentChanged({alignment:_loc2_.alignment});
      var _loc3_ = this.api.datacenter.Player.Jobs;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_];
         var _loc6_ = _loc5_.specializationOf;
         if(_loc6_ != 0)
         {
            var _loc7_ = 0;
            while(_loc7_ < 3)
            {
               var _loc8_ = this["_ctrSpe" + _loc7_];
               if(_loc8_.contentData == undefined)
               {
                  _loc8_.contentData = _loc5_;
                  break;
               }
               _loc7_ = _loc7_ + 1;
            }
         }
         else
         {
            var _loc9_ = 0;
            while(_loc9_ < 3)
            {
               var _loc10_ = this["_ctrJob" + _loc9_];
               if(_loc10_.contentData == undefined)
               {
                  _loc10_.contentData = _loc5_;
                  break;
               }
               _loc9_ = _loc9_ + 1;
            }
         }
         _loc4_ = _loc4_ + 1;
      }
      this._lblName.text = this.api.datacenter.Player.data.name;
      this.activateBoostButtons(!this.api.datacenter.Game.isFight);
   }
   function initTexts()
   {
      this._lblEnergy.text = this.api.lang.getText("ENERGY");
      if(this.api.datacenter.Basics.aks_current_server.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
      {
         this._lblEnergy._alpha = 50;
         this._mcOverEnergy._visible = false;
      }
      this._lblCharacteristics.text = this.api.lang.getText("CHARACTERISTICS");
      this._lblMyJobs.text = this.api.lang.getText("MY_JOBS");
      this._lblXP.text = this.api.lang.getText("EXPERIMENT");
      this._lblLP.text = this.api.lang.getText("LIFEPOINTS");
      this._lblAP.text = this.api.lang.getText("ACTIONPOINTS");
      this._lblMP.text = this.api.lang.getText("MOVEPOINTS");
      this._lblInitiative.text = this.api.lang.getText("INITIATIVE");
      this._lblDiscernment.text = this.api.lang.getText("DISCERNMENT");
      this._lblForce.text = this.api.lang.getText("FORCE");
      this._lblVitality.text = this.api.lang.getText("VITALITY");
      this._lblWisdom.text = this.api.lang.getText("WISDOM");
      this._lblChance.text = this.api.lang.getText("CHANCE");
      this._lblAgility.text = this.api.lang.getText("AGILITY");
      this._lblIntelligence.text = this.api.lang.getText("INTELLIGENCE");
      this._lblCapital.text = this.api.lang.getText("CHARACTERISTICS_POINTS");
      this._lblSpecialization.text = this.api.lang.getText("SPECIALIZATIONS");
      this._mcMoreStats.onRollOver = function()
      {
         this._parent.gapi.showTooltip(this._parent.api.lang.getText("MORE_STATS"),this,-20);
      };
      this._mcMoreStats.onRollOut = function()
      {
         this._parent.gapi.hideTooltip();
      };
   }
   function showStats()
   {
      this.hideAlignment();
      this.hideJob();
      if(this._svStats == undefined)
      {
         this.attachMovie("StatsViewer","_svStats",this.getNextHighestDepth(),{_x:this._mcViewersPlacer._x,_y:this._mcViewersPlacer._y});
         this._btnClosePanel._visible = true;
         this._btnClosePanel.swapDepths(this.getNextHighestDepth());
         this._btnClosePanel._x = this._btnClosePanel._x + 35;
      }
      else
      {
         this.hideStats();
      }
   }
   function hideStats()
   {
      if(this._svStats != undefined)
      {
         this._btnClosePanel._x = this._btnClosePanel._x - 35;
      }
      this._svStats.removeMovieClip();
      this._btnClosePanel._visible = false;
   }
   function showJob(oJob)
   {
      this.hideAlignment();
      this.hideStats();
      if(oJob == undefined)
      {
         this.hideJob();
         return undefined;
      }
      if(this._jvJob == undefined)
      {
         this.attachMovie("JobViewer","_jvJob",this.getNextHighestDepth(),{_x:this._mcViewersPlacer._x,_y:this._mcViewersPlacer._y});
         this._btnClosePanel._visible = true;
         this._btnClosePanel.swapDepths(this.getNextHighestDepth());
      }
      else if(this._oCurrentJob.id == oJob.id)
      {
         this.hideJob();
         return undefined;
      }
      this._jvJob.job = oJob;
      this["_ctr" + (this._oCurrentJob.specializationOf != 0?"Spe":"Job") + this._oCurrentJob.id].selected = false;
      this["_ctr" + (oJob.specializationOf != 0?"Spe":"Job") + oJob.id].selected = true;
      this._oCurrentJob = oJob;
   }
   function hideJob()
   {
      this["_ctr" + (this._oCurrentJob.specializationOf != 0?"Spe":"Job") + this._oCurrentJob.id].selected = false;
      this._jvJob.removeMovieClip();
      delete this._oCurrentJob;
      this._btnClosePanel._visible = false;
   }
   function showAlignment()
   {
      this.hideJob();
      this.hideStats();
      if(this._avAlignment == undefined)
      {
         this.attachMovie("AlignmentViewer","_avAlignment",this.getNextHighestDepth(),{_x:this._mcViewersPlacer._x,_y:this._mcViewersPlacer._y});
         this._btnClosePanel._visible = true;
         this._btnClosePanel.swapDepths(this.getNextHighestDepth());
      }
      else
      {
         this.hideAlignment();
      }
   }
   function hideAlignment()
   {
      this._avAlignment.removeMovieClip();
      this._btnClosePanel._visible = false;
   }
   function activateBoostButtons(bActivated)
   {
      var _loc3_ = 10;
      while(_loc3_ < 16)
      {
         this["_btn" + _loc3_].enabled = bActivated;
         _loc3_ = _loc3_ + 1;
      }
   }
   function updateCharacteristicButton(nCharacteristicID)
   {
      var _loc3_ = this.api.datacenter.Player.getBoostCostAndCountForCharacteristic(nCharacteristicID).cost;
      var _loc4_ = this["_btn" + nCharacteristicID];
      if(_loc3_ <= this.api.datacenter.Player.BonusPoints)
      {
         _loc4_._visible = true;
      }
      else
      {
         _loc4_._visible = false;
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClosePanel":
            this.hideJob();
            this.hideAlignment();
            this.hideStats();
            break;
         case "_ctrAlignment":
            if(this.api.datacenter.Player.data.alignment.index == 0)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NEED_ALIGNMENT"),"ERROR_BOX");
            }
            else
            {
               this.showAlignment();
            }
            break;
         case "_btn10":
         case "_btn11":
         case "_btn12":
         case "_btn13":
         case "_btn14":
         case "_btn15":
            this.api.sounds.events.onStatsJobBoostButtonClick();
            var _loc3_ = oEvent.target._name.substr(4);
            if(this.api.datacenter.Player.canBoost(_loc3_))
            {
               this.api.network.Account.boost(_loc3_);
            }
            break;
         case "_btnClose":
            this.callClose();
            break;
         case "_mcMoreStats":
            this.showStats();
            break;
         default:
            this.showJob(oEvent.target.contentData);
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btn10":
         case "_btn11":
         case "_btn12":
         case "_btn13":
         case "_btn14":
         case "_btn15":
            var _loc3_ = Number(oEvent.target._name.substr(4));
            var _loc4_ = this.api.datacenter.Player.getBoostCostAndCountForCharacteristic(_loc3_);
            this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc4_.cost + " " + this.api.lang.getText("POUR") + " " + _loc4_.count,oEvent.target,-20);
            break;
         case "_ctrAlignment":
            this.gapi.showTooltip(this.api.datacenter.Player.alignment.name,oEvent.target,oEvent.target.height + 5);
            break;
         default:
            this.gapi.showTooltip(oEvent.target.contentData.name,oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function levelChanged(oEvent)
   {
      this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + String(oEvent.value);
   }
   function xpChanged(oEvent)
   {
      this._pbXP.minimum = this.api.datacenter.Player.XPlow;
      this._pbXP.maximum = this.api.datacenter.Player.XPhigh;
      this._pbXP.value = oEvent.value;
      this._mcXP.onRollOver = function()
      {
         this._parent.gapi.showTooltip(new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._pbXP.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
      };
      this._mcXP.onRollOut = function()
      {
         this._parent.gapi.hideTooltip();
      };
   }
   function lpChanged(oEvent)
   {
      this._lblLPValue.text = String(oEvent.value);
   }
   function lpMaxChanged(oEvent)
   {
      this._lblLPmaxValue.text = String(oEvent.value);
   }
   function apChanged(oEvent)
   {
      this._lblAPValue.text = String(Math.max(0,oEvent.value));
   }
   function mpChanged(oEvent)
   {
      this._lblMPValue.text = String(Math.max(0,oEvent.value));
   }
   function forceXtraChanged(oEvent)
   {
      this._lblForceValue.text = this.api.datacenter.Player.Force + (oEvent.value == 0?"":(oEvent.value <= 0?" (":" (+") + String(oEvent.value) + ")");
      this.updateCharacteristicButton(10);
   }
   function vitalityXtraChanged(oEvent)
   {
      this._lblVitalityValue.text = this.api.datacenter.Player.Vitality + (oEvent.value == 0?"":(oEvent.value <= 0?" (":" (+") + String(oEvent.value) + ")");
      this.updateCharacteristicButton(11);
   }
   function wisdomXtraChanged(oEvent)
   {
      this._lblWisdomValue.text = this.api.datacenter.Player.Wisdom + (oEvent.value == 0?"":(oEvent.value <= 0?" (":" (+") + String(oEvent.value) + ")");
      this.updateCharacteristicButton(12);
   }
   function chanceXtraChanged(oEvent)
   {
      this._lblChanceValue.text = this.api.datacenter.Player.Chance + (oEvent.value == 0?"":(oEvent.value <= 0?" (":" (+") + String(oEvent.value) + ")");
      this.updateCharacteristicButton(13);
   }
   function agilityXtraChanged(oEvent)
   {
      this._lblAgilityValue.text = this.api.datacenter.Player.Agility + (oEvent.value == 0?"":(oEvent.value <= 0?" (":" (+") + String(oEvent.value) + ")");
      this.updateCharacteristicButton(14);
   }
   function intelligenceXtraChanged(oEvent)
   {
      this._lblIntelligenceValue.text = this.api.datacenter.Player.Intelligence + (oEvent.value == 0?"":(oEvent.value <= 0?" (":" (+") + String(oEvent.value) + ")");
      this.updateCharacteristicButton(15);
   }
   function bonusPointsChanged(oEvent)
   {
      this._lblCapitalValue.text = String(oEvent.value);
   }
   function energyChanged(oEvent)
   {
      if(this.api.datacenter.Basics.aks_current_server.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
      {
         this._mcEnergy.onRollOver = function()
         {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(Math.max(10000,this._parent._pbEnergy.maximum)).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
         };
         this._mcEnergy.onRollOut = function()
         {
            this._parent.gapi.hideTooltip();
         };
         this._pbEnergy.maximum = this.api.datacenter.Player.EnergyMax;
         this._pbEnergy.value = oEvent.value;
      }
      else
      {
         this._pbEnergy._alpha = 50;
         this._pbEnergy.enabled = false;
      }
   }
   function energyMaxChanged(oEvent)
   {
      this._pbEnergy.maximum = oEvent.value;
   }
   function alignmentChanged(oEvent)
   {
      this._ctrAlignment.contentPath = oEvent.alignment.iconFile;
   }
   function initiativeChanged(oEvent)
   {
      this._lblInitiativeValue.text = String(oEvent.value);
   }
   function discernmentChanged(oEvent)
   {
      this._lblDiscernmentValue.text = String(oEvent.value);
   }
   function stateChanged(oEvent)
   {
      this.activateBoostButtons(!(oEvent.value > 1 && oEvent.value != undefined));
   }
}
