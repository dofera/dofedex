class dofus.graphics.gapi.controls.ItemViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ItemViewer";
   var _nDisplayWidth = 316;
   var _bUseButton = false;
   var _bDestroyButton = false;
   var _bTargetButton = false;
   var _sCurrentTab = "Effects";
   var _bShowBaseEffects = false;
   function ItemViewer()
   {
      super();
   }
   function __set__useButton(bUseButton)
   {
      this._bUseButton = bUseButton;
      return this.__get__useButton();
   }
   function __get__useButton()
   {
      return this._bUseButton;
   }
   function __set__destroyButton(bDestroyButton)
   {
      this._bDestroyButton = bDestroyButton;
      return this.__get__destroyButton();
   }
   function __get__destroyButton()
   {
      return this._bDestroyButton;
   }
   function __set__targetButton(bTargetButton)
   {
      this._bTargetButton = bTargetButton;
      return this.__get__targetButton();
   }
   function __get__targetButton()
   {
      return this._bTargetButton;
   }
   function __set__displayPrice(bDisplayPrice)
   {
      this._bPrice = bDisplayPrice;
      this._lblPrice._visible = bDisplayPrice;
      this._mcKamaSymbol._visible = bDisplayPrice;
      return this.__get__displayPrice();
   }
   function __get__displayPrice()
   {
      return this._bPrice;
   }
   function __set__hideDesc(bDisplayDesc)
   {
      this._bDesc = !bDisplayDesc;
      this._txtDescription._visible = this._bDesc;
      this._txtDescription.scrollBarRight = this._bDesc;
      return this.__get__hideDesc();
   }
   function __get__hideDesc()
   {
      return this._bDesc;
   }
   function __set__itemData(oItem)
   {
      this._oItem = oItem;
      this.addToQueue({object:this,method:this.showItemData,params:[oItem]});
      return this.__get__itemData();
   }
   function __get__itemData()
   {
      return this._oItem;
   }
   function __set__displayWidth(nDisplayWidth)
   {
      this._nDisplayWidth = Math.max(316,nDisplayWidth + 2);
      return this.__get__displayWidth();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ItemViewer.CLASS_NAME);
   }
   function arrange()
   {
      this._lstInfos._width = this._nDisplayWidth - this._lstInfos._x;
      this._txtDescription._width = this._nDisplayWidth - this._txtDescription._x - 1;
      this._mcTitle._width = this._nDisplayWidth - this._mcTitle._x;
      this._lblLevel._x = this._nDisplayWidth - (316 - this._lblLevel._x);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this._btnTabCharacteristics._visible = false;
      this._pbEthereal._visible = false;
      this._ldrTwoHanded._visible = false;
   }
   function initTexts()
   {
      this._btnTabEffects.label = this.api.lang.getText("EFFECTS");
      this._btnTabConditions.label = this.api.lang.getText("CONDITIONS");
      this._btnTabCharacteristics.label = this.api.lang.getText("CHARACTERISTICS");
   }
   function addListeners()
   {
      this._btnAction.addEventListener("click",this);
      this._btnAction.addEventListener("over",this);
      this._btnAction.addEventListener("out",this);
      this._btnTabEffects.addEventListener("click",this);
      this._btnTabCharacteristics.addEventListener("click",this);
      this._btnTabConditions.addEventListener("click",this);
      this._pbEthereal.addEventListener("over",this);
      this._pbEthereal.addEventListener("out",this);
      this._ldrTwoHanded.onRollOver = function()
      {
         this._parent.over({target:this});
      };
      this._ldrTwoHanded.onRollOut = function()
      {
         this._parent.out({target:this});
      };
   }
   function showItemData(oItem)
   {
      if(oItem != undefined)
      {
         this._lblName.text = oItem.name;
         if(dofus.Constants.DEBUG)
         {
            this._lblName.text = this._lblName.text + (" (" + oItem.unicID + ")");
         }
         if(oItem.style == "")
         {
            this._lblName.styleName = "WhiteLeftMediumBoldLabel";
         }
         else
         {
            this._lblName.styleName = oItem.style + "LeftMediumBoldLabel";
         }
         this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL") + oItem.level;
         this._txtDescription.text = oItem.description;
         this._ldrIcon.contentParams = oItem.params;
         this._ldrIcon.contentPath = oItem.iconFile;
         this.updateCurrentTabInformations();
         if(oItem.superType == 2)
         {
            this._btnTabCharacteristics._visible = true;
         }
         else
         {
            if(this._sCurrentTab == "Characteristics")
            {
               this.setCurrentTab("Effects");
            }
            this._btnTabCharacteristics._visible = false;
         }
         this._lblPrice.text = oItem.price != undefined?new ank.utils.ExtendedString(oItem.price).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3):"";
         this._lblWeight.text = oItem.weight + " " + ank.utils.PatternDecoder.combine(this._parent.api.lang.getText("PODS"),"m",oItem.weight < 2);
         if(oItem.isEthereal)
         {
            var _loc3_ = oItem.etherealResistance;
            this._pbEthereal.maximum = _loc3_.param3;
            this._pbEthereal.value = _loc3_.param2;
            this._pbEthereal._visible = true;
            if(_loc3_.param2 < 4)
            {
               this._pbEthereal.styleName = "EtherealCriticalProgressBar";
            }
            else
            {
               this._pbEthereal.styleName = "EtherealNormalProgressBar";
            }
         }
         else
         {
            this._pbEthereal._visible = false;
         }
         this._ldrTwoHanded._visible = oItem.needTwoHands;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._txtDescription.text = "";
         this._ldrIcon.contentPath = "";
         this._lstInfos.removeAll();
         this._lblPrice.text = "";
         this._lblWeight.text = "";
         this._pbEthereal._visible = false;
         this._ldrTwoHanded._visible = false;
      }
   }
   function updateCurrentTabInformations()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      switch(this._sCurrentTab)
      {
         case "Effects":
            for(var s in this._oItem.effects)
            {
               if(this._oItem.effects[s].description.length > 0)
               {
                  _loc2_.push(this._oItem.effects[s]);
               }
            }
            break;
         case "Characteristics":
            for(var s in this._oItem.characteristics)
            {
               if(this._oItem.characteristics[s].length > 0)
               {
                  _loc2_.push(this._oItem.characteristics[s]);
               }
            }
            break;
         case "Conditions":
            for(var s in this._oItem.conditions)
            {
               if(this._oItem.conditions[s].length > 0)
               {
                  _loc2_.push(this._oItem.conditions[s]);
               }
            }
      }
      _loc2_.reverse();
      this._lstInfos.dataProvider = _loc2_;
   }
   function setCurrentTab(sNewTab)
   {
      this._bShowBaseEffects = false;
      var _loc3_ = this["_btnTab" + this._sCurrentTab];
      var _loc4_ = this["_btnTab" + sNewTab];
      _loc3_.selected = true;
      _loc3_.enabled = true;
      _loc4_.selected = false;
      if(sNewTab != "Effects")
      {
         _loc4_.enabled = false;
      }
      this._sCurrentTab = sNewTab;
      this.updateCurrentTabInformations();
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnTabEffects":
            if(this._sCurrentTab == "Effects")
            {
               var _loc3_ = this["_btnTab" + this._sCurrentTab];
               _loc3_.selected = false;
               if(this._bShowBaseEffects)
               {
                  this.updateCurrentTabInformations();
               }
               else
               {
                  var _loc4_ = this.api.lang.getItemStats(this._oItem.unicID);
                  if(_loc4_ != undefined)
                  {
                     var _loc5_ = new ank.utils.ExtendedArray();
                     var _loc6_ = new Array();
                     var _loc7_ = _loc4_.split(",");
                     var _loc8_ = 0;
                     while(_loc8_ < _loc7_.length)
                     {
                        var _loc9_ = _loc7_[_loc8_].split("#");
                        _loc9_[0] = _global.parseInt(_loc9_[0],16);
                        _loc9_[1] = _loc9_[1] != "0"?_global.parseInt(_loc9_[1],16):undefined;
                        _loc9_[2] = _loc9_[2] != "0"?_global.parseInt(_loc9_[2],16):undefined;
                        _loc9_[3] = _loc9_[3] != "0"?_global.parseInt(_loc9_[3],16):undefined;
                        _loc6_.push(_loc9_);
                        _loc8_ = _loc8_ + 1;
                     }
                     var _loc10_ = dofus.datacenter.Item.getItemDescriptionEffects(_loc6_);
                     for(var s in _loc10_)
                     {
                        if(_loc10_[s].description.length > 0)
                        {
                           _loc5_.push(_loc10_[s]);
                        }
                     }
                     _loc5_.reverse();
                     this._lstInfos.dataProvider = _loc5_;
                  }
               }
               this._bShowBaseEffects = !this._bShowBaseEffects;
            }
            else
            {
               this.setCurrentTab("Effects");
            }
            break;
         case "_btnTabCharacteristics":
            this.setCurrentTab("Characteristics");
            break;
         case "_btnTabConditions":
            this.setCurrentTab("Conditions");
            break;
         case "_btnAction":
            var _loc11_ = this.api.ui.createPopupMenu();
            _loc11_.addStaticItem(this._oItem.name);
            if(this._bUseButton && this._oItem.canUse)
            {
               _loc11_.addItem(this._parent.api.lang.getText("CLICK_TO_USE"),this,this.dispatchEvent,[{type:"useItem",item:this._oItem}]);
            }
            _loc11_.addItem(this._parent.api.lang.getText("CLICK_TO_INSERT"),this.api.kernel.GameManager,this.api.kernel.GameManager.insertItemInChat,[this._oItem]);
            if(this._bTargetButton && this._oItem.canTarget)
            {
               _loc11_.addItem(this._parent.api.lang.getText("CLICK_TO_TARGET"),this,this.dispatchEvent,[{type:"targetItem",item:this._oItem}]);
            }
            _loc11_.addItem(this._parent.api.lang.getText("ASSOCIATE_RECEIPTS"),this.api.ui,this.api.ui.loadUIComponent,["ItemUtility","ItemUtility",{item:this._oItem}]);
            if(this._bDestroyButton && this._oItem.canDestroy)
            {
               _loc11_.addItem(this._parent.api.lang.getText("CLICK_TO_DESTROY"),this,this.dispatchEvent,[{type:"destroyItem",item:this._oItem}]);
            }
            _loc11_.show(_root._xmouse,_root._ymouse);
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_pbEthereal":
            var _loc3_ = this._oItem.etherealResistance;
            this.gapi.showTooltip(_loc3_.description,oEvent.target,-20);
            break;
         case "_ldrTwoHanded":
            this.gapi.showTooltip(this.api.lang.getText("TWO_HANDS_WEAPON"),this._ldrTwoHanded,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
