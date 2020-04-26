class dofus.datacenter.Document extends Object
{
	static var MAX_CHAPTER_ON_PAGE = 13;
	function Document(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function __get__uiType()
	{
		switch(this._sType)
		{
			case "book":
				return "DocumentBook";
			case "parchment":
				return "DocumentParchment";
			case "roadsignleft":
				return "DocumentRoadSignLeft";
			case "roadsignright":
				return "DocumentRoadSignRight";
			default:
		}
	}
	function __get__title()
	{
		return this._sTitle;
	}
	function __get__subtitle()
	{
		return this._sSubTitle;
	}
	function __get__author()
	{
		return this._sAuthor;
	}
	function __get__pageCount()
	{
		return this._aPages.length;
	}
	function initialize(loc2)
	{
		this.api = _global.API;
		this._sType = loc2.type;
		this._sTitle = loc2.title;
		this._sSubTitle = loc2.subtitle;
		this._sAuthor = loc2.author;
		this._sCSS = dofus.Constants.STYLES_PATH + loc2.style + ".css";
		this._aChapters = loc2.chapters;
		this._aPages = new ank.utils.();
		switch(this._sType)
		{
			case "book":
				var loc3 = 1;
				if(this._sTitle != undefined)
				{
					this._aPages.push({type:"blank"});
					loc3;
					this._aPages.push({type:"title",num:loc3++,title:this._sTitle,subtitle:this._sSubTitle,author:this._sAuthor});
				}
				var loc4 = new Object();
				var loc5 = this._aChapters.length;
				if(loc5 != 0 && this._aChapters != undefined)
				{
					loc3;
					this._aPages.push({type:"blank",num:loc3++});
					var loc6 = 0;
					var loc7 = 0;
					while(loc6 < loc5)
					{
						var loc8 = this._aChapters.slice(loc6,loc6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE);
						loc3;
						this._aPages.push({type:"index",num:loc3++,chapters:loc8});
						loc6 = loc6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE;
						loc7 = loc7 + 1;
					}
					if(loc7 % 2 == 0)
					{
						loc3;
						this._aPages.push({type:"blank",num:loc3++});
					}
					for(var k in this._aChapters)
					{
						loc4[this._aChapters[k][1]] = this._aChapters[k];
					}
				}
				var loc9 = loc2.pages;
				var loc10 = loc9.length;
				if(loc10 != 0)
				{
					loc3;
					this._aPages.push({type:"blank",num:loc3++});
					var loc11 = this.api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
					var loc12 = 0;
					while(loc12 < loc10)
					{
						var loc13 = new String();
						if(loc4[loc12] != undefined)
						{
							if(loc4[loc12][2] && loc3 % 2 == 0)
							{
								loc3;
								this._aPages.push({type:"blank",num:loc3++});
							}
							loc4[loc12][4] = loc3;
							if(loc4[loc12][3])
							{
								loc13 = "<br/><p class=\'chapter\'>" + loc4[loc12][0] + "</p><br/>";
							}
						}
						loc9[loc12] = ank.utils.PatternDecoder.replace(loc9[loc12],loc11);
						loc3;
						this._aPages.push({type:"text",num:loc3++,text:loc13 + loc9[loc12],cssFile:this._sCSS});
						loc12 = loc12 + 1;
					}
				}
				break;
			default:
				switch(null)
				{
					case "roadsignleft":
					case "roadsignright":
				}
				break;
			case "parchment":
				var loc14 = loc2.pages[0];
				var loc15 = this.api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
				loc14 = ank.utils.PatternDecoder.replace(loc14,loc15);
				this._aPages.push({text:loc14,cssFile:this._sCSS});
		}
	}
	function getPage(loc2)
	{
		return this._aPages[loc2];
	}
}
