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
   function __set__article(nArticleID)
   {
      this.addToQueue({object:this,method:this.displayArticle,params:[nArticleID]});
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
      var _loc2_ = this.api.lang.getKnownledgeBaseCategories();
      _loc2_.sortOn("o",Array.NUMERIC | Array.DESCENDING);
      this._eaCategories = new ank.utils.ExtendedArray();
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         if(_loc2_[_loc3_] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && _loc2_[_loc3_].ep <= this.api.datacenter.Basics.aks_current_regional_version))
         {
            this._eaCategories.push(_loc2_[_loc3_]);
         }
         _loc3_ = _loc3_ + 1;
      }
      this._lstCategories.dataProvider = this._eaCategories;
      var _loc4_ = this.api.lang.getKnownledgeBaseArticles();
      _loc4_.sortOn("o",Array.NUMERIC | Array.DESCENDING);
      this._eaArticles = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < _loc4_.length)
      {
         if(_loc4_[_loc5_] != undefined && (this.api.datacenter.Basics.aks_current_regional_version != undefined && _loc4_[_loc5_].ep <= this.api.datacenter.Basics.aks_current_regional_version))
         {
            this._eaArticles.push(_loc4_[_loc5_]);
         }
         _loc5_ = _loc5_ + 1;
      }
      this.generateIndexes();
   }
   function recoverLastState()
   {
      switch(this.api.datacenter.Basics.kbDisplayType)
      {
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES:
            this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES:
            this.displayArticles(this.api.datacenter.Basics.kbCategory);
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE:
            this.displayArticle(this.api.datacenter.Basics.kbArticle);
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH:
            this._tiSearch.text = this.api.datacenter.Basics.kbSearch;
      }
   }
   function switchToState(nStateID)
   {
      if(this._nCurrentState == nStateID)
      {
         return undefined;
      }
      var _loc3_ = this.api.ui.getUIComponent("KnownledgeBase");
      switch(nStateID)
      {
         case dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED:
            this._btnMaximize._visible = true;
            this._btnMinimize._visible = false;
            _loc3_._y = 352;
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED:
            this._btnMaximize._visible = false;
            this._btnMinimize._visible = true;
            _loc3_._y = 0;
      }
      this._nCurrentState = nStateID;
   }
   function switchToDisplay(nDisplayID, bDontSave)
   {
      if(this._nCurrentDisplay == nDisplayID)
      {
         return undefined;
      }
      switch(nDisplayID)
      {
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES:
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
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES:
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
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH:
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
            break;
         case dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE:
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
      this._nCurrentDisplay = nDisplayID;
      if(bDontSave !== true)
      {
         this.api.datacenter.Basics.kbDisplayType = nDisplayID;
      }
   }
   function generateIndexes()
   {
      this._eaIndexes = new ank.utils.ExtendedArray();
      var _loc2_ = 0;
      while(_loc2_ < this._eaArticles.length)
      {
         var _loc3_ = 0;
         while(_loc3_ < this._eaArticles[_loc2_].k.length)
         {
            this._eaIndexes.push({name:this._eaArticles[_loc2_].k[_loc3_].toUpperCase(),i:this._eaArticles[_loc2_].i});
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function searchTopic(sTopic)
   {
      var _loc3_ = sTopic.split(" ");
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = new ank.utils.ExtendedArray();
      var _loc6_ = new Array();
      var _loc7_ = 0;
      var _loc8_ = new Array();
      var _loc9_ = -1;
      var _loc10_ = 0;
      while(_loc10_ < this._eaIndexes.length)
      {
         var _loc11_ = this._eaIndexes[_loc10_];
         var _loc12_ = this.searchWordsInName(_loc3_,_loc11_.name,_loc7_);
         if(_loc12_ != 0)
         {
            _loc6_.push({i:_loc11_.i,w:_loc12_});
            _loc7_ = _loc12_;
         }
         _loc10_ = _loc10_ + 1;
      }
      var _loc13_ = 0;
      while(_loc13_ < _loc6_.length)
      {
         if(!_loc8_[_loc6_[_loc13_].i] && _loc6_[_loc13_].w >= _loc7_)
         {
            var _loc14_ = this._eaArticles.findFirstItem("i",_loc6_[_loc13_].i).item;
            _loc4_.push(_loc14_);
            _loc8_[_loc6_[_loc13_].i] = true;
         }
         _loc13_ = _loc13_ + 1;
      }
      _loc4_.sortOn("c",Array.NUMERIC | Array.DESCENDING);
      var _loc15_ = 0;
      while(_loc15_ < _loc4_.length)
      {
         if(_loc4_[_loc15_].n != "" && _loc4_[_loc15_].n != undefined)
         {
            if(_loc9_ != _loc4_[_loc15_].c)
            {
               _loc5_.push(this.api.lang.getKnownledgeBaseCategory(_loc4_[_loc15_].c));
               _loc9_ = _loc4_[_loc15_].c;
            }
            _loc5_.push(_loc4_[_loc15_]);
         }
         _loc15_ = _loc15_ + 1;
      }
      this._lstSearch.dataProvider = _loc5_;
   }
   function searchWordsInName(aWords, sName, nMaxWordsCount)
   {
      var _loc5_ = 0;
      var _loc6_ = aWords.length;
      while(_loc6_ >= 0)
      {
         var _loc7_ = aWords[_loc6_];
         if(sName.indexOf(_loc7_) != -1)
         {
            _loc5_ = _loc5_ + 1;
         }
         else if(_loc5_ + _loc6_ < nMaxWordsCount)
         {
            return 0;
         }
         _loc6_ = _loc6_ - 1;
      }
      return _loc5_;
   }
   function displayArticles(nCatID, bDoNotDisplay)
   {
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < this._eaArticles.length)
      {
         if(this._eaArticles[_loc5_].c == nCatID)
         {
            _loc4_.push(this._eaArticles[_loc5_]);
         }
         _loc5_ = _loc5_ + 1;
      }
      this._lstArticles.dataProvider = _loc4_;
      this._lblCategory.text = this._eaCategories.findFirstItem("i",nCatID).item.n;
      if(bDoNotDisplay !== true)
      {
         this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
      }
      this.api.datacenter.Basics.kbCategory = nCatID;
   }
   function displayArticle(nArticleID)
   {
      var _loc3_ = this._eaArticles.findFirstItem("i",nArticleID).item;
      this._lblArticle.text = _loc3_.n;
      this.displayArticles(_loc3_.c,true);
      this._taArticle.text = "<p class=\'body\'>" + _loc3_.a + "</p>";
      this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
      this.api.datacenter.Basics.kbArticle = nArticleID;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
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
         case "_btnMaximize":
            this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MAXIMIZED);
            break;
         case "_btnMinimize":
            this.switchToState(dofus.graphics.gapi.ui.KnownledgeBase.STATE_MINIMIZED);
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnMinimize":
            this.gapi.showTooltip(this.api.lang.getText("WINDOW_MINIMIZE"),oEvent.target,20);
            break;
         case "_btnMaximize":
            this.gapi.showTooltip(this.api.lang.getText("WINDOW_MAXIMIZE"),oEvent.target,20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function itemSelected(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_lstCategories":
            this.displayArticles(Number(oEvent.row.item.i));
            break;
         case "_lstArticles":
            this.displayArticle(Number(oEvent.row.item.i));
            break;
         case "_lstSearch":
            var _loc3_ = oEvent.row.item;
            if(_loc3_.c > 0)
            {
               this._lblArticle.text = _loc3_.n;
               this._lblCategory.text = this._eaCategories.findFirstItem("i",_loc3_.c).item.n;
               this._taArticle.text = _loc3_.a;
               this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLE);
            }
            else
            {
               this._lblCategory.text = _loc3_.n;
               var _loc4_ = _loc3_.i;
               var _loc5_ = new ank.utils.ExtendedArray();
               var _loc6_ = 0;
               while(_loc6_ < this._eaArticles.length)
               {
                  if(this._eaArticles[_loc6_].c == _loc4_)
                  {
                     _loc5_.push(this._eaArticles[_loc6_]);
                  }
                  _loc6_ = _loc6_ + 1;
               }
               this._lstArticles.dataProvider = _loc5_;
               this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_ARTICLES);
            }
      }
   }
   function change(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_tiSearch")
      {
         var _loc3_ = this._tiSearch.text;
         if(_loc3_.length > 0)
         {
            this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_SEARCH);
            this.searchTopic(_loc3_.toUpperCase());
         }
         else
         {
            this.switchToDisplay(dofus.graphics.gapi.ui.KnownledgeBase.DISPLAY_CATEGORIES);
         }
         this.api.datacenter.Basics.kbSearch = this._tiSearch.text;
      }
   }
   function href(oEvent)
   {
      this.api.kernel.TipsManager.onLink(oEvent);
   }
   function onShortcut(sShortcut)
   {
      if((var _loc0_ = sShortcut) === "ACCEPT_CURRENT_DIALOG")
      {
         if(this._tiSearch.focused)
         {
            this.change({target:this._tiSearch});
         }
      }
   }
}
