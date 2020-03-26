class ank.utils.XMLLoader extends Object
{
   function XMLLoader()
   {
      super();
      this.initialize();
   }
   function initialize()
   {
      mx.events.EventDispatcher.initialize(this);
   }
   function loadXML(file)
   {
      this._xmlDoc = new XML();
      this._xmlDoc.ignoreWhite = true;
      var _owner = this;
      this._xmlDoc.onLoad = function(bSuccess)
      {
         if(bSuccess)
         {
            _owner.dispatchEvent({type:"onXMLLoadComplete",value:this});
         }
         else
         {
            _owner.dispatchEvent({type:"onXMLLoadError"});
         }
      };
      this._xmlDoc.load(file);
   }
}
