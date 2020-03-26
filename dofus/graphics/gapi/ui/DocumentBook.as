class dofus.graphics.gapi.ui.DocumentBook extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "DocumentBook";
   function DocumentBook()
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
      super.init(false,dofus.graphics.gapi.ui.DocumentBook.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
   }
   function callClose()
   {
      this.api.network.Documents.leave();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.setLeftPageNumber,params:[0]});
      this._btnPrevious._visible = false;
      this._btnNext._visible = false;
      this._btnAskPageLeft.enabled = false;
      this._btnAskPageRight.enabled = false;
   }
   function addListeners()
   {
      this._btnPrevious.addEventListener("click",this);
      this._btnPrevious.addEventListener("over",this);
      this._btnPrevious.addEventListener("out",this);
      this._btnNext.addEventListener("click",this);
      this._btnNext.addEventListener("over",this);
      this._btnNext.addEventListener("out",this);
      this._btnClose.addEventListener("click",this);
      this._btnAskPageLeft.addEventListener("click",this);
      this._btnAskPageRight.addEventListener("click",this);
      this._btnAskPageLeft.addEventListener("over",this);
      this._btnAskPageRight.addEventListener("over",this);
      this._btnAskPageLeft.addEventListener("out",this);
      this._btnAskPageRight.addEventListener("out",this);
   }
   function setLeftPageNumber(nPageNum)
   {
      if(this._oDoc == undefined)
      {
         return undefined;
      }
      this._nCurrentLeftPageNum = nPageNum;
      var _loc3_ = this._oDoc.getPage(nPageNum);
      var _loc4_ = this._oDoc.getPage(nPageNum + 1);
      this.layoutContent(_loc3_,true);
      this.layoutContent(_loc4_,false);
      this._btnPrevious._visible = nPageNum > 0;
      this._btnNext._visible = nPageNum + 2 < this._oDoc.pageCount;
   }
   function layoutContent(oPage, bLeft)
   {
      var _loc4_ = !bLeft?"_mcRightRenderer":"_mcLeftRenderer";
      var _loc5_ = !bLeft?this._mcRightPlacer:this._mcLeftPlacer;
      this[_loc4_].removeMovieClip();
      switch(oPage.type)
      {
         case "title":
            this.attachMovie("BookPageTitle",_loc4_,this.getNextHighestDepth(),{_x:_loc5_._x,_y:_loc5_._y,page:oPage});
            break;
         case "index":
            this.attachMovie("BookPageIndex",_loc4_,this.getNextHighestDepth(),{_x:_loc5_._x,_y:_loc5_._y,page:oPage});
            this[_loc4_].addEventListener("chapterChange",this);
            break;
         case "text":
            this.attachMovie("BookPageText",_loc4_,this.getNextHighestDepth(),{_x:_loc5_._x,_y:_loc5_._y,page:oPage});
            break;
         case "blank":
      }
      if(bLeft)
      {
         this._lblLeftPageNum.text = oPage.num != undefined?oPage.num:"";
         this._btnAskPageLeft.enabled = oPage.num != undefined;
      }
      else
      {
         this._lblRightPageNum.text = oPage.num != undefined?oPage.num:"";
         this._btnAskPageRight.enabled = oPage.num != undefined;
      }
   }
   function askPage(nPageNum)
   {
      var _loc3_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:nPageNum,max:nPageNum});
      _loc3_.addEventListener("validate",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnPrevious":
            this.setLeftPageNumber(this._nCurrentLeftPageNum - 2);
            break;
         case "_btnNext":
            this.setLeftPageNumber(this._nCurrentLeftPageNum + 2);
            break;
         case "_btnClose":
            this.callClose();
            break;
         case "_btnAskPageLeft":
            this.askPage(1);
            break;
         case "_btnAskPageRight":
            this.askPage(this._oDoc.pageCount - 1);
      }
   }
   function chapterChange(oEvent)
   {
      var _loc3_ = oEvent.pageNum % 2 != 0?oEvent.pageNum - 1:oEvent.pageNum;
      this.setLeftPageNumber(_loc3_);
   }
   function validate(oEvent)
   {
      var _loc3_ = Number(oEvent.value);
      if(_global.isNaN(_loc3_))
      {
         _loc3_ = 1;
      }
      if(_loc3_ < 1)
      {
         _loc3_ = 1;
      }
      if(_loc3_ >= this._oDoc.pageCount)
      {
         _loc3_ = this._oDoc.pageCount - 1;
      }
      var _loc4_ = _loc3_ % 2 != 0?_loc3_ - 1:_loc3_;
      this.setLeftPageNumber(_loc4_);
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnPrevious":
            this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_PAGE"),oEvent.target,-20);
            break;
         case "_btnNext":
            this.gapi.showTooltip(this.api.lang.getText("NEXT_PAGE"),oEvent.target,-20);
            break;
         default:
            this.gapi.showTooltip(this.api.lang.getText("CHOOSE_PAGE_NUMBER"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
