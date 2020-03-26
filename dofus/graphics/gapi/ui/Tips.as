class dofus.graphics.gapi.ui.Tips extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Tips";
   var _bSOEnabled = true;
   var _nCurrentID = 0;
   function Tips()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Tips.CLASS_NAME);
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
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.showTip});
   }
   function initTexts()
   {
      this._winBg.title = this.api.lang.getText("TIPS");
      this._btnClose2.label = this.api.lang.getText("CLOSE");
      this._lblTipsOnStart.text = this.api.lang.getText("SHOW_TIPS_ON_STARTUP");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
      this._btnTipsOnStart.addEventListener("click",this);
      this._btnNext.addEventListener("click",this);
      this._btnPrevious.addEventListener("click",this);
      this._btnTipsOnStartTooltip.addEventListener("over",this);
      this._btnTipsOnStartTooltip.addEventListener("out",this);
   }
   function initData()
   {
      var _loc2_ = SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
      _loc2_._parentRef = this;
      _loc2_.onStatus = function(oEvent)
      {
         if(oEvent.level == "status" && oEvent.code == "SharedObject.Flush.Success")
         {
            this._parentRef._btnTipsOnStart._visible = true;
            this._parentRef._lblTipsOnStart._visible = true;
            this._parentRef._btnTipsOnStart.enabled = true;
            this._parentRef._btnTipsOnStartTooltip._visible = false;
            this._parentRef._bSOEnabled = true;
         }
      };
      if(SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
      {
         this._btnTipsOnStart.enabled = false;
         this._btnTipsOnStart.selected = false;
         this._bSOEnabled = false;
      }
      else
      {
         this._btnTipsOnStartTooltip._visible = false;
         this._btnTipsOnStart.selected = this.api.kernel.OptionsManager.getOption("TipsOnStart");
      }
   }
   function showTip(nID)
   {
      var _loc3_ = this.api.lang.getTips().length - 1;
      if(nID == undefined)
      {
         nID = random(_loc3_);
      }
      if(nID > _loc3_)
      {
         nID = 0;
      }
      if(nID < 0)
      {
         nID = _loc3_;
      }
      this._nCurrentID = nID;
      var _loc4_ = this.api.lang.getTip(nID);
      if(_loc4_ != undefined)
      {
         this._txtTip.text = _loc4_;
      }
      else
      {
         this.unloadThis();
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnClose2":
            this.callClose();
            break;
         case "_btnTipsOnStart":
            this.api.kernel.OptionsManager.setOption("TipsOnStart",oEvent.target.selected);
            break;
         case "_btnPrevious":
            this.showTip(this._nCurrentID - 1);
            break;
         case "_btnNext":
            this.showTip(this._nCurrentID + 1);
      }
   }
   function over(oEvent)
   {
      if(this._bSOEnabled == false)
      {
         this.gapi.showTooltip("Les cookies flash doivent être activés pour accèder à cette fonctionnalité.",this._btnTipsOnStart,-30);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
