class dofus.graphics.gapi.controls.QuestStepViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "QuestStepViewer";
   function QuestStepViewer()
   {
      super();
   }
   function __set__step(oStep)
   {
      this._oStep = oStep;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__step();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.QuestStepViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.updateData});
      this._btnDialog._visible = false;
   }
   function addListeners()
   {
      this._btnDialog.addEventListener("click",this);
      this._btnDialog.addEventListener("over",this);
      this._btnDialog.addEventListener("out",this);
      this._lstObjectives.addEventListener("itemSelected",this);
   }
   function initTexts()
   {
      this._lblObjectives.text = this.api.lang.getText("QUESTS_OBJECTIVES");
      this._lblStep.text = this.api.lang.getText("STEP");
      this._lblRewards.text = this.api.lang.getText("QUESTS_REWARDS");
   }
   function updateData()
   {
      if(this._oStep != undefined)
      {
         this._lblStep.text = this.api.lang.getText("STEP") + " : " + this._oStep.name;
         this._txtDescription.text = this._oStep.description;
         this._lstObjectives.dataProvider = this._oStep.objectives;
         this._lstRewards.dataProvider = this._oStep.rewards;
         this._btnDialog._visible = this._oStep.dialogID != undefined;
      }
   }
   function over(oEvent)
   {
      var _loc3_ = this._oStep.dialogID;
      var _loc4_ = this._oStep.dialogParams;
      var _loc5_ = new dofus.datacenter.Question(_loc3_,undefined,_loc4_);
      this.gapi.showTooltip(this.api.lang.getText("STEP_DIALOG") + " :\n\n" + _loc5_.label,oEvent.target,20);
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function click(oEvent)
   {
      var _loc3_ = this._oStep.dialogID;
      var _loc4_ = this._oStep.dialogParams;
      var _loc5_ = new dofus.datacenter.Question(_loc3_,undefined,_loc4_);
      this.api.kernel.showMessage(this.api.lang.getText("STEP_DIALOG"),_loc5_.label,"ERROR_BOX");
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.row.item;
      if(_loc3_.x != undefined && _loc3_.y != undefined)
      {
         this.api.kernel.GameManager.updateCompass(_loc3_.x,_loc3_.y);
      }
   }
}
