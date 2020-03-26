class dofus.graphics.gapi.controls.questionviewer.QuestionViewerAnswerItem extends ank.gapi.core.UIBasicComponent
{
   function QuestionViewerAnswerItem()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._mcRound._visible = true;
         this._txtResponse.text = oItem.label;
      }
      else if(this._txtResponse.text != undefined)
      {
         this._mcRound._visible = false;
         this._txtResponse.text = "";
      }
   }
   function init()
   {
      super.init(false);
      this._mcRound._visible = false;
   }
   function size()
   {
      super.size();
   }
}
