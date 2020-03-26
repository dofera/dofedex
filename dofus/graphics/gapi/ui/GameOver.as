class dofus.graphics.gapi.ui.GameOver extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "GameOver";
   function GameOver()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.GameOver.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initBg});
      this.addToQueue({object:this,method:this.initLol});
   }
   function initTexts()
   {
      this._lblReplay.text = this.api.lang.getText("REPLAY_WORD");
   }
   function addListeners()
   {
      var ref = this;
      this._btnReplay.onRelease = function()
      {
         ref.api.kernel.changeServer(true);
      };
   }
   function initBg()
   {
      this._ldrIllu.contentPath = dofus.Constants.ILLU_PATH + "gameover.swf";
   }
   function initLol()
   {
      this._mcLol._visible = Math.floor(Math.random() * 500) == 100;
      if(this._mcLol._visible)
      {
         this._mcLol._x = this._mcPlacer._x;
         this._mcLol._y = this._mcPlacer._y;
      }
   }
   function click(oEvent)
   {
      this.callClose();
   }
}
