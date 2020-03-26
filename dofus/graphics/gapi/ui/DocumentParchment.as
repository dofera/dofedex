class dofus.graphics.gapi.ui.DocumentParchment extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "DocumentParchment";
   function DocumentParchment()
   {
      super();
   }
   function __set__document(oDoc)
   {
      this._oDoc = oDoc;
      return this.__get__document();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.DocumentParchment.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Documents.leave();
      return true;
   }
   function createChildren()
   {
      this._txtCore.wordWrap = true;
      this._txtCore.multiline = true;
      this._txtCore.embedFonts = true;
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._bgHidder.addEventListener("click",this);
   }
   function updateData()
   {
      this.setCssStyle(this._oDoc.getPage(0).cssFile);
      if(this._lblTitle.text == undefined)
      {
         return undefined;
      }
      if(this._oDoc.title.substr(0,2) == "//")
      {
         this._lblTitle.text = "";
      }
      else
      {
         this._lblTitle.text = this._oDoc.title;
      }
   }
   function setCssStyle(sCssFile)
   {
      var _loc3_ = new TextField.StyleSheet();
      _loc3_.owner = this;
      _loc3_.onLoad = function()
      {
         this.owner.layoutContent(this);
      };
      _loc3_.load(sCssFile);
   }
   function layoutContent(ssStyle)
   {
      this._txtCore.styleSheet = ssStyle;
      this._txtCore.htmlText = this._oDoc.getPage(0).text;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_bgHidder":
         case "_btnClose":
            this.callClose();
      }
   }
   function onHref(sParams)
   {
      var _loc3_ = sParams.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1].split(";");
      if(!_global.isNaN(_loc4_))
      {
         this.api.network.GameActions.sendActions(_loc4_,_loc5_);
         this.api.network.Documents.leave();
      }
   }
}
