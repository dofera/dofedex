class dofus.graphics.gapi.ui.HistoryViewerOnCreate extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "HistoryViewerOnCreate";
   function HistoryViewerOnCreate()
   {
      super();
   }
   function __get__breed()
   {
      return this._nBreed;
   }
   function __set__breed(n)
   {
      this._nBreed = n;
      return this.__get__breed();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.HistoryViewerOnCreate.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initText});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function initText()
   {
      this._lblBreedHistory.text = this.api.lang.getText("HISTORY_CLASS_WORD");
      this._lblBreedName.text = this.api.lang.getClassText(this._nBreed).sn;
      this._txtHistoryDescription.text = this.api.lang.getClassText(this._nBreed).d;
      this._ldrClassBg.content._alpha = 50;
      this._ldrClassBg.contentPath = dofus.Constants.BREEDS_BACK_PATH + this._nBreed + ".swf";
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose.addEventListener("over",this);
      this._btnClose.addEventListener("out",this);
      this._bhClose.addEventListener("click",this);
      this._mcWindowBg.onRelease = function()
      {
      };
      this._mcWindowBg.useHandCursor = false;
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._bhClose:
         case this._btnClose:
            this.unloadThis();
      }
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnClose)
      {
         this.gapi.showTooltip(this.api.lang.getText("CLOSE"),oEvent.target,-20);
      }
   }
}
