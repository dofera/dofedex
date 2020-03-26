class dofus.graphics.gapi.ui.Spells extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Spells";
   static var TAB_LIST = ["Guild","Water","Fire","Earth","Air"];
   static var TAB_TITLE_LIST = ["SPELL_TAB_GUILD_TITLE","SPELL_TAB_WATER_TITLE","SPELL_TAB_FIRE_TITLE","SPELL_TAB_EARTH_TITLE","SPELL_TAB_AIR_TITLE"];
   function Spells()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Spells.CLASS_NAME);
      this.gapi.getUIComponent("Banner").shortcuts.setCurrentTab("Spells");
   }
   function destroy()
   {
      this.gapi.hideTooltip();
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this._nSelectedSpellType = 0;
      this._mcSpellFullInfosPlacer._visible = false;
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this.hideSpellBoostViewer(true);
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._dgSpells.addEventListener("itemRollOver",this);
      this._dgSpells.addEventListener("itemRollOut",this);
      this._dgSpells.addEventListener("itemDrag",this);
      this._dgSpells.addEventListener("itemSelected",this);
      this._cbType.addEventListener("itemSelected",this);
      this.api.datacenter.Player.addEventListener("bonusSpellsChanged",this);
      this.api.datacenter.Player.Spells.addEventListener("modelChanged",this);
   }
   function initData()
   {
      this.updateBonus();
   }
   function initTexts()
   {
      this._winBackground.title = this.api.lang.getText("YOUR_SPELLS");
      this._dgSpells.columnsNames = [this.api.lang.getText("NAME_BIG"),this.api.lang.getText("LEVEL")];
      this._lblBonusTitle.text = this.api.lang.getText("SPELL_BOOST_POINT");
      this._lblSpellType.text = this.api.lang.getText("SPELL_TYPE");
      var _loc2_ = new ank.utils.ExtendedArray();
      _loc2_.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),type:-2});
      _loc2_.push({label:this.api.lang.getText("SPELL_TAB_GUILD"),type:0});
      _loc2_.push({label:this.api.lang.getText("SPELL_TAB_WATER"),type:1});
      _loc2_.push({label:this.api.lang.getText("SPELL_TAB_FIRE"),type:2});
      _loc2_.push({label:this.api.lang.getText("SPELL_TAB_EARTH"),type:3});
      _loc2_.push({label:this.api.lang.getText("SPELL_TAB_AIR"),type:4});
      this._cbType.dataProvider = _loc2_;
      this._cbType.selectedIndex = 1;
   }
   function updateSpells()
   {
      var _loc2_ = this.api.datacenter.Player.Spells;
      var _loc3_ = new ank.utils.ExtendedArray();
      for(var k in _loc2_)
      {
         var _loc4_ = _loc2_[k];
         if(_loc4_.classID != -1 && (_loc4_.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
         {
            _loc3_.push(_loc4_);
         }
      }
      if(this.api.kernel.OptionsManager.getOption("SeeAllSpell") && this.api.datacenter.Basics.canUseSeeAllSpell)
      {
         var _loc5_ = this.api.lang.getClassText(this.api.datacenter.Player.Guild).s;
         var _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            var _loc7_ = _loc5_[_loc6_];
            var _loc8_ = false;
            var _loc9_ = 0;
            while(_loc9_ < _loc3_.length && !_loc8_)
            {
               _loc8_ = _loc3_[_loc9_].ID == _loc7_;
               _loc9_ = _loc9_ + 1;
            }
            var _loc10_ = new dofus.datacenter.Spell(_loc7_,1);
            if(!_loc8_ && (_loc10_.classID == this._nSelectedSpellType || this._nSelectedSpellType == -2))
            {
               _loc3_.push(_loc10_);
            }
            _loc6_ = _loc6_ + 1;
         }
      }
      _loc3_.sortOn("_minPlayerLevel",Array.NUMERIC);
      this._dgSpells.dataProvider = _loc3_;
   }
   function updateBonus(nValue)
   {
      this._lblBonus.text = nValue != undefined?String(nValue):String(this.api.datacenter.Player.BonusPointsSpell);
      this.updateSpells();
   }
   function hideSpellBoostViewer(bHide, oSpell)
   {
      this._sbvSpellBoostViewer._visible = !bHide;
      if(oSpell != undefined)
      {
         this._sbvSpellBoostViewer.spell = oSpell;
      }
   }
   function showDetails(bShow)
   {
      this._sfivSpellFullInfosViewer.removeMovieClip();
      if(bShow)
      {
         this.attachMovie("SpellFullInfosViewer","_sfivSpellFullInfosViewer",this.getNextHighestDepth(),{_x:this._mcSpellFullInfosPlacer._x,_y:this._mcSpellFullInfosPlacer._y});
         this._sfivSpellFullInfosViewer.addEventListener("close",this);
      }
   }
   function boostSpell(oSpell)
   {
      this.api.sounds.events.onSpellsBoostButtonClick();
      if(this.canBoost(oSpell) != undefined)
      {
         var _loc3_ = new dofus.datacenter.Spell(oSpell.ID,oSpell.level + 1);
         if(this.api.datacenter.Player.Level < _loc3_.minPlayerLevel)
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("LEVEL_NEED_TO_BOOST",[_loc3_.minPlayerLevel]),"ERROR_BOX");
            return false;
         }
         this.hideSpellBoostViewer(true);
         this.api.network.Spells.boost(oSpell.ID);
         this._sfivSpellFullInfosViewer.spell = _loc3_;
         return true;
      }
      return false;
   }
   function getCostForBoost(oSpell)
   {
      return oSpell.level >= oSpell.maxLevel?-1:dofus.Constants.SPELL_BOOST_BONUS[oSpell.level];
   }
   function canBoost(oSpell)
   {
      if(oSpell != undefined)
      {
         if(this.getCostForBoost(oSpell) > this.api.datacenter.Player.BonusPointsSpell)
         {
            return false;
         }
         if(oSpell.level < oSpell.maxLevel)
         {
            return true;
         }
      }
      return false;
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_btnClose")
      {
         this.callClose();
      }
   }
   function itemDrag(oEvent)
   {
      if(oEvent.row.item == undefined)
      {
         return undefined;
      }
      if(this.api.datacenter.Player.Level < oEvent.row.item._minPlayerLevel)
      {
         return undefined;
      }
      this.gapi.removeCursor();
      this.gapi.setCursor(oEvent.row.item);
   }
   function itemRollOver(oEvent)
   {
   }
   function itemRollOut(oEvent)
   {
   }
   function itemSelected(oEvent)
   {
      switch(oEvent.target)
      {
         case this._dgSpells:
            if(oEvent.row.item != undefined)
            {
               if(this._sfivSpellFullInfosViewer.spell.ID != oEvent.row.item.ID)
               {
                  this.showDetails(true);
                  this._sfivSpellFullInfosViewer.spell = oEvent.row.item;
               }
               else
               {
                  this.showDetails(false);
               }
            }
            break;
         case this._cbType:
            this._nSelectedSpellType = oEvent.target.selectedItem.type;
            this.updateSpells();
      }
   }
   function bonusSpellsChanged(oEvent)
   {
      this.updateBonus(oEvent.value);
   }
   function close(oEvent)
   {
      this.showDetails(false);
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.eventName)
      {
         case "updateOne":
         case "updateAll":
      }
      this.updateSpells();
      this.hideSpellBoostViewer(true);
   }
}
