class ank.utils.rss.RSSItem
{
   function RSSItem()
   {
   }
   function parse(xItemNode)
   {
      this.initialize();
      if(xItemNode.nodeName.toLowerCase() != "item")
      {
         return false;
      }
      var _loc3_ = xItemNode.firstChild;
      while(_loc3_ != null)
      {
         switch(_loc3_.nodeName.toLowerCase())
         {
            case "title":
               this._sTitle = _loc3_.childNodes.join("");
               var _loc4_ = this._sTitle.split("&apos;");
               this._sTitle = _loc4_.join("\'");
               break;
            case "link":
               this._sLink = _loc3_.childNodes.join("");
               break;
            case "pubdate":
               this._sPubDate = _loc3_.childNodes.join("");
               this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E, d MMM yyyy H:m:s");
               if(this._dPubDate == null)
               {
                  this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E,  d MMM yyyy H:m:s");
               }
               this.sortByDate = org.utils.SimpleDateFormatter.formatDate(this._dPubDate,"yyyyMMdd");
               break;
            case "guid":
               this._sGuid = _loc3_.childNodes.join("");
               break;
            case "icon":
               this._sIcon = _loc3_.childNodes.join("");
         }
         _loc3_ = _loc3_.nextSibling;
      }
      return true;
   }
   function toString()
   {
      return "RSSItem title:" + this._sTitle + "\tlink:" + this._sLink + "\tpubdate:" + this._dPubDate + "\tguid:" + this._sGuid;
   }
   function getTitle()
   {
      return this._sTitle;
   }
   function getLink()
   {
      return this._sLink;
   }
   function getPubDate()
   {
      return this._dPubDate;
   }
   function getPubDateStr(sFormat, sLanguage)
   {
      return this._dPubDate != null?org.utils.SimpleDateFormatter.formatDate(this._dPubDate,sFormat,sLanguage):this._sPubDate;
   }
   function getGuid()
   {
      return this._sGuid;
   }
   function getIcon()
   {
      return this._sIcon;
   }
   function initialize()
   {
      this._sTitle = "";
      this._sLink = "";
      this._dPubDate = null;
      this._sGuid = "";
   }
}
