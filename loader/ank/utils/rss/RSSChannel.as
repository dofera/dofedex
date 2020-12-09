class ank.utils.rss.RSSChannel
{
	function RSSChannel()
	{
		this.initialize();
	}
	function parse(§\x1e\n\x01§)
	{
		this.initialize();
		if(var2.nodeName.toLowerCase() != "channel")
		{
			return false;
		}
		var var3 = var2.firstChild;
		while(var3 != null)
		{
			loop1:
			switch(var3.nodeName.toLowerCase())
			{
				case "title":
					this._sTitle = var3.childNodes.join("");
					break;
				case "link":
					this._sLink = var3.childNodes.join("");
					break;
				case "description":
					this._sDescription = var3.childNodes.join("");
					break;
				default:
					switch(null)
					{
						case "language":
							this._sLanguage = var3.childNodes.join("");
							break loop1;
						case "pubdate":
							this._sPubDate = var3.childNodes.join("");
							this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0,25),"E, d MMM yyyy H:m:s");
							break loop1;
						case "lastbuilddate":
							this._sLastBuildDate = var3.childNodes.join("");
							this._dLastBuildDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sLastBuildDate.substr(0,25),"E, d MMM yyyy H:m:s");
							break loop1;
						case "docs":
							this._sDocs = var3.childNodes.join("");
							break loop1;
						default:
							switch(null)
							{
								case "generator":
									this._sGenerator = var3.childNodes.join("");
									break;
								case "managingeditor":
									this._sManagingEditor = var3.childNodes.join("");
									break;
								case "webmaster":
									this._sWebMaster = var3.childNodes.join("");
									break;
								case "item":
									var var4 = new ank.utils.rss.();
									if(var4.parse(var3))
									{
										this._aItems.push(var4);
										break;
									}
							}
					}
			}
			var3 = var3.nextSibling;
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
	function getPubDateStr(§\x1e\x12\x11§, §\x1e\x11\x06§)
	{
		return this._dPubDate != null?org.utils.SimpleDateFormatter.formatDate(this._dPubDate,var2,var3):this._sPubDate;
	}
	function getLastBuildDate()
	{
		return this._dLastBuildDate;
	}
	function getLastBuildDateStr(§\x1e\x12\x11§, §\x1e\x11\x06§)
	{
		return this._dLastBuildDate != null?org.utils.SimpleDateFormatter.formatDate(this._dLastBuildDate,var2,var3):this._sLastBuildDate;
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
	function parseDate(§\x1e\x13\x0f§)
	{
		return new Date();
	}
}
