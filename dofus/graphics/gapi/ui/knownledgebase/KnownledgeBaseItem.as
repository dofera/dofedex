class dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseItem extends ank.gapi.core.UIBasicComponent
{
   function KnownledgeBaseItem()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblItem.text = oItem.n;
         var _loc5_ = oItem.c == undefined;
         this._mcCategory._visible = _loc5_;
         this._mcArticle._visible = !_loc5_;
         if(!_loc5_ && !this._bWasArticle)
         {
            this._lblItem._x = this._lblItem._x + 10;
            this._mcArticle._x = this._mcArticle._x + 10;
            this._bWasArticle = true;
         }
      }
      else if(this._lblItem.text != undefined)
      {
         this._lblItem.text = "";
         this._mcArticle._visible = false;
         this._mcCategory._visible = false;
         if(this._bWasArticle)
         {
            this._lblItem._x = this._lblItem._x - 10;
            this._mcArticle._x = this._mcArticle._x - 10;
            this._bWasArticle = false;
         }
      }
   }
   function KnownledgeBaseCategoryItem()
   {
      this._mcArticle._visible = false;
      this._mcCategory._visible = false;
   }
   function init()
   {
      super.init(false);
   }
}
