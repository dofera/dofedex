class dofus.graphics.gapi.controls.QuestStepListViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "QuestStepListViewer";
   function QuestStepListViewer()
   {
      super();
   }
   function __set__steps(eaSteps)
   {
      this._eaSteps = eaSteps;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__steps();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.QuestStepListViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._lstSteps.addEventListener("itemSelected",this);
   }
   function initTexts()
   {
      this._lblSteps.text = this.api.lang.getText("QUESTS_ALL_STEPS");
   }
   function updateData()
   {
      if(this._eaSteps != undefined)
      {
         this._lstSteps.dataProvider = this._eaSteps;
         var _loc2_ = 0;
         while(_loc2_ < this._eaSteps.length)
         {
            if(this._eaSteps[_loc2_].isCurrent)
            {
               this._lstSteps.selectedIndex = _loc2_;
               this._txtDescription.text = this._eaSteps[_loc2_].description;
               break;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.row.item;
      this._txtDescription.text = _loc3_.description;
   }
}
