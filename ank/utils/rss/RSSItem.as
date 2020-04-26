class ank.utils.rss.RSSItem
{
	function RSSItem()
	{
	}
	function parse(loc2)
	{
		this.initialize();
		if(loc2.nodeName.toLowerCase() != "item")
		{
			return false;
		}
		var loc3 = loc2.firstChild;
		while(loc3 != null)
		{
			switch(loc3.nodeName.toLowerCase())
			{
				case "title":
					this._sTitle = loc3.childNodes.join("");
					var loc4 = this._sTitle.split("&apos;");
					this._sTitle = loc4.join("\'");
					break;
				case "link":
					this._sLink = loc3.childNodes.join("");
					break;
				case "pubdate":
					this._sPubDate = loc3.childNodes.join("");
					this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E, d MMM yyyy H:m:s");
					if(this._dPubDate == null)
					{
						this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E,  d MMM yyyy H:m:s");
					}
					this.sortByDate = org.utils.SimpleDateFormatter.formatDate(this._dPubDate,"yyyyMMdd");
					break;
				case "guid":
					this._sGuid = loc3.childNodes.join("");
					break;
				case "icon":
					this._sIcon = loc3.childNodes.join("");
			}
			loc3 = loc3.nextSibling;
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
	function getPubDateStr(loc2, loc3)
	{
		return this._dPubDate != null?org.utils.SimpleDateFormatter.formatDate(this._dPubDate,loc2,loc3):this._sPubDate;
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
