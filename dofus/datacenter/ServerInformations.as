class dofus.datacenter.ServerInformations extends Object
{
   function ServerInformations()
   {
      super();
      this.initialize();
   }
   function __get__problems()
   {
      return this._pProblems;
   }
   function __get__isOnFocus()
   {
      return this._bOnFocus;
   }
   function load()
   {
      var _loc2_ = this.api.lang.getConfigText("PROBLEMS_LINK");
      var _loc3_ = new ank.utils.XMLLoader();
      _loc3_.addEventListener("onXMLLoadComplete",this);
      _loc3_.addEventListener("onXMLLoadError",this);
      _loc3_.loadXML(_loc2_);
      this.dispatchEvent({type:"onLoadStarted"});
   }
   function initialize()
   {
      this.api = _global.API;
      mx.events.EventDispatcher.initialize(this);
   }
   function parseXml(xml)
   {
      this._pProblems = new Array();
      var _loc3_ = xml.firstChild;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.childNodes.length)
      {
         var _loc5_ = _loc3_.childNodes[_loc4_];
         var _loc6_ = Number(_loc5_.attributes.id);
         var _loc7_ = Number(_loc5_.attributes.date);
         var _loc8_ = Number(_loc5_.attributes.type);
         var _loc9_ = Number(_loc5_.attributes.state);
         var _loc10_ = _loc5_.attributes.visible == "true";
         this._bOnFocus = this._bOnFocus || _loc10_;
         var _loc11_ = _loc5_.childNodes[0];
         var _loc12_ = new Array();
         if(_loc11_.attributes.cnx == "true")
         {
            _loc12_.push(this.api.lang.getText("CONNECTION_SERVER"));
         }
         if(_loc11_.attributes.all == "true")
         {
            _loc12_.push(this.api.lang.getText("EVERY_SERVERS"));
         }
         else
         {
            var _loc13_ = 0;
            while(_loc13_ < _loc11_.childNodes.length)
            {
               _loc12_.push(_loc11_.childNodes[_loc13_].attributes.name);
               _loc13_ = _loc13_ + 1;
            }
         }
         var _loc14_ = _loc5_.childNodes[1];
         var _loc15_ = new Array();
         var _loc16_ = 0;
         while(_loc16_ < _loc14_.childNodes.length)
         {
            var _loc17_ = _loc14_.childNodes[_loc16_];
            var _loc18_ = Number(_loc17_.attributes.timestamp);
            var _loc19_ = Number(_loc17_.attributes.id);
            var _loc20_ = _loc17_.attributes.translated == "true";
            var _loc21_ = _loc17_.firstChild.nodeValue;
            var _loc22_ = new dofus.datacenter.ServerProblemEvent(_loc18_,_loc19_,_loc20_,_loc21_);
            _loc15_.push(_loc22_);
            _loc16_ = _loc16_ + 1;
         }
         var _loc23_ = new dofus.datacenter.ServerProblem(_loc6_,_loc7_,_loc8_,_loc9_,_loc12_,_loc15_);
         this._pProblems.push(_loc23_);
         _loc4_ = _loc4_ + 1;
      }
      this.dispatchEvent({type:"onData"});
   }
   function onXMLLoadComplete(oEvent)
   {
      var _loc3_ = oEvent.value;
      this.parseXml(_loc3_);
   }
   function onXMLLoadError()
   {
      this.dispatchEvent({type:"onLoadError"});
   }
}
