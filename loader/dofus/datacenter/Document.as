class dofus.datacenter.Document extends Object
{
	static var MAX_CHAPTER_ON_PAGE = 13;
	function Document(§\n\x1a§)
	{
		super();
		this.initialize(var3);
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
	function initialize(§\n\x1a§)
	{
		this.api = _global.API;
		this._sType = var2.type;
		this._sTitle = var2.title;
		this._sSubTitle = var2.subtitle;
		this._sAuthor = var2.author;
		this._sCSS = dofus.Constants.STYLES_PATH + var2.style + ".css";
		this._aChapters = var2.chapters;
		this._aPages = new ank.utils.
();
		if((var var0 = this._sType) !== "book")
		{
			switch(null)
			{
				case "parchment":
				case "roadsignleft":
				case "roadsignright":
					var var14 = var2.pages[0];
					var var15 = this.api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
					var14 = ank.utils.PatternDecoder.replace(var14,var15);
					this._aPages.push({text:var14,cssFile:this._sCSS});
			}
		}
		else
		{
			var var3 = 1;
			if(this._sTitle != undefined)
			{
				this._aPages.push({type:"blank"});
				var3;
				this._aPages.push({type:"title",num:var3++,title:this._sTitle,subtitle:this._sSubTitle,author:this._sAuthor});
			}
			var var4 = new Object();
			var var5 = this._aChapters.length;
			if(var5 != 0 && this._aChapters != undefined)
			{
				var3;
				this._aPages.push({type:"blank",num:var3++});
				var var6 = 0;
				var var7 = 0;
				while(var6 < var5)
				{
					var var8 = this._aChapters.slice(var6,var6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE);
					var3;
					this._aPages.push({type:"index",num:var3++,chapters:var8});
					var6 = var6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE;
					var7 = var7 + 1;
				}
				if(var7 % 2 == 0)
				{
					var3;
					this._aPages.push({type:"blank",num:var3++});
				}
				for(var k in this._aChapters)
				{
					var4[this._aChapters[k][1]] = this._aChapters[k];
				}
			}
			var var9 = var2.pages;
			var var10 = var9.length;
			if(var10 != 0)
			{
				var3;
				this._aPages.push({type:"blank",num:var3++});
				var var11 = this.api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
				var var12 = 0;
				while(var12 < var10)
				{
					var var13 = new String();
					if(var4[var12] != undefined)
					{
						if(var4[var12][2] && var3 % 2 == 0)
						{
							var3;
							this._aPages.push({type:"blank",num:var3++});
						}
						var4[var12][4] = var3;
						if(var4[var12][3])
						{
							var13 = "<br/><p class=\'chapter\'>" + var4[var12][0] + "</p><br/>";
						}
					}
					var9[var12] = ank.utils.PatternDecoder.replace(var9[var12],var11);
					var3;
					this._aPages.push({type:"text",num:var3++,text:var13 + var9[var12],cssFile:this._sCSS});
					var12 = var12 + 1;
				}
			}
		}
	}
	function getPage(§\x02\n§)
	{
		return this._aPages[var2];
	}
}
