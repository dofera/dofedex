class ank.utils.rss.RSSLoader extends XML
{
   function RSSLoader()
   {
      super();
      mx.events.EventDispatcher.initialize(this);
      this.ignoreWhite = true;
      this.initialize();
   }
   function __get__data()
   {
      return this._oData;
   }
   function getChannels()
   {
      return this._aChannels;
   }
   function load(sUrl, oData)
   {
      super.load(sUrl);
      this._oData = oData;
   }
   function initialize()
   {
      this._aChannels = new Array();
   }
   function parse()
   {
      this.initialize();
      if(this.childNodes.length == 0)
      {
         return false;
      }
      var _loc2_ = this.firstChild;
      if(_loc2_.nodeName.toLowerCase() != "rss")
      {
         return false;
      }
      var _loc3_ = _loc2_.firstChild;
      while(_loc3_ != null)
      {
         if(_loc3_.nodeName.toLowerCase() == "channel")
         {
            var _loc4_ = new ank.utils.rss.RSSChannel();
            if(_loc4_.parse(_loc3_))
            {
               this._aChannels.push(_loc4_);
            }
         }
         _loc3_ = _loc3_.nextSibling;
      }
      return true;
   }
   function onLoad(bSuccess)
   {
      if(bSuccess)
      {
         if(this.parse())
         {
            this.dispatchEvent({type:"onRSSLoaded",data:this._oData});
         }
         else
         {
            this.dispatchEvent({type:"onBadRSSFile",data:this._oData});
         }
      }
      else
      {
         this.dispatchEvent({type:"onRSSLoadError",data:this._oData});
      }
   }
}
