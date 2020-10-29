class dofus.graphics.gapi.ui.KnownledgeBase extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "KnownledgeBase";
	static var DISPLAY_CATEGORIES = 1;
	static var DISPLAY_ARTICLES = 2;
	static var DISPLAY_SEARCH = 3;
	static var DISPLAY_ARTICLE = 4;
	static var STATE_MINIMIZED = 1;
	static var STATE_MAXIMIZED = 2;
	function KnownledgeBase()
	{
		super();
		this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES,true);
		this._btnMaximize._visible = false;
	}
	function __set__article(var2)
	{
		this.addToQueue({object:this,method:this.displayArticle,params:[var2]});
		return this.__get__article();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.KnownledgeBase.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initText});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.recoverLastState});
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function initText()
	{
		this._winBackground.title = this.api.lang.getText("KB_TITLE");
		this._lblSearch.text = this.api.lang.getText("KB_SEARCH");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnMaximize.addEventListener("click",this);
		this._btnMaximize.addEventListener("over",this);
		this._btnMaximize.addEventListener("out",this);
		this._btnMinimize.addEventListener("click",this);
		this._btnMinimize.addEventListener("over",this);
		this._btnMinimize.addEventListener("out",this);
		this._lstCategories.addEventListener("itemSelected",this);
		this._lstArticles.addEventListener("itemSelected",this);
		this._lstSearch.addEventListener("itemSelected",this);
		this._taArticle.addEventListener("href",this);
		this._mcBtnCategory.onRelease = function()
		{
			this._parent.click({target:this});
		};
		this._mcBtnArticle.onRelease = function()
		{
			this._parent.click({target:this});
		};
		this._tiSearch.addEventListener("change",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function initData()
	{
		var var2 = this.api.lang.getKnownledgeBaseCategories();
		var2.sortOn("o",Array.NUMERIC | Array.DESCENDING);
		this._eaCategories = new ank.utils.();
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && var2[var3].ep <= this.api.datacenter.Basics.aks_current_regional_version))
			{
				this._eaCategories.push(var2[var3]);
			}
			var3 = var3 + 1;
		}
		this._lstCategories.dataProvider = this._eaCategories;
		var var4 = this.api.lang.getKnownledgeBaseArticles();
		var4.sortOn("o",Array.NUMERIC | Array.DESCENDING);
		this._eaArticles = new ank.utils.();
		var var5 = 0;
		while(var5 < var4.length)
		{
			if(var4[var5] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && var4[var5].ep <= this.api.datacenter.Basics.aks_current_regional_version))
			{
				this._eaArticles.push(var4[var5]);
			}
			var5 = var5 + 1;
		}
		this.generateIndexes();
	}
	function recoverLastState()
	{
		if((var var0 = this.api.datacenter.Basics.kbDisplayType) !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES)
		{
			if(var0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES)
			{
				if(var0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE)
				{
					if(var0 === dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH)
					{
						this._tiSearch.text = this.api.datacenter.Basics.kbSearch;
					}
				}
				else
				{
					this.displayArticle(this.api.datacenter.Basics.kbArticle);
				}
			}
			else
			{
				this.displayArticles(this.api.datacenter.Basics.kbCategory);
			}
		}
		else
		{
			this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
		}
	}
	function switchToState(var2)
	{
		if(this._nCurrentState == var2)
		{
			return undefined;
		}
		var var3 = this.api.ui.getUIComponent("KnownledgeBase");
		if((var var0 = var2) !== dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED)
		{
			if(var0 === dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED)
			{
				this._btnMaximize._visible = false;
				this._btnMinimize._visible = true;
				var3._y = 0;
			}
		}
		else
		{
			this._btnMaximize._visible = true;
			this._btnMinimize._visible = false;
			var3._y = 352;
		}
		this._nCurrentState = var2;
	}
	function switchToDisplay(var2, var3)
	{
		if(this._nCurrentDisplay == var2)
		{
			return undefined;
		}
		if((var var0 = var2) !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES)
		{
			if(var0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES)
			{
				if(var0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH)
				{
					if(var0 === dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE)
					{
						this._lstCategories._visible = false;
						this._lstArticles._visible = false;
						this._lblCategory._visible = true;
						this._mcCategory._visible = true;
						this._mcArrowUp._visible = false;
						this._mcBgCategory._visible = true;
						this._mcBtnCategory._visible = false;
						this._lblArticle._visible = true;
						this._mcArticle._visible = true;
						this._mcBgArticle._visible = true;
						this._mcBtnArticle._visible = true;
						this._taArticle._visible = true;
						this._lstSearch._visible = false;
						this._mcBookComplete._visible = true;
						this._mcArrowUp2._visible = true;
					}
				}
				else
				{
					this._lstCategories._visible = false;
					this._lstArticles._visible = false;
					this._lblCategory._visible = false;
					this._mcCategory._visible = false;
					this._mcArrowUp._visible = false;
					this._mcBgCategory._visible = false;
					this._mcBtnCategory._visible = false;
					this._lblArticle._visible = false;
					this._mcArticle._visible = false;
					this._mcBgArticle._visible = false;
					this._mcBtnArticle._visible = false;
					this._taArticle._visible = false;
					this._lstSearch._visible = true;
					this._mcBookComplete._visible = false;
					this._mcArrowUp2._visible = false;
				}
			}
			else
			{
				this._lstCategories._visible = false;
				this._lstArticles._visible = true;
				this._lblCategory._visible = true;
				this._mcCategory._visible = true;
				this._mcArrowUp._visible = true;
				this._mcBgCategory._visible = true;
				this._mcBtnCategory._visible = true;
				this._lblArticle._visible = false;
				this._mcArticle._visible = false;
				this._mcBgArticle._visible = false;
				this._mcBtnArticle._visible = false;
				this._taArticle._visible = false;
				this._lstSearch._visible = false;
				this._mcBookComplete._visible = false;
				this._mcArrowUp2._visible = false;
			}
		}
		else
		{
			this._lstCategories._visible = true;
			this._lstArticles._visible = false;
			this._lblCategory._visible = false;
			this._mcCategory._visible = false;
			this._mcArrowUp._visible = false;
			this._mcBgCategory._visible = false;
			this._mcBtnCategory._visible = false;
			this._lblArticle._visible = false;
			this._mcArticle._visible = false;
			this._mcBgArticle._visible = false;
			this._mcBtnArticle._visible = false;
			this._taArticle._visible = false;
			this._lstSearch._visible = false;
			this._mcBookComplete._visible = false;
			this._mcArrowUp2._visible = false;
		}
		this._nCurrentDisplay = var2;
		if(var3 !== true)
		{
			this.api.datacenter.Basics.kbDisplayType = var2;
		}
	}
	function generateIndexes()
	{
		this._eaIndexes = new ank.utils.();
		var var2 = 0;
		while(var2 < this._eaArticles.length)
		{
			var var3 = 0;
			while(var3 < this._eaArticles[var2].k.length)
			{
				this._eaIndexes.push({name:this._eaArticles[var2].k[var3].toUpperCase(),i:this._eaArticles[var2].i});
				var3 = var3 + 1;
			}
			var2 = var2 + 1;
		}
	}
	function searchTopic(var2)
	{
		var var3 = var2.split(" ");
		var var4 = new ank.utils.();
		var var5 = new ank.utils.();
		var var6 = new Array();
		var var7 = 0;
		var var8 = new Array();
		var var9 = -1;
		var var10 = 0;
		while(var10 < this._eaIndexes.length)
		{
			var var11 = this._eaIndexes[var10];
			var var12 = this.searchWordsInName(var3,var11.name,var7);
			if(var12 != 0)
			{
				var6.push({i:var11.i,w:var12});
				var7 = var12;
			}
			var10 = var10 + 1;
		}
		var var13 = 0;
		while(var13 < var6.length)
		{
			if(!var8[var6[var13].i] && var6[var13].w >= var7)
			{
				var var14 = this._eaArticles.findFirstItem("i",var6[var13].i).item;
				var4.push(var14);
				var8[var6[var13].i] = true;
			}
			var13 = var13 + 1;
		}
		var4.sortOn("c",Array.NUMERIC | Array.DESCENDING);
		var var15 = 0;
		while(var15 < var4.length)
		{
			if(var4[var15].n != "" && var4[var15].n != undefined)
			{
				if(var9 != var4[var15].c)
				{
					var5.push(this.api.lang.getKnownledgeBaseCategory(var4[var15].c));
					var9 = var4[var15].c;
				}
				var5.push(var4[var15]);
			}
			var15 = var15 + 1;
		}
		this._lstSearch.dataProvider = var5;
	}
	function searchWordsInName(var2, var3, var4)
	{
		var var5 = 0;
		var var6 = var2.length;
		while(var6 >= 0)
		{
			var var7 = var2[var6];
			if(var3.indexOf(var7) != -1)
			{
				var5 = var5 + 1;
			}
			else if(var5 + var6 < var4)
			{
				return 0;
			}
			var6 = var6 - 1;
		}
		return var5;
	}
	function displayArticles(var2, var3)
	{
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < this._eaArticles.length)
		{
			if(this._eaArticles[var5].c == var2)
			{
				var4.push(this._eaArticles[var5]);
			}
			var5 = var5 + 1;
		}
		this._lstArticles.dataProvider = var4;
		this._lblCategory.text = this._eaCategories.findFirstItem("i",var2).item.n;
		if(var3 !== true)
		{
			this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
		}
		this.api.datacenter.Basics.kbCategory = var2;
	}
	function displayArticle(var2)
	{
		var var3 = this._eaArticles.findFirstItem("i",var2).item;
		this._lblArticle.text = var3.n;
		this.displayArticles(var3.c,true);
		this._taArticle.text = "<p class=\'body\'>" + var3.a + "</p>";
		this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
		this.api.datacenter.Basics.kbArticle = var2;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_mcBtnCategory":
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
				break;
			default:
				switch(null)
				{
					case "_mcBtnArticle":
						this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
						break;
					case "_btnMaximize":
						this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED);
						break;
					case "_btnMinimize":
						this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED);
				}
		}
	}
	function over(var2)
	{
		switch(var2.target._name)
		{
			case "_btnMinimize":
				this.gapi.showTooltip(this.api.lang.getText("WINDOW_MINIMIZE"),var2.target,20);
				break;
			case "_btnMaximize":
				this.gapi.showTooltip(this.api.lang.getText("WINDOW_MAXIMIZE"),var2.target,20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function itemSelected(var2)
	{
		switch(var2.target._name)
		{
			case "_lstCategories":
				this.displayArticles(Number(var2.row.item.i));
				break;
			case "_lstArticles":
				this.displayArticle(Number(var2.row.item.i));
				break;
			case "_lstSearch":
				var var3 = var2.row.item;
				if(var3.c > 0)
				{
					this._lblArticle.text = var3.n;
					this._lblCategory.text = this._eaCategories.findFirstItem("i",var3.c).item.n;
					this._taArticle.text = var3.a;
					this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
					break;
				}
				this._lblCategory.text = var3.n;
				var var4 = var3.i;
				var var5 = new ank.utils.();
				var var6 = 0;
				while(var6 < this._eaArticles.length)
				{
					if(this._eaArticles[var6].c == var4)
					{
						var5.push(this._eaArticles[var6]);
					}
					var6 = var6 + 1;
				}
				this._lstArticles.dataProvider = var5;
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
				break;
		}
	}
	function change(var2)
	{
		if((var var0 = var2.target._name) === "_tiSearch")
		{
			var var3 = this._tiSearch.text;
			if(var3.length > 0)
			{
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH);
				this.searchTopic(var3.toUpperCase());
			}
			else
			{
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
			}
			this.api.datacenter.Basics.kbSearch = this._tiSearch.text;
		}
	}
	function href(var2)
	{
		this.api.kernel.TipsManager.onLink(var2);
	}
	function onShortcut(var2)
	{
		if((var var0 = var2) === "ACCEPT_CURRENT_DIALOG")
		{
			if(this._tiSearch.focused)
			{
				this.change({target:this._tiSearch});
			}
		}
	}
}
