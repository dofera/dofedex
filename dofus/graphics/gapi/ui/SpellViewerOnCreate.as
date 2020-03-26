class dofus.graphics.gapi.ui.SpellViewerOnCreate extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "SpellViewerOnCreate";
   static var SPELLS_DISPLAYED = 20;
   function SpellViewerOnCreate()
   {
      super();
   }
   function __get__breed()
   {
      return this._nBreed;
   }
   function __set__breed(n)
   {
      this._nBreed = n;
      return this.__get__breed();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.SpellViewerOnCreate.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initText});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function initText()
   {
      this._lblBreedSpells.text = this.api.lang.getText("CLASS_SPELLS");
      this._lblBreedName.text = this.api.lang.getClassText(this._nBreed).sn;
      this._lbViewSpell.text = this.api.lang.getText("SEE_ALL_SPELLS");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose.addEventListener("over",this);
      this._btnClose.addEventListener("out",this);
      this._bhClose.addEventListener("click",this);
      this._mcWindowBg.onRelease = function()
      {
      };
      this._mcWindowBg.useHandCursor = false;
      this._mcViewAllSpell.onRelease = function()
      {
         var aTarget = new Object();
         var _loc2_ = 0;
         while(_loc2_ < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
         {
            var _loc3_ = this._parent["_ctr" + _loc2_];
            var _loc4_ = this._parent._mcPlacerSpell._x;
            var _loc5_ = this._parent._mcPlacerSpell._y;
            var _loc6_ = _loc4_ + (_loc2_ - (_loc2_ <= 9?0:10)) * (_loc3_.width + 5);
            var _loc7_ = _loc5_ + (5 + _loc3_.height) * (_loc2_ <= 9?0:1);
            aTarget["_ctr" + _loc2_] = {x:_loc6_,y:_loc7_};
            _loc3_.onEnterFrame = function()
            {
               this._x = this._x + (aTarget[this._name].x - this._x) / 2;
               this._y = this._y + (aTarget[this._name].y - this._y) / 2;
               this._alpha = this._alpha + (100 - this._alpha) / 2;
               if(Math.abs(this._x - aTarget[this._name].x) < 0.5 && (Math.abs(this._y - aTarget[this._name].y) < 0.5 && Math.abs(this._alpha - 100) < 0.5))
               {
                  delete this.onEnterFrame;
               }
            };
            _loc2_ = _loc2_ + 1;
         }
         var ref = this._parent;
         var _loc8_ = 0;
         this.onEnterFrame = function()
         {
            var _loc2_ = (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y) / 2;
            ref._mcSpellDesc._y = ref._mcSpellDesc._y + _loc2_;
            ref._mcWindowBg._y = ref._mcWindowBg._y + _loc2_;
            if(Math.abs(ref._mcSpellDesc._y - ref._mcPlacerAllSpell._y) < 0.5)
            {
               ref._mcWindowBg._y = ref._mcWindowBg._y + (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y);
               ref._mcSpellDesc._y = ref._mcPlacerAllSpell._y;
               delete this.onEnterFrame;
            }
         };
         this._parent._mcBgViewAllSpell1._visible = false;
         this._parent._mcBgViewAllSpell2._visible = false;
         this._parent._lbViewSpell._visible = false;
         delete this.onRelease;
      };
      var _loc2_ = 0;
      while(_loc2_ < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
      {
         var _loc3_ = this["_ctr" + _loc2_];
         _loc3_.addEventListener("over",this);
         _loc3_.addEventListener("out",this);
         _loc3_.addEventListener("click",this);
         _loc2_ = _loc2_ + 1;
      }
   }
   function initData()
   {
      var _loc2_ = dofus.Constants.SPELLS_ICONS_PATH;
      var _loc3_ = this.api.lang.getClassText(this._nBreed).s;
      var _loc4_ = 0;
      while(_loc4_ < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
      {
         var _loc5_ = this["_ctr" + _loc4_];
         _loc5_.contentPath = _loc2_ + _loc3_[_loc4_] + ".swf";
         _loc5_.params = {spellID:_loc3_[_loc4_]};
         _loc5_._alpha = _loc4_ >= 3?0:100;
         _loc4_ = _loc4_ + 1;
      }
      this.showSpellInfo(_loc3_[0],1);
   }
   function showSpellInfo(nSpellID, nLevel)
   {
      this._nSpellID = nSpellID;
      var _loc4_ = this.api.kernel.CharactersManager.getSpellObjectFromData(nSpellID + "~" + nLevel + "~");
      if(!_loc4_.isValid)
      {
         if(nLevel != 1)
         {
            this.showSpellInfo(nSpellID,1);
            return undefined;
         }
         _loc4_ = undefined;
      }
      var _loc5_ = 1;
      while(_loc5_ < 7)
      {
         var _loc6_ = this["_btnLevel" + _loc5_];
         _loc6_.selected = _loc5_ == nLevel;
         _loc5_ = _loc5_ + 1;
      }
      if(_loc4_.name == undefined)
      {
         this._mcSpellDesc._lblSpellName.text = "";
         this._mcSpellDesc._lblSpellRange.text = "";
         this._mcSpellDesc._lblSpellAP.text = "";
         this._mcSpellDesc._txtSpellDescription.text = "";
         this._mcSpellDesc._ldrSpellBig.contentPath = "";
      }
      else if(this._mcSpellDesc._lblSpellName.text != undefined)
      {
         this._mcSpellDesc._lblSpellName.text = _loc4_.name;
         this._mcSpellDesc._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + _loc4_.rangeStr;
         this._mcSpellDesc._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + _loc4_.apCost;
         this._mcSpellDesc._txtSpellDescription.text = _loc4_.description + "\n" + _loc4_.descriptionNormalHit;
         this._mcSpellDesc._ldrSpellBig.contentPath = _loc4_.iconFile;
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._bhClose:
         case this._btnClose:
            this.unloadThis();
            break;
         default:
            this.showSpellInfo(oEvent.target.params.spellID,1);
      }
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target) !== this._btnClose)
      {
         var _loc3_ = (dofus.datacenter.Spell)this.api.kernel.CharactersManager.getSpellObjectFromData(oEvent.target.params.spellID + "~1~");
         this.gapi.showTooltip(_loc3_.name + ", " + this.api.lang.getText("REQUIRED_SPELL_LEVEL").toLowerCase() + ": " + _loc3_.minPlayerLevel,oEvent.target,-20);
      }
      else
      {
         this.gapi.showTooltip(this.api.lang.getText("CLOSE"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
