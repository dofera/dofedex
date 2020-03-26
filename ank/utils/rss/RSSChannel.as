class ank.utils.rss.RSSChannel
{
   function RSSChannel()
   {
      this.initialize();
   }
   function parse(xChannelNode)
   {
      this.initialize();
      if(xChannelNode.nodeName.toLowerCase() != "channel")
      {
         return false;
      }
      var _loc3_ = xChannelNode.firstChild;
      while(_loc3_ != null)
      {
         switch(_loc3_.nodeName.toLowerCase())
         {
            case "title":
               this._sTitle = _loc3_.childNodes.join("");
               break;
            case "link":
               this._sLink = _loc3_.childNodes.join("");
               break;
            case "description":
               this._sDescription = _loc3_.childNodes.join("");
               break;
            case "language":
               this._sLanguage = _loc3_.childNodes.join("");
               break;
            case "pubdate":
               this._sPubDate = _loc3_.childNodes.join("");
               this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E, d MMM yyyy H:m:s");
               break;
            case "lastbuilddate":
               this._sLastBuildDate = _loc3_.childNodes.join("");
               this._dLastBuildDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sLastBuildDate.substr(0,25),"E, d MMM yyyy H:m:s");
               break;
            case "docs":
               this._sDocs = _loc3_.childNodes.join("");
               break;
            case "generator":
               this._sGenerator = _loc3_.childNodes.join("");
               break;
            case "managingeditor":
               this._sManagingEditor = _loc3_.childNodes.join("");
               break;
            case "webmaster":
               this._sWebMaster = _loc3_.childNodes.join("");
               break;
            case "item":
               var _loc4_ = new ank.utils.rss.RSSItem();
               if(_loc4_.parse(_loc3_))
               {
                  this._aItems.push(_loc4_);
               }
         }
         _loc3_ = _loc3_.nextSibling;
      }
      return true;
   }
   function toString()
   {
      return "RSSChannel title:" + this._sTitle + "\tlink:" + this._sLink + "\tdescription:" + this._dPubDate + "\tlanguage:" + this._dPubDate + "\tpubdate:" + this._dPubDate + "\tlastbuilddate:" + this._dPubDate + "\tdocs:" + this._dPubDate + "\tgenerator:" + this._dPubDate + "\tmanagingeditor:" + this._dPubDate + "\twebmaster:" + this._dPubDate + "\titems:" + this._aItems.join("\n");
   }
   function getTitle()
   {
      return this._sTitle;
   }
   function getLink()
   {
      return this._sLink;
   }
   function getDescription()
   {
      return this._sDescription;
   }
   function getLanguage()
   {
      return this._sLanguage;
   }
   function getPubDate()
   {
      return this._dPubDate;
   }
   function getPubDateStr(sFormat, sLanguage)
   {
      return this._dPubDate != null?org.utils.SimpleDateFormatter.formatDate(this._dPubDate,sFormat,sLanguage):this._sPubDate;
   }
   function getLastBuildDate()
   {
      return this._dLastBuildDate;
   }
   function getLastBuildDateStr(sFormat, sLanguage)
   {
      return this._dLastBuildDate != null?org.utils.SimpleDateFormatter.formatDate(this._dLastBuildDate,sFormat,sLanguage):this._sLastBuildDate;
   }
   function getDocs()
   {
      return this._sDocs;
   }
   function getGenerator()
   {
      return this._sGenerator;
   }
   function getManagingEditor()
   {
      return this._sManagingEditor;
   }
   function getWebMaster()
   {
      return this._sWebMaster;
   }
   function getItems()
   {
      return this._aItems;
   }
   function initialize()
   {
      this._sTitle = "";
      this._sLink = "";
      this._sDescription = "";
      this._sLanguage = "";
      this._dPubDate = null;
      this._dLastBuildDate = null;
      this._sDocs = "";
      this._sGenerator = "";
      this._sManagingEditor = "";
      this._sWebMaster = "";
      this._aItems = new Array();
   }
   function parseDate(sDate)
   {
      return new Date();
   }
}
