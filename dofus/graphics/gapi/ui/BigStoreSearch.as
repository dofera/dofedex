class dofus.graphics.gapi.ui.BigStoreSearch extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BigStoreSearch";
   var _sDefaultText = "";
   function BigStoreSearch()
   {
      super();
   }
   function __set__types(aTypes)
   {
      this._aTypes = aTypes;
      return this.__get__types();
   }
   function __set__maxLevel(nMaxLevel)
   {
      this._nMaxLevel = nMaxLevel;
      return this.__get__maxLevel();
   }
   function __set__defaultSearch(sText)
   {
      this._sDefaultText = sText;
      return this.__get__defaultSearch();
   }
   function __set__oParent(o)
   {
      this._oParent = o;
      return this.__get__oParent();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.BigStoreSearch.CLASS_NAME);
   }
   function callClose()
   {
      this.gapi.hideTooltip();
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.generateIndexes();
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
      this._btnView.addEventListener("click",this);
      this._tiSearch.addEventListener("change",this);
      this._lstItems.addEventListener("itemSelected",this);
   }
   function initTexts()
   {
      this._winBackground.title = this.api.lang.getText("BIGSTORE_SEARCH");
      this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_ITEM_NAME");
      this._btnClose2.label = this.api.lang.getText("CLOSE");
      this._btnView.label = this.api.lang.getText("BIGSTORE_SEARCH_VIEW");
      this._tiSearch.text = this._sDefaultText;
      this._tiSearch.setFocus();
   }
   function generateIndexes()
   {
      var _loc2_ = new Object();
      for(var k in this._aTypes)
      {
         _loc2_[this._aTypes[k]] = true;
      }
      var _loc3_ = this.api.lang.getItemUnics();
      this._aItems = new Array();
      for(var k in _loc3_)
      {
         var _loc4_ = _loc3_[k];
         if(!(_loc4_.ep == undefined || _loc4_.ep > this.api.datacenter.Basics.aks_current_regional_version))
         {
            if(_loc2_[_loc4_.t] && (_loc4_.h != true && _loc4_.l <= this._nMaxLevel))
            {
               var _loc5_ = _loc4_.n;
               this._aItems.push({id:k,name:_loc5_.toUpperCase()});
            }
         }
      }
   }
   function searchItem(sText)
   {
      var _loc3_ = sText.split(" ");
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = new Object();
      var _loc6_ = 0;
      var _loc7_ = 0;
      while(_loc7_ < this._aItems.length)
      {
         var _loc8_ = this._aItems[_loc7_];
         var _loc9_ = this.searchWordsInName(_loc3_,_loc8_.name,_loc6_);
         if(_loc9_ != 0)
         {
            _loc5_[_loc8_.id] = _loc9_;
            _loc6_ = _loc9_;
         }
         _loc7_ = _loc7_ + 1;
      }
      for(var k in _loc5_)
      {
         if(_loc5_[k] >= _loc6_)
         {
            _loc4_.push(new dofus.datacenter.Item(0,Number(k)));
         }
      }
      this._lstItems.dataProvider = _loc4_;
      this._lblSearchCount.text = _loc4_.length != 0?_loc4_.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",_loc4_ < 2):this.api.lang.getText("NO_BIGSTORE_SEARCH_RESULT");
      this._btnView.enabled = false;
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
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnClose2":
            this.callClose();
            break;
         case "_btnView":
            var _loc3_ = this._lstItems.selectedItem;
            this.api.network.Exchange.bigStoreSearch(_loc3_.type,_loc3_.unicID);
      }
   }
   function change(oEvent)
   {
      var _loc3_ = new ank.utils.ExtendedString(this._tiSearch.text).trim().toString();
      if(_loc3_.length >= 4)
      {
         this.searchItem(_loc3_.toUpperCase());
      }
      else
      {
         this._lstItems.dataProvider = new ank.utils.ExtendedArray();
         if(this._lblSearchCount.text != undefined)
         {
            this._lblSearchCount.text = "";
         }
      }
      this._oParent.defaultSearch = this._tiSearch.text;
   }
   function itemSelected(oEvent)
   {
      this._btnView.enabled = true;
   }
}
