class ank.gapi.ui.FlyWindow extends ank.gapi.core.UIAdvancedComponent
{
   static var CLASS_NAME = "FlyWindow";
   function FlyWindow()
   {
      super();
   }
   function __set__title(sTitle)
   {
      this.addToQueue({object:this,method:function()
      {
         this._winBackground.title = sTitle;
      }});
      return this.__get__title();
   }
   function __get__title()
   {
      return this._winBackground.title;
   }
   function __set__contentPath(sContentPath)
   {
      this.addToQueue({object:this,method:function()
      {
         this._winBackground.contentPath = sContentPath;
      }});
      return this.__get__contentPath();
   }
   function __get__contentPath()
   {
      return this._winBackground.contentPath;
   }
   function init()
   {
      super.init(false,ank.gapi.ui.FlyWindow.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._winBackground.addEventListener("complete",this);
   }
   function complete(oEvent)
   {
      this.addToQueue({object:this,method:this.initWindowContent});
   }
}
