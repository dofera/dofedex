class dofus.graphics.gapi.ui.PayZoneDialog extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "PayZoneDialog";
   static var PAYZONE_INFOS = 1;
   static var PAYZONE_DETAILS = 2;
   static var PAYZONE_YES = 0;
   static var PAYZONE_NO = 1;
   static var PAYZONE_BE_MEMBER = 2;
   static var PAYZONE_MORE_INFOS = 4;
   function PayZoneDialog()
   {
      super();
   }
   function __set__id(nNpcID)
   {
      this._nNpcID = nNpcID;
      return this.__get__id();
   }
   function __set__name(sName)
   {
      this._sName = sName;
      return this.__get__name();
   }
   function __set__gfx(sGfx)
   {
      this._sGfx = sGfx;
      return this.__get__gfx();
   }
   function __set__dialogID(nDialogID)
   {
      this._nDialogID = nDialogID;
      this.addToQueue({object:this,method:this.setDialog,params:[nDialogID]});
      return this.__get__dialogID();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.PayZoneDialog.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Dialog.leave();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.setNpcCharacteristics});
      this.gapi.unloadLastUIAutoHideComponent();
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
   }
   function setNpcCharacteristics()
   {
      this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._sGfx + ".swf";
      this._winBackgroundUp.title = this._sName;
   }
   function setDialog(nIndex)
   {
      var _loc3_ = new Object();
      _loc3_.responses = new ank.utils.ExtendedArray();
      switch(nIndex)
      {
         case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_INFOS:
            _loc3_.label = this.api.lang.getText("PAYZONE_INFOS");
            _loc3_.responses.push({label:this.api.lang.getText("YES"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES});
            _loc3_.responses.push({label:this.api.lang.getText("NO"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO});
            break;
         case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS:
            _loc3_.label = this.api.lang.getText("PAYZONE_DETAILS");
            _loc3_.responses.push({label:this.api.lang.getText("PAYZONE_BE_MEMBER"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER});
            break;
         default:
            _loc3_.label = this.api.lang.getText("PAYZONE_MSG_" + this._nDialogID) + "\n\n" + this.api.lang.getText("PAYZONE_BASE");
            _loc3_.responses.push({label:this.api.lang.getText("PAYZONE_MORE_INFOS"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS});
      }
      this.setQuestion(_loc3_);
   }
   function setQuestion(oQuestion)
   {
      if(this._qvQuestionViewer == undefined)
      {
         this.attachMovie("QuestionViewer","_qvQuestionViewer",10,{_x:this._mcQuestionViewer._x,_y:this._mcQuestionViewer._y,question:oQuestion,isFirstQuestion:true});
         this._qvQuestionViewer.addEventListener("response",this);
         this._qvQuestionViewer.addEventListener("resize",this);
      }
      else
      {
         this._qvQuestionViewer.isFirstQuestion = true;
         this._qvQuestionViewer.question = oQuestion;
      }
   }
   function closeDialog()
   {
      this.callClose();
   }
   function response(oEvent)
   {
      switch(oEvent.response.id)
      {
         case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES:
            this.setDialog(dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS);
            break;
         case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO:
            this.unloadThis();
            break;
         case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER:
            this.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
            this.unloadThis();
            break;
         case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS:
            this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"),"_blank");
            this.unloadThis();
      }
   }
   function resize(oEvent)
   {
      this._winBackground.setSize(undefined,oEvent.target.height + (oEvent.target._y - this._winBackground._y) + 12);
      this._winBackgroundUp.setSize(undefined,oEvent.target.height + (oEvent.target._y - this._winBackground._y) + 10);
   }
}
