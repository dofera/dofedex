class dofus.graphics.gapi.controls.ConquestZonesViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ConquestZonesViewer";
   static var FILTER_VULNERALE_AREAS = -4;
   static var FILTER_CAPTURABLE_AREAS = -3;
   static var FILTER_ALL_AREAS = -2;
   static var FILTER_HOSTILE_AREAS = -1;
   function ConquestZonesViewer()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ConquestZonesViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._lblFilter.text = this.api.lang.getText("FILTER");
      this._lblAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"),null,false);
      this._lblAreaTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"),null,true);
      this._lblAreaDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
      this._lblVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"),null,false);
      this._lblVillageTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"),null,true);
      this._lblVillageDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_DOOR_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
   }
   function addListeners()
   {
      var ref = this;
      this._mcGotAreasInteractivity.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcGotAreasInteractivity.onRollOut = function()
      {
         ref.out({target:this});
      };
      this._mcGotVillagesInteractivity.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcGotVillagesInteractivity.onRollOut = function()
      {
         ref.out({target:this});
      };
      this.api.datacenter.Conquest.addEventListener("worldDataChanged",this);
      this._cbFilter.addEventListener("itemSelected",this);
   }
   function refreshAreaList()
   {
      var _loc2_ = this.api.datacenter.Conquest.worldDatas;
      var _loc3_ = this._cbFilter.selectedItem.value;
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = new String();
      var _loc6_ = 0;
      while(_loc6_ < _loc2_.areas.length)
      {
         if(!(_loc3_ == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS && !_loc2_.areas[_loc6_].fighting))
         {
            if(!(_loc3_ == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS && !_loc2_.areas[_loc6_].isCapturable()))
            {
               if(!(_loc3_ == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS && !_loc2_.areas[_loc6_].isVulnerable()))
               {
                  if(!(_loc3_ >= 0 && _loc2_.areas[_loc6_].alignment != _loc3_))
                  {
                     if(_loc5_ != _loc2_.areas[_loc6_].areaName)
                     {
                        _loc4_.push({area:_loc2_.areas[_loc6_].areaId});
                        _loc5_ = _loc2_.areas[_loc6_].areaName;
                     }
                     _loc4_.push(_loc2_.areas[_loc6_]);
                  }
               }
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      this._lstAreas.dataProvider = _loc4_;
   }
   function initData()
   {
      var _loc2_ = this.api.datacenter.Conquest.worldDatas;
      this._lblGotAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"),"f",false) + " : " + _loc2_.ownedAreas + " / " + _loc2_.possibleAreas + " / " + _loc2_.totalAreas;
      this._lblGotVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"),"m",false) + " : " + _loc2_.ownedVillages + " / " + _loc2_.totalVillages;
      this.refreshAreaList();
      this._lstVillages.dataProvider = _loc2_.villages;
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = this.api.lang.getAlignments();
      for(var s in _loc4_)
      {
         if(_loc4_[s].c)
         {
            _loc3_.push({label:this.api.lang.getText("CONQUEST_ALIGNED_AREAS",[_loc4_[s].n]),value:s});
         }
      }
      _loc3_.push({label:this.api.lang.getText("CONQUEST_HOSTILE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS});
      _loc3_.push({label:this.api.lang.getText("CONQUEST_CAPTURABLE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS});
      _loc3_.push({label:this.api.lang.getText("CONQUEST_VULNERALE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS});
      _loc3_.push({label:this.api.lang.getText("CONQUEST_ALL_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_ALL_AREAS});
      this._cbFilter.dataProvider = _loc3_;
      this._cbFilter.selectedIndex = _loc3_.findFirstItem("value",this.api.kernel.OptionsManager.getOption("ConquestFilter")).index;
   }
   function over(event)
   {
      var _loc3_ = this.api.datacenter.Conquest.worldDatas;
      switch(event.target)
      {
         case this._mcGotAreasInteractivity:
            this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_ZONES",[_loc3_.ownedAreas,_loc3_.possibleAreas,_loc3_.ownedVillages,_loc3_.totalAreas]),this._mcGotAreasInteractivity,-55);
            break;
         case this._mcGotVillagesInteractivity:
            this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_VILLAGES",[_loc3_.ownedVillages,_loc3_.totalVillages]),this._mcGotVillagesInteractivity,-20);
      }
   }
   function out(event)
   {
      this.api.ui.hideTooltip();
   }
   function worldDataChanged(event)
   {
      this.addToQueue({object:this,method:this.initData});
   }
   function itemSelected(event)
   {
      this.api.kernel.OptionsManager.setOption("ConquestFilter",this._cbFilter.selectedItem.value);
      this.refreshAreaList();
   }
}
