class ank.utils.rss.RSSChannel
{
	function RSSChannel()
	{
		this.initialize();
	}
	function parse(loc2)
	{
		this.initialize();
		if(loc2.nodeName.toLowerCase() != "channel")
		{
			return false;
		}
		var loc3 = loc2.firstChild;
		while(loc3 != null)
		{
			loop1:
			switch(loc3.nodeName.toLowerCase())
			{
				case "title":
					this._sTitle = loc3.childNodes.join("");
					break;
				case "link":
					this._sLink = loc3.childNodes.join("");
					break;
				case "description":
					this._sDescription = loc3.childNodes.join("");
					break;
				case "language":
					this._sLanguage = loc3.childNodes.join("");
					break;
				default:
					switch(null)
					{
						case "pubdate":
							this._sPubDate = loc3.childNodes.join("");
							this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E, d MMM yyyy H:m:s");
							break loop1;
						case "lastbuilddate":
							this._sLastBuildDate = loc3.childNodes.join("");
							this._dLastBuildDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sLastBuildDate.substr(0,25),"E, d MMM yyyy H:m:s");
							break loop1;
						case "docs":
							this._sDocs = loc3.childNodes.join("");
							break loop1;
						case "generator":
							this._sGenerator = loc3.childNodes.join("");
							break loop1;
						case "managingeditor":
							this._sManagingEditor = loc3.childNodes.join("");
							break loop1;
						default:
							switch(null)
							{
								case "webmaster":
									this._sWebMaster = loc3.childNodes.join("");
									break;
								case "item":
									var loc4 = new ank.utils.rss.();
									if(loc4.parse(loc3))
									{
										this._aItems.push(loc4);
										break;
									}
							}
					}
			}
			loc3 = loc3.nextSibling;
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
	function getPubDateStr(loc2, loc3)
	{
		return this._dPubDate != null?org.utils.SimpleDateFormatter.formatDate(this._dPubDate,loc2,loc3):this._sPubDate;
	}
	function getLastBuildDate()
	{
		return this._dLastBuildDate;
	}
	function getLastBuildDateStr(loc2, loc3)
	{
		return this._dLastBuildDate != null?org.utils.SimpleDateFormatter.formatDate(this._dLastBuildDate,loc2,loc3):this._sLastBuildDate;
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
	function parseDate(loc2)
	{
		return new Date();
	}
}
