class ank.utils.rss.RSSItem
{
	function RSSItem()
	{
	}
	function parse(var2)
	{
		this.initialize();
		if(var2.nodeName.toLowerCase() != "item")
		{
			return false;
		}
		var var3 = var2.firstChild;
		while(var3 != null)
		{
			switch(var3.nodeName.toLowerCase())
			{
				case "title":
					this._sTitle = var3.childNodes.join("");
					var var4 = this._sTitle.split("&apos;");
					this._sTitle = var4.join("\'");
					break;
				case "link":
					this._sLink = var3.childNodes.join("");
					break;
				case "pubdate":
					this._sPubDate = var3.childNodes.join("");
					this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E, d MMM yyyy H:m:s");
					if(this._dPubDate == null)
					{
						this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E,  d MMM yyyy H:m:s");
					}
					this.sortByDate = org.utils.SimpleDateFormatter.formatDate(this._dPubDate,"yyyyMMdd");
					break;
				default:
					switch(null)
					{
						case "guid":
							this._sGuid = var3.childNodes.join("");
							break;
						case "icon":
							this._sIcon = var3.childNodes.join("");
					}
			}
			var3 = var3.nextSibling;
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
	function getPubDateStr(var2, var3)
	{
		return this._dPubDate != null?org.utils.SimpleDateFormatter.formatDate(this._dPubDate,var2,var3):this._sPubDate;
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
