class dofus.graphics.gapi.ui.Cinematic extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Cinematic";
   function Cinematic()
   {
      super();
   }
   function __set__file(sFile)
   {
      this._sFile = sFile;
      return this.__get__file();
   }
   function __set__sequencer(oSequencer)
   {
      this._oSequencer = oSequencer;
      return this.__get__sequencer();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Cinematic.CLASS_NAME);
   }
   function destroy()
   {
      _root._quality = this._sOldQuality;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.loadFile});
   }
   function startCinematic(mcCinematic)
   {
      mcCinematic.gotoAndPlay(1);
   }
   function addListeners()
   {
      this._ldrLoader.addEventListener("initialization",this);
      this._ldrLoader.addEventListener("complete",this);
      this._btnCancel.addEventListener("click",this);
      this._btnCancel.addEventListener("over",this);
      this._btnCancel.addEventListener("out",this);
   }
   function loadFile()
   {
      this._ldrLoader.contentPath = this._sFile;
      this._sOldQuality = _root._quality;
      _root._quality = "MEDIUM";
      this._lblWhite.text = this.api.lang.getText("LOADING");
   }
   function initialization(oEvent)
   {
      this._lblWhite._visible = false;
      oEvent.target.content.cinematic = this;
      this.addToQueue({object:this,method:this.startCinematic,params:[oEvent.target.content]});
   }
   function complete(oEvent)
   {
      oEvent.target.stop();
      oEvent.target.content.stop();
      oEvent.target.content.cinematic.stop();
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnCancel)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_CINEMATIC"),"CAUTION_YESNO",{name:"Cinematic",listener:this});
      }
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnCancel)
      {
         this.gapi.showTooltip(this.api.lang.getText("CANCEL_CINEMATIC"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function onCinematicFinished()
   {
      this.dispatchEvent({type:"cinematicFinished"});
      this._oSequencer.onActionEnd();
      _root._quality = this._sOldQuality;
      this.unloadThis();
   }
   function onSubtitle(tfSubtitle, nSubtitle)
   {
      var _loc4_ = this._sFile.substring(0,this._sFile.toLowerCase().indexOf(".swf"));
      while(_loc4_.indexOf("/") > -1)
      {
         _loc4_ = _loc4_.substr(_loc4_.indexOf("/") + 1);
      }
      var _loc5_ = Number(_loc4_);
      var _loc6_ = this.api.lang.getSubtitle(_loc5_,nSubtitle);
      if(_loc6_ != undefined)
      {
         tfSubtitle.text = _loc6_;
      }
   }
   function yes(oEvent)
   {
      this.onCinematicFinished();
   }
}
