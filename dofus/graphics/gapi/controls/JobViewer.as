class dofus.graphics.gapi.controls.JobViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "JobViewer";
   var _sCurrentTab = "Characteristics";
   function JobViewer()
   {
      super();
   }
   function __set__job(oJob)
   {
      this._oJob = oJob;
      this.addToQueue({object:this,method:this.layoutContent});
      return this.__get__job();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.JobViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this._lblNoTool._visible = false;
      this._mcPlacer._visible = false;
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function initTexts()
   {
      this._lblXP.text = this.api.lang.getText("EXPERIMENT");
      this._lblSkill.text = this.api.lang.getText("SKILLS");
      this._lblTool.text = this.api.lang.getText("TOOL");
      this._lblNoTool.text = this.api.lang.getText("NO_TOOL_JOB");
      this._btnTabCharacteristics.label = this.api.lang.getText("CHARACTERISTICS");
      this._btnTabCrafts.label = this.api.lang.getText("RECEIPTS");
      this._btnTabOptions.label = this.api.lang.getText("OPTIONS");
   }
   function addListeners()
   {
      this._btnTabCharacteristics.addEventListener("click",this);
      this._btnTabCrafts.addEventListener("click",this);
      this._btnTabOptions.addEventListener("click",this);
   }
   function layoutContent()
   {
      if(this._oJob == undefined)
      {
         return undefined;
      }
      this.setCurrentTab(this._sCurrentTab);
      this._lstSkills.removeMovieClip();
      var _loc2_ = this.api.datacenter.Player.currentJobID == this._oJob.id;
      this._ldrIcon.contentPath = this._oJob.iconFile;
      this._lblName.text = this._oJob.name;
      this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oJob.level;
      this._pbXP.minimum = this._oJob.xpMin;
      this._pbXP.maximum = this._oJob.xpMax;
      this._pbXP.value = this._oJob.xp;
      this._mcXP.onRollOver = function()
      {
         this._parent._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oJob.xp).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._oJob.xpMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
      };
      this._mcXP.onRollOut = function()
      {
         this._parent._parent.gapi.hideTooltip();
      };
      var _loc3_ = this._oJob.skills;
      if(_loc3_.length != 0)
      {
         _loc3_.sortOn("skillName");
         this._lstSkills.dataProvider = _loc3_;
      }
      if(_loc2_)
      {
         this._lblNoTool._visible = false;
         this._itvItemViewer._visible = true;
         var _loc4_ = this.api.datacenter.Player.Inventory.findFirstItem("position",1).item;
         this._itvItemViewer.itemData = _loc4_;
      }
      else
      {
         this._lblNoTool._visible = true;
         this._itvItemViewer._visible = false;
      }
   }
   function showCraftViewer(bShow)
   {
      if(bShow)
      {
         var _loc3_ = this.attachMovie("CraftViewer","_cvCraftViewer",20);
         _loc3_._x = this._mcPlacer._x;
         _loc3_._y = this._mcPlacer._y;
         _loc3_.job = this._oJob;
      }
      else
      {
         this._cvCraftViewer.removeMovieClip();
      }
   }
   function showOptionViewer(bShow)
   {
      if(bShow)
      {
         var _loc3_ = this.attachMovie("JobOptionsViewer","_jovJobOptionsViewer",20);
         _loc3_._x = this._mcPlacer._x;
         _loc3_._y = this._mcPlacer._y;
         _loc3_.job = this._oJob;
      }
      else
      {
         this._jovJobOptionsViewer.removeMovieClip();
      }
   }
   function updateCurrentTabInformations()
   {
      switch(this._sCurrentTab)
      {
         case "Characteristics":
            this.showOptionViewer(false);
            this.showCraftViewer(false);
            break;
         case "Crafts":
            this.showOptionViewer(false);
            this.showCraftViewer(true);
            break;
         case "Options":
            this.showCraftViewer(false);
            this.showOptionViewer(true);
      }
   }
   function setCurrentTab(sNewTab)
   {
      var _loc3_ = this["_btnTab" + this._sCurrentTab];
      var _loc4_ = this["_btnTab" + sNewTab];
      _loc3_.selected = true;
      _loc3_.enabled = true;
      _loc4_.selected = false;
      _loc4_.enabled = false;
      this._sCurrentTab = sNewTab;
      this.updateCurrentTabInformations();
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnTabCharacteristics":
            this.setCurrentTab("Characteristics");
            break;
         case "_btnTabCrafts":
            this.setCurrentTab("Crafts");
            break;
         case "_btnTabOptions":
            this.setCurrentTab("Options");
      }
   }
}
