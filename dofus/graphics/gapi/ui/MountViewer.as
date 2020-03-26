class dofus.graphics.gapi.ui.MountViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MountViewer";
   function MountViewer()
   {
      super();
   }
   function __set__mount(oMount)
   {
      this._oMount = oMount;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__mount();
   }
   function __get__mount()
   {
      return this._oMount;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.MountViewer.CLASS_NAME);
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
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
   }
   function updateData()
   {
      this._mvMountViewer.mount = this._oMount;
   }
   function initTexts()
   {
      this._btnClose.label = this.api.lang.getText("CLOSE");
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnClose)
      {
         this.callClose();
      }
   }
}
