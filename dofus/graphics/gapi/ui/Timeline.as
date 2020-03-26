class dofus.graphics.gapi.ui.Timeline extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Timeline";
   function Timeline()
   {
      super();
   }
   function update()
   {
      this._tl.update();
   }
   function nextTurn(id, bWithoutTween)
   {
      this._tl.nextTurn(id,bWithoutTween);
   }
   function __get__timelineControl()
   {
      return this._tl;
   }
   function hideItem(id)
   {
      this._tl.hideItem(id);
   }
   function showItem(id)
   {
      this._tl.showItem(id);
   }
   function startChrono(nDuration)
   {
      this._tl.startChrono(nDuration);
   }
   function stopChrono()
   {
      this._tl.stopChrono();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Timeline.CLASS_NAME);
   }
   function createChildren()
   {
   }
}
