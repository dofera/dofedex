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
	function __set__article(loc2)
	{
		this.addToQueue({object:this,method:this.displayArticle,params:[loc2]});
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
		var loc2 = this.api.lang.getKnownledgeBaseCategories();
		loc2.sortOn("o",Array.NUMERIC | Array.DESCENDING);
		this._eaCategories = new ank.utils.();
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && loc2[loc3].ep <= this.api.datacenter.Basics.aks_current_regional_version))
			{
				this._eaCategories.push(loc2[loc3]);
			}
			loc3 = loc3 + 1;
		}
		this._lstCategories.dataProvider = this._eaCategories;
		var loc4 = this.api.lang.getKnownledgeBaseArticles();
		loc4.sortOn("o",Array.NUMERIC | Array.DESCENDING);
		this._eaArticles = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc4.length)
		{
			if(loc4[loc5] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && loc4[loc5].ep <= this.api.datacenter.Basics.aks_current_regional_version))
			{
				this._eaArticles.push(loc4[loc5]);
			}
			loc5 = loc5 + 1;
		}
		this.generateIndexes();
	}
	function recoverLastState()
	{
		if((var loc0 = this.api.datacenter.Basics.kbDisplayType) !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES)
		{
			if(loc0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES)
			{
				if(loc0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE)
				{
					if(loc0 === dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH)
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
	function switchToState(loc2)
	{
		if(this._nCurrentState == loc2)
		{
			return undefined;
		}
		var loc3 = this.api.ui.getUIComponent("KnownledgeBase");
		if((var loc0 = loc2) !== dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED)
		{
			if(loc0 === dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED)
			{
				this._btnMaximize._visible = false;
				this._btnMinimize._visible = true;
				loc3._y = 0;
			}
		}
		else
		{
			this._btnMaximize._visible = true;
			this._btnMinimize._visible = false;
			loc3._y = 352;
		}
		this._nCurrentState = loc2;
	}
	function switchToDisplay(loc2, loc3)
	{
		if(this._nCurrentDisplay == loc2)
		{
			return undefined;
		}
		if((var loc0 = loc2) !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES)
		{
			if(loc0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES)
			{
				if(loc0 !== dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH)
				{
					if(loc0 === dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE)
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
		this._nCurrentDisplay = loc2;
		if(loc3 !== true)
		{
			this.api.datacenter.Basics.kbDisplayType = loc2;
		}
	}
	function generateIndexes()
	{
		this._eaIndexes = new ank.utils.();
		var loc2 = 0;
		while(loc2 < this._eaArticles.length)
		{
			var loc3 = 0;
			while(loc3 < this._eaArticles[loc2].k.length)
			{
				this._eaIndexes.push({name:this._eaArticles[loc2].k[loc3].toUpperCase(),i:this._eaArticles[loc2].i});
				loc3 = loc3 + 1;
			}
			loc2 = loc2 + 1;
		}
	}
	function searchTopic(loc2)
	{
		var loc3 = loc2.split(" ");
		var loc4 = new ank.utils.();
		var loc5 = new ank.utils.();
		var loc6 = new Array();
		var loc7 = 0;
		var loc8 = new Array();
		var loc9 = -1;
		var loc10 = 0;
		while(loc10 < this._eaIndexes.length)
		{
			var loc11 = this._eaIndexes[loc10];
			var loc12 = this.searchWordsInName(loc3,loc11.name,loc7);
			if(loc12 != 0)
			{
				loc6.push({i:loc11.i,w:loc12});
				loc7 = loc12;
			}
			loc10 = loc10 + 1;
		}
		var loc13 = 0;
		while(loc13 < loc6.length)
		{
			if(!loc8[loc6[loc13].i] && loc6[loc13].w >= loc7)
			{
				var loc14 = this._eaArticles.findFirstItem("i",loc6[loc13].i).item;
				loc4.push(loc14);
				loc8[loc6[loc13].i] = true;
			}
			loc13 = loc13 + 1;
		}
		loc4.sortOn("c",Array.NUMERIC | Array.DESCENDING);
		var loc15 = 0;
		while(loc15 < loc4.length)
		{
			if(loc4[loc15].n != "" && loc4[loc15].n != undefined)
			{
				if(loc9 != loc4[loc15].c)
				{
					loc5.push(this.api.lang.getKnownledgeBaseCategory(loc4[loc15].c));
					loc9 = loc4[loc15].c;
				}
				loc5.push(loc4[loc15]);
			}
			loc15 = loc15 + 1;
		}
		this._lstSearch.dataProvider = loc5;
	}
	function searchWordsInName(loc2, loc3, loc4)
	{
		var loc5 = 0;
		var loc6 = loc2.length;
		while(loc6 >= 0)
		{
			var loc7 = loc2[loc6];
			if(loc3.indexOf(loc7) != -1)
			{
				loc5 = loc5 + 1;
			}
			else if(loc5 + loc6 < loc4)
			{
				return 0;
			}
			loc6 = loc6 - 1;
		}
		return loc5;
	}
	function displayArticles(loc2, loc3)
	{
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < this._eaArticles.length)
		{
			if(this._eaArticles[loc5].c == loc2)
			{
				loc4.push(this._eaArticles[loc5]);
			}
			loc5 = loc5 + 1;
		}
		this._lstArticles.dataProvider = loc4;
		this._lblCategory.text = this._eaCategories.findFirstItem("i",loc2).item.n;
		if(loc3 !== true)
		{
			this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
		}
		this.api.datacenter.Basics.kbCategory = loc2;
	}
	function displayArticle(loc2)
	{
		var loc3 = this._eaArticles.findFirstItem("i",loc2).item;
		this._lblArticle.text = loc3.n;
		this.displayArticles(loc3.c,true);
		this._taArticle.text = "<p class=\'body\'>" + loc3.a + "</p>";
		this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
		this.api.datacenter.Basics.kbArticle = loc2;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_mcBtnCategory":
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
				break;
			case "_mcBtnArticle":
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
				break;
			default:
				switch(null)
				{
					case "_btnMaximize":
						this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED);
						break;
					case "_btnMinimize":
						this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED);
				}
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnMinimize":
				this.gapi.showTooltip(this.api.lang.getText("WINDOW_MINIMIZE"),loc2.target,20);
				break;
			case "_btnMaximize":
				this.gapi.showTooltip(this.api.lang.getText("WINDOW_MAXIMIZE"),loc2.target,20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function itemSelected(loc2)
	{
		switch(loc2.target._name)
		{
			case "_lstCategories":
				this.displayArticles(Number(loc2.row.item.i));
				break;
			case "_lstArticles":
				this.displayArticle(Number(loc2.row.item.i));
				break;
			default:
				if(loc0 !== "_lstSearch")
				{
					break;
				}
				var loc3 = loc2.row.item;
				if(loc3.c > 0)
				{
					this._lblArticle.text = loc3.n;
					this._lblCategory.text = this._eaCategories.findFirstItem("i",loc3.c).item.n;
					this._taArticle.text = loc3.a;
					this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
					break;
				}
				this._lblCategory.text = loc3.n;
				var loc4 = loc3.i;
				var loc5 = new ank.utils.();
				var loc6 = 0;
				while(loc6 < this._eaArticles.length)
				{
					if(this._eaArticles[loc6].c == loc4)
					{
						loc5.push(this._eaArticles[loc6]);
					}
					loc6 = loc6 + 1;
				}
				this._lstArticles.dataProvider = loc5;
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
				break;
		}
	}
	function change(loc2)
	{
		if((var loc0 = loc2.target._name) === "_tiSearch")
		{
			var loc3 = this._tiSearch.text;
			if(loc3.length > 0)
			{
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH);
				this.searchTopic(loc3.toUpperCase());
			}
			else
			{
				this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
			}
			this.api.datacenter.Basics.kbSearch = this._tiSearch.text;
		}
	}
	function href(loc2)
	{
		this.api.kernel.TipsManager.onLink(loc2);
	}
	function onShortcut(loc2)
	{
		if((var loc0 = loc2) === "ACCEPT_CURRENT_DIALOG")
		{
			if(this._tiSearch.focused)
			{
				this.change({target:this._tiSearch});
			}
		}
	}
}
