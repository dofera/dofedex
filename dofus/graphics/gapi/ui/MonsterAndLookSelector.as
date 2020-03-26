class dofus.graphics.gapi.ui.MonsterAndLookSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MonsterAndLookSelector";
   static var ANIM_LIST = ["static","walk","run","hit","bonus","anim0","anim1","anim2","anim3","anim4","anim5","anim6","anim7","anim8","anim9","anim10","anim11","anim12","anim12","anim13","anim14","anim15","anim16","anim17","anim18","anim111","anim112","anim113","anim114","anim115","anim116","anim117","emote1","emote2","emote3","emote4","emote5","emote6","emote7","emote8","emote9","emote10","emote11","emote12","emote13","emote14","emote15","emote16","emote17","emote18","emote19","emote20","emote21","emoteStatic1","emoteStatic14","emoteStatic15","emoteStatic16","emoteStatic19","emoteStatic20","emoteStatic21","die"];
   function MonsterAndLookSelector()
   {
      super();
   }
   function __set__monster(bMonster)
   {
      this._bMonster = bMonster;
      return this.__get__monster();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.MonsterAndLookSelector.CLASS_NAME);
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initAnimList});
      if(this._bMonster)
      {
         this.addToQueue({object:this,method:this.loadMonsters});
      }
      else
      {
         this.addToQueue({object:this,method:this.loadLooks});
      }
   }
   function initTexts()
   {
      if(this._bMonster)
      {
         this._winBg.title = "Liste des monstres";
      }
      else
      {
         this._winBg.title = "Liste des look";
      }
      this._lblType.text = this.api.lang.getText("TYPE");
      this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      this._btnSelect.label = this.api.lang.getText("SELECT");
      this._btnSearch.label = this.api.lang.getText("OK");
      this._tiSearch.text = !this._tiSearch.text.length?"Recherche...":this._tiSearch.text;
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnCancel.addEventListener("click",this);
      this._btnSelect.addEventListener("click",this);
      this._cbType.addEventListener("itemSelected",this);
      this._cbAnim.addEventListener("itemSelected",this);
      this._cg.addEventListener("selectItem",this);
      this._cg.addEventListener("overItem",this);
      this._cg.addEventListener("outItem",this);
      this._cg.addEventListener("dblClickItem",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
      this._btnSearch.addEventListener("click",this);
      var ref = this;
      var _loc2_ = new Object();
      _loc2_.onSetFocus = function(oldFocus_txt, newFocus_txt)
      {
         if(eval(Selection.getFocus())._parent == ref._tiSearch)
         {
            if(ref._tiSearch.text == "Recherche...")
            {
               ref._tiSearch.text = "";
            }
         }
         else if(ref._tiSearch.text == "")
         {
            ref._tiSearch.text = "Recherche...";
         }
      };
      Selection.addListener(_loc2_);
   }
   function initAnimList(eaTypes)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = 0;
      while(_loc4_ < dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST.length)
      {
         _loc3_.push({label:dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST[_loc4_]});
         _loc4_ = _loc4_ + 1;
      }
      this._cbAnim.dataProvider = _loc3_;
   }
   function initData(eaTypes)
   {
      this._cciSprite.deleteButton = false;
      this._eaTypes = eaTypes;
      eaTypes.sortOn("label");
      this._cbType.dataProvider = eaTypes;
   }
   function loadLooks()
   {
      var ui = this;
      var _loc2_ = new XML();
      _loc2_.ignoreWhite = true;
      _loc2_.onLoad = function()
      {
         var _loc2_ = dofus.Constants.ARTWORKS_BIG_PATH;
         var _loc3_ = new ank.utils.ExtendedArray();
         var _loc4_ = new ank.utils.ExtendedArray();
         var _loc5_ = this.firstChild.firstChild;
         while(_loc5_ != undefined)
         {
            var _loc6_ = _loc5_.attributes.name;
            var _loc7_ = new ank.utils.ExtendedArray();
            var _loc8_ = _loc5_.firstChild;
            while(_loc8_ != undefined)
            {
               var _loc9_ = _loc8_.attributes.id;
               var _loc10_ = _loc8_.attributes.name;
               var _loc11_ = {iconFile:_loc2_ + _loc9_ + ".swf",name:_loc10_,id:_loc9_,gfxId:_loc9_};
               _loc7_.push(_loc11_);
               _loc4_.push(_loc11_);
               _loc8_ = _loc8_.nextSibling;
            }
            _loc3_.push({label:_loc6_,data:_loc7_});
            _loc5_ = _loc5_.nextSibling;
         }
         _loc3_.push({label:"-- ALL --",data:_loc4_});
         ui.initData(_loc3_);
      };
      _loc2_.load(dofus.Constants.XML_SPRITE_LIST);
   }
   function loadMonsters(sFilter)
   {
      if(sFilter == undefined)
      {
         sFilter = "";
      }
      var _loc3_ = this.api.lang.getMonsters();
      var _loc4_ = dofus.Constants.ARTWORKS_BIG_PATH;
      var _loc5_ = new ank.utils.ExtendedArray();
      var _loc6_ = new ank.utils.ExtendedArray();
      var _loc7_ = new Object();
      for(var a in _loc3_)
      {
         var _loc8_ = _loc3_[a];
         var _loc9_ = _loc8_.b;
         var _loc10_ = _loc7_[_loc9_];
         if(_loc10_ == undefined)
         {
            _loc10_ = {label:this.api.lang.getMonstersRaceText(_loc9_).n,data:new ank.utils.ExtendedArray()};
            _loc7_[_loc9_] = _loc10_;
            _loc5_.push(_loc10_);
         }
         var _loc11_ = a;
         var _loc12_ = _loc8_.n;
         var _loc13_ = _loc8_.g;
         var _loc14_ = {iconFile:_loc4_ + _loc13_ + ".swf",name:_loc12_,id:_loc11_,gfxId:_loc13_};
         _loc6_.push(_loc14_);
         _loc10_.data.push(_loc14_);
      }
      _loc5_.push({label:"-- ALL --",data:_loc6_});
      this.initData(_loc5_);
   }
   function select(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ != undefined)
      {
         if(this._bMonster)
         {
            this.dispatchEvent({type:"select",ui:"MonsterSelector",monsterId:_loc3_.id});
         }
         else
         {
            this.dispatchEvent({type:"select",ui:"LookSelector",lookId:_loc3_.id});
         }
         this.callClose();
      }
   }
   function filterResult(sFilter)
   {
      var _loc3_ = this._cbType.selectedItem.data;
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc6_ = _loc3_[_loc5_].name;
         if(!(sFilter.length && (sFilter != "Recherche..." && (sFilter.length && _loc6_.toUpperCase().indexOf(sFilter.toUpperCase()) == -1))))
         {
            _loc4_.push(_loc3_[_loc5_]);
         }
         _loc5_ = _loc5_ + 1;
      }
      this._cg.dataProvider = _loc4_;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnCancel":
            this.dispatchEvent({type:"cancel"});
            this.callClose();
         case "_btnSelect":
            this.select({target:this._cg.selectedItem});
            break;
         case "_btnSearch":
            this._cbType.selectedIndex = 0;
            this.filterResult(this._tiSearch.text);
      }
   }
   function dblClickItem(oEvent)
   {
      this.select(oEvent);
   }
   function selectItem(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ != undefined)
      {
         this._cciSprite.data = {name:_loc3_.name,gfxFile:dofus.Constants.CLIPS_PERSOS_PATH + _loc3_.gfxId + ".swf",title:_loc3_.id};
         this._cciSprite.enabled = true;
      }
      else
      {
         this._cciSprite.data = undefined;
         this._cciSprite.enabled = false;
      }
   }
   function overItem(oEvent)
   {
      if(oEvent.target.contentData != undefined)
      {
         this.gapi.showTooltip(oEvent.target.contentData.name + " (" + oEvent.target.contentData.id + ", GFX: " + oEvent.target.contentData.gfxId + ")",oEvent.target,-20);
      }
   }
   function outItem(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function itemSelected(oEvent)
   {
      switch(oEvent.target)
      {
         case this._cbType:
            var _loc3_ = this._cbType.selectedItem.data;
            this._cg.dataProvider = _loc3_;
            this._lblNumber.text = _loc3_.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText(!this._bMonster?"LOOK":"MONSTER"),"m",_loc3_.length < 2);
            break;
         case this._cbAnim:
            this._cciSprite.setAnim(this._cbAnim.selectedItem.label,true);
      }
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
      {
         this.click({target:this._btnSearch});
         return false;
      }
      return true;
   }
}
