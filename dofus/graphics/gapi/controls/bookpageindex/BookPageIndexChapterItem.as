class dofus.graphics.gapi.controls.bookpageindex.BookPageIndexChapterItem extends ank.gapi.core.UIBasicComponent
{
   function BookPageIndexChapterItem()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblPageNum.text = !bUsed?"":oItem[4];
         var _loc5_ = this._lblPageNum.textWidth;
         this._lblChapter.text = !bUsed?"":oItem[0];
         this._lblChapter.setSize(this.__width - _loc5_ - 30,this.__height);
      }
      else if(this._lblPageNum.text != undefined)
      {
         this._lblPageNum.text = "";
         this._lblChapter.text = "";
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.arrange();
   }
   function size()
   {
      super.size();
      this.addToQueue({object:this,method:this.arrange});
   }
   function arrange()
   {
      this._lblChapter.setSize(this.__width - 50,this.__height);
      this._lblPageNum.setSize(this.__width - 20,this.__height);
   }
}
