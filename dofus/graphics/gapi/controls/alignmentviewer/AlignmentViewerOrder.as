class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerOrder extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "AlignmentViewerOrder";
   function AlignmentViewerOrder()
   {
      super();
   }
   function __set__specialization(oSpec)
   {
      this._oSpec = oSpec;
      if(this.initialized)
      {
         this.initData();
      }
      return this.__get__specialization();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerOrder.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._lblInfos.text = this.api.lang.getText("PLAYER_SPECIALIZATION");
   }
   function initData()
   {
      if(this._oSpec != undefined)
      {
         this._lblSpecializationName.text = this._oSpec.name;
         this._lblOrderName.text = this._oSpec.order.name;
         this._ldrIcon.contentPath = this._oSpec.order.iconFile;
         this._txtSpecializationDescription.text = this._oSpec.description;
      }
   }
}
