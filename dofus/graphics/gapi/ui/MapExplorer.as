class dofus.graphics.gapi.ui.MapExplorer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MapExplorer";
   static var OVER_TRIANGLE_TRANSFORM = {ra:0,rb:255,ga:0,gb:102,ba:0,bb:0};
   static var OUT_TRIANGLE_TRANSFORM = {ra:0,rb:184,ga:0,gb:177,ba:0,bb:143};
   static var DIRECTIONS = new Array("NW","N","NE","W","E","SW","S","SE");
   static var FILTER_CONQUEST_ID = 5;
   function MapExplorer()
   {
      super();
   }
   function __set__mapID(nMapID)
   {
      this._dmMap = new dofus.datacenter.DofusMap(nMapID);
      return this.__get__mapID();
   }
   function __set__pointer(sPointer)
   {
      this._sPointer = sPointer;
      return this.__get__pointer();
   }
   function __get__dungeonID()
   {
      return Number(this.api.lang.getMapText(this.api.datacenter.Map.id).d);
   }
   function __get__dungeonCurrentMap()
   {
      return this.dungeon.m[this.api.datacenter.Map.id];
   }
   function __get__dungeon()
   {
      return this.api.lang.getDungeonText(this.dungeonID);
   }
   function multipleSelect(aCoords)
   {
      this._mnMap.clear("highlight");
      for(var k in aCoords)
      {
         var _loc3_ = aCoords[k];
         if(_loc3_ != undefined)
         {
            var _loc4_ = _loc3_.type;
            var _loc5_ = _loc3_.x;
            var _loc6_ = _loc3_.y;
            var _loc7_ = _loc3_.mapID;
            var _loc8_ = _loc3_.label;
            var _loc9_ = Number(this.api.lang.getMapText(_loc7_).d);
            if(_loc9_ == this.dungeonID || _global.isNaN(this.dungeonID))
            {
               if(!_global.isNaN(this.dungeonID))
               {
                  var _loc10_ = this.dungeon.m[_loc7_];
                  var _loc11_ = this.dungeonCurrentMap;
                  if(_loc11_.z != _loc10_.z)
                  {
                     continue;
                  }
                  _loc5_ = _loc10_.x;
                  _loc6_ = _loc10_.y;
               }
               switch(_loc4_)
               {
                  case 1:
                     var _loc12_ = dofus.Constants.FLAG_MAP_PHOENIX;
                     break;
                  case 2:
                     _loc12_ = dofus.Constants.FLAG_MAP_GROUP;
                     _loc8_ = _loc5_ + "," + _loc6_ + " (" + _global.API.ui.getUIComponent("Party").getMemberById(aCoords[k].playerID).name + ")";
                     if(_loc8_ == undefined)
                     {
                        delete aCoords.k;
                        continue;
                     }
                     break;
                  case 3:
                     _loc12_ = dofus.Constants.FLAG_MAP_SEEK;
                     _loc8_ = _loc5_ + "," + _loc6_ + " (" + aCoords[k].playerName + ")";
                     break;
                  default:
                     _loc12_ = dofus.Constants.FLAG_MAP_OTHERS;
               }
               var _loc13_ = this._mnMap.addXtraClip("UI_MapExplorerFlag","highlight",_loc5_,_loc6_,_loc12_,100,false,true);
               if(_loc8_ != undefined)
               {
                  _loc13_.label = _loc13_.label == undefined?_loc8_:_loc13_.label + "\n" + _loc8_;
                  _loc13_.gapi = this.gapi;
                  _loc13_.onRollOver = function()
                  {
                     this.gapi.showTooltip(this.label,this,10);
                  };
                  _loc13_.onRollOut = function()
                  {
                     this.gapi.hideTooltip();
                  };
               }
            }
         }
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.MapExplorer.CLASS_NAME);
      this.api.gfx._visible = false;
      ank.utils.MouseEvents.addListener(this);
      this.gapi.removeCursor(true);
   }
   function destroy()
   {
      if(this.dungeon == undefined)
      {
         this.api.datacenter.Basics.mapExplorer_zoom = this._mnMap.zoom;
         this.api.datacenter.Basics.mapExplorer_coord = {x:this._mnMap.currentX,y:this._mnMap.currentY};
      }
      this.gapi.hideTooltip();
      this.gapi.removeCursor(true);
      this.api.gfx._visible = true;
      this.api.network.Conquest.worldInfosLeave();
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
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.layoutContent});
      this._lblArea._visible = false;
   }
   function initTexts()
   {
      this._winBg.title = this.api.lang.getText("WORLD_MAP");
      this._lblZoom.text = this.api.lang.getText("ZOOM");
      if(this.dungeon != undefined)
      {
         this._lblArea._visible = true;
         this._lblArea.text = this.dungeon.n;
      }
      else
      {
         this._lblArea.text = this.api.lang.getText("AREA");
      }
      this._lblHints.text = this.api.lang.getText("HINTS_FILTER");
   }
   function layoutContent()
   {
      if(this.dungeon == undefined)
      {
         var _loc2_ = this.api.lang.getHintsCategories();
         _loc2_[-1] = {n:this.api.lang.getText("OPTION_GRID"),c:"Yellow"};
         var _loc3_ = this.api.kernel.OptionsManager.getOption("MapFilters");
         var _loc4_ = 0;
         var _loc5_ = -1;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc2_[_loc5_] != undefined)
            {
               var _loc6_ = new Object();
               _loc6_._y = this._mcFilterPlacer._y;
               _loc6_._x = this._mcFilterPlacer._x + _loc4_;
               _loc6_.backgroundDown = "ButtonCheckDown";
               _loc6_.backgroundUp = "ButtonCheckUp";
               _loc6_.styleName = _loc2_[_loc5_].c + "MapHintCheckButton";
               _loc6_.toggle = true;
               _loc6_.selected = false;
               _loc6_.enabled = true;
               var _loc7_ = (ank.gapi.controls.Button)this.attachMovie("Button","_mcFilter" + _loc5_,this.getNextHighestDepth(),_loc6_);
               _loc7_.setSize(12,12);
               _loc7_.addEventListener("click",this);
               _loc7_.addEventListener("over",this);
               _loc7_.addEventListener("out",this);
               _loc4_ = _loc4_ + 17;
            }
            if(_loc5_ != -1)
            {
               this.showHintsCategory(_loc5_,_loc3_[_loc5_] == 1);
            }
            _loc5_ = _loc5_ + 1;
         }
         this._mnMap.showGrid = this.api.datacenter.Basics.mapExplorer_grid;
         this["_mcFilter-1"].selected = this.api.datacenter.Basics.mapExplorer_grid;
      }
      else
      {
         this._lblHints._visible = false;
         this._mnMap.showGrid = false;
      }
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnZoomPlus.addEventListener("click",this);
      this._btnZoomMinous.addEventListener("click",this);
      this._btnMove.addEventListener("click",this);
      this._btnSelect.addEventListener("click",this);
      this._btnCenterOnMe.addEventListener("click",this);
      this._btnZoomPlus.addEventListener("over",this);
      this._btnZoomMinous.addEventListener("over",this);
      this._btnMove.addEventListener("over",this);
      this._btnSelect.addEventListener("over",this);
      this._btnCenterOnMe.addEventListener("over",this);
      this._btnZoomPlus.addEventListener("out",this);
      this._btnZoomMinous.addEventListener("out",this);
      this._btnMove.addEventListener("out",this);
      this._btnSelect.addEventListener("out",this);
      this._btnCenterOnMe.addEventListener("out",this);
      this._mnMap.addEventListener("overMap",this);
      this._mnMap.addEventListener("outMap",this);
      this._mnMap.addEventListener("over",this);
      this._mnMap.addEventListener("out",this);
      this._mnMap.addEventListener("zoom",this);
      this._mnMap.addEventListener("select",this);
      this._mnMap.addEventListener("xtraLayerLoad",this);
      if(this.api.datacenter.Player.isAuthorized)
      {
         this._mnMap.addEventListener("doubleClick",this);
      }
      this._vsZoom.addEventListener("change",this);
      this.api.datacenter.Conquest.addEventListener("worldDataChanged",this);
   }
   function initData()
   {
      if(this.dungeon != undefined)
      {
         this.initDungeonMap();
      }
      else
      {
         this.api.network.Conquest.worldInfosJoin();
         this.initWorldMap();
      }
   }
   function initWorldMap()
   {
      if(this._dmMap == undefined)
      {
         this._dmMap = this.api.datacenter.Map;
         var _loc2_ = this.api.datacenter.Basics.mapExplorer_coord;
      }
      this.showMapSuperArea(this._dmMap.superarea);
      if(_loc2_ != undefined)
      {
         this._mnMap.setMapPosition(_loc2_.x,_loc2_.y);
      }
      this._mnMap.zoom = this.api.datacenter.Basics.mapExplorer_zoom;
   }
   function showMapSuperArea(nSuperAreaID)
   {
      if(nSuperAreaID == undefined)
      {
         return undefined;
      }
      this._mnMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + nSuperAreaID + ".swf";
      this._mnMap.clear();
      this._mnMap.setMapPosition(this._dmMap.x,this._dmMap.y);
      var _loc3_ = this.api.datacenter.Map;
      this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","rectangle",_loc3_.x,_loc3_.y,dofus.Constants.MAP_CURRENT_POSITION,50);
      if(this._dmMap != _loc3_)
      {
         this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","rectangle",this._dmMap.x,this._dmMap.y,dofus.Constants.MAP_WAYPOINT_POSITION,50);
      }
      if(this.api.datacenter.Basics.banner_targetCoords != undefined)
      {
         this._mnMap.addXtraClip("UI_MapExplorerFlag","flag",this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],255);
      }
      if(this.api.datacenter.Basics.aks_infos_highlightCoords != undefined)
      {
         this.multipleSelect(this.api.datacenter.Basics.aks_infos_highlightCoords);
      }
   }
   function hideArrows(bHide)
   {
      this._mcTriangleNW._visible = this._mcTriangleN._visible = this._mcTriangleNE._visible = this._mcTriangleW._visible = this._mcTriangleE._visible = this._mcTriangleSW._visible = this._mcTriangleS._visible = this._mcTriangleSE._visible = !bHide;
   }
   function showHintsCategory(categoryID, bShow)
   {
      var _loc4_ = this.api.kernel.OptionsManager.getOption("MapFilters");
      _loc4_[categoryID] = bShow;
      this.api.kernel.OptionsManager.setOption("MapFilters",_loc4_);
      this["_mcFilter" + categoryID].selected = bShow;
      var _loc5_ = "hints" + categoryID;
      if(bShow)
      {
         this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE,_loc5_);
      }
      else
      {
         this._mnMap.clear(_loc5_);
      }
   }
   function drawHintsOnCategoryLayer(categoryID)
   {
      var _loc3_ = "hints" + categoryID;
      if(dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID)
      {
         var _loc4_ = this.getConquestAreaList();
      }
      else
      {
         _loc4_ = this.api.lang.getHintsByCategory(categoryID);
      }
      var _loc5_ = 0;
      while(_loc5_ < _loc4_.length)
      {
         var _loc6_ = new dofus.datacenter.Hint(_loc4_[_loc5_]);
         if((_loc6_.superAreaID == this._dmMap.superarea || dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID && categoryID != 5) && _loc6_.y != undefined)
         {
            var _loc7_ = this._mnMap.addXtraClip(_loc6_.gfx,_loc3_,_loc6_.x,_loc6_.y,undefined,undefined,true);
            _loc7_.oHint = _loc6_;
            _loc7_.gapi = this.gapi;
            _loc7_.onRollOver = function()
            {
               this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")",this,-20);
            };
            _loc7_.onRollOut = function()
            {
               this.gapi.hideTooltip();
            };
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function getConquestAreaList()
   {
      var _loc2_ = this.api.datacenter.Conquest.worldDatas;
      if(!_loc2_.areas.length)
      {
         this.addToQueue({object:this,method:this.drawHintsOnCategoryLayer,params:[dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
      }
      var _loc3_ = new Array();
      var _loc4_ = new String();
      var _loc5_ = 0;
      while(_loc5_ < _loc2_.areas.length)
      {
         if(_loc2_.areas[_loc5_].alignment == 1)
         {
            var _loc7_ = this.api.lang.getText("BONTARIAN_PRISM");
            var _loc6_ = 420;
         }
         if(_loc2_.areas[_loc5_].alignment == 2)
         {
            _loc7_ = this.api.lang.getText("BRAKMARIAN_PRISM");
            _loc6_ = 421;
         }
         _loc3_.push({g:_loc6_,m:_loc2_.areas[_loc5_].prism,n:_loc7_,superAreaID:this.api.lang.getMapAreaText(_loc2_.areas[_loc5_].id).a});
         _loc5_ = _loc5_ + 1;
      }
      return _loc3_;
   }
   function initDungeonMap(nDungeon)
   {
      var _loc3_ = this.api.datacenter.Map;
      this._mnMap.clear();
      this._mnMap.createXtraLayer("dungeonParchment");
      this._mnMap.createXtraLayer("dungeonMap");
      this._mnMap.createXtraLayer("highlight");
      var _loc4_ = this.dungeon.m;
      var _loc5_ = this.dungeonCurrentMap;
      for(var a in _loc4_)
      {
         var _loc6_ = _loc4_[a];
         if(_loc5_.z == _loc6_.z)
         {
            var _loc7_ = this._mnMap.addXtraClip("UI_MapExplorerRectangle","dungeonMap",_loc6_.x,_loc6_.y);
            if(_loc6_.n != undefined)
            {
               _loc7_.label = _loc6_.n + " (" + _loc6_.x + "," + _loc6_.y + ")";
               _loc7_.gapi = this.gapi;
               _loc7_.onRollOver = function()
               {
                  this.gapi.showTooltip(this.label,this,-20);
               };
               _loc7_.onRollOut = function()
               {
                  this.gapi.hideTooltip();
               };
            }
         }
      }
      var _loc8_ = this.dungeonCurrentMap;
      this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","dungeonMap",_loc8_.x,_loc8_.y,dofus.Constants.MAP_CURRENT_POSITION,50);
      this._mnMap.setMapPosition(_loc8_.x,_loc8_.y);
      this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE,"dungeonHints");
      this._mnMap.loadXtraLayer(dofus.Constants.LOCAL_MAPS_PATH + "dungeon.swf","dungeonParchment");
   }
   function initDungeonParchment()
   {
      var _loc2_ = this._mnMap.getXtraLayer("dungeonParchment");
      var _loc3_ = this._mnMap.getXtraLayer("dungeonMap");
      var _loc4_ = _loc3_._width;
      var _loc5_ = _loc3_._height;
      var _loc6_ = _loc2_.view._x;
      var _loc7_ = _loc2_.view._y;
      var _loc8_ = _loc2_.view._width;
      var _loc9_ = _loc2_.view._height;
      var _loc10_ = 100;
      if(_loc4_ > _loc8_ || _loc5_ > _loc9_)
      {
         var _loc11_ = _loc8_ / _loc4_;
         var _loc12_ = _loc9_ / _loc5_;
         if(_loc12_ > _loc11_)
         {
            _loc10_ = 100 * _loc4_ / _loc8_;
         }
         else
         {
            _loc10_ = 100 * _loc5_ / _loc9_;
         }
         _loc2_._xscale = _loc2_._yscale = _loc10_;
      }
      var _loc13_ = _loc6_ * _loc10_ / 100 + (_loc8_ * _loc10_ / 100 - _loc4_) / 2;
      var _loc14_ = _loc7_ * _loc10_ / 100 + (_loc9_ * _loc10_ / 100 - _loc5_) / 2;
      _loc2_.parchment._x = (- _loc13_) * 100 / _loc10_;
      _loc2_.parchment._y = (- _loc14_) * 100 / _loc10_;
      var _loc15_ = _loc2_._parent._xscale;
      var _loc16_ = _loc2_._width * _loc10_ / 100 * _loc15_ / 100;
      var _loc17_ = _loc2_._height * _loc10_ / 100 * _loc15_ / 100;
      var _loc18_ = this._mnMap._width;
      var _loc19_ = this._mnMap._height;
      if(_loc16_ > _loc17_)
      {
         this._mnMap.zoom = this._mnMap.zoom * _loc18_ / _loc16_;
      }
      else
      {
         this._mnMap.zoom = this._mnMap.zoom * _loc19_ / _loc17_;
      }
      this._mnMap.setMapPosition(this.dungeonCurrentMap.x,this.dungeonCurrentMap.y);
   }
   function drawHintsDungeon()
   {
      var _loc2_ = this.dungeon.m;
      for(var a in _loc2_)
      {
         var _loc3_ = _loc2_[a];
         if(_loc3_.i != undefined)
         {
            var _loc4_ = this._mnMap.addXtraClip(_loc3_.i,"dungeonHints",_loc3_.x,_loc3_.y,undefined,undefined,true);
            if(_loc3_.n != undefined)
            {
               _loc4_.label = _loc3_.n + " (" + _loc3_.x + "," + _loc3_.y + ")";
               _loc4_.gapi = this.gapi;
               _loc4_.onRollOver = function()
               {
                  this.gapi.showTooltip(this.label,this,-20);
               };
               _loc4_.onRollOut = function()
               {
                  this.gapi.hideTooltip();
               };
            }
         }
      }
   }
   function onMouseWheel(nIncrement, mcTarget)
   {
      if(mcTarget._target.indexOf("_mnMap",0) != -1)
      {
         this._mnMap.zoom = this._mnMap.zoom + (nIncrement >= 0?5:-5);
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
            this.callClose();
            break;
         case "_btnZoomPlus":
            this.api.sounds.events.onMapButtonClick();
            this._mnMap.interactionMode = "zoom+";
            this._btnZoomMinous.selected = false;
            this._btnMove.selected = false;
            this._btnSelect.selected = false;
            this._btnZoomPlus.enabled = false;
            this._btnZoomMinous.enabled = true;
            this._btnMove.enabled = true;
            this._btnSelect.enabled = true;
            this.hideArrows(true);
            break;
         case "_btnZoomMinous":
            this.api.sounds.events.onMapButtonClick();
            this._mnMap.interactionMode = "zoom-";
            this._btnZoomPlus.selected = false;
            this._btnMove.selected = false;
            this._btnSelect.selected = false;
            this._btnZoomPlus.enabled = true;
            this._btnZoomMinous.enabled = false;
            this._btnMove.enabled = true;
            this._btnSelect.enabled = true;
            this.hideArrows(true);
            break;
         case "_btnMove":
            this.api.sounds.events.onMapButtonClick();
            this._mnMap.interactionMode = "move";
            this._btnZoomMinous.selected = false;
            this._btnZoomPlus.selected = false;
            this._btnSelect.selected = false;
            this._btnZoomPlus.enabled = true;
            this._btnZoomMinous.enabled = true;
            this._btnMove.enabled = false;
            this._btnSelect.enabled = true;
            this.hideArrows(false);
            break;
         case "_btnSelect":
            this.api.sounds.events.onMapButtonClick();
            this._mnMap.interactionMode = "select";
            this._btnZoomMinous.selected = false;
            this._btnZoomPlus.selected = false;
            this._btnMove.selected = false;
            this._btnZoomPlus.enabled = true;
            this._btnZoomMinous.enabled = true;
            this._btnMove.enabled = true;
            this._btnSelect.enabled = false;
            this.hideArrows(true);
            break;
         case "_btnCenterOnMe":
            if(this.dungeon != undefined)
            {
               var _loc3_ = this.dungeonCurrentMap;
               this._mnMap.setMapPosition(_loc3_.x,_loc3_.y);
            }
            else
            {
               this._mnMap.setMapPosition(this.api.datacenter.Map.x,this.api.datacenter.Map.y);
            }
            break;
         default:
            var _loc4_ = oEvent.target._name;
            var _loc5_ = Number(_loc4_.substr(9,_loc4_.length));
            if(_loc5_ != -1)
            {
               this.showHintsCategory(_loc5_,!this.api.kernel.OptionsManager.getOption("MapFilters")[_loc5_]);
               this.api.ui.getUIComponent("Banner").illustration.updateHints();
            }
            else
            {
               var _loc6_ = !this.api.datacenter.Basics.mapExplorer_grid;
               this.api.datacenter.Basics.mapExplorer_grid = _loc6_;
               this._mnMap.showGrid = _loc6_;
            }
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._mnMap:
            var _loc3_ = oEvent.target._name.substr(4);
            this.setMovieClipTransform(this["_mcTriangle" + _loc3_],dofus.graphics.gapi.ui.MapExplorer.OVER_TRIANGLE_TRANSFORM);
            break;
         case this._btnZoomPlus:
            this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_PLUS"),oEvent.target,-20);
            break;
         case this._btnZoomMinous:
            this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_MINOUS"),oEvent.target,-20);
            break;
         case this._btnMove:
            this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_MOVE"),oEvent.target,-20);
            break;
         case this._btnSelect:
            this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_SELECT"),oEvent.target,-20);
            break;
         case this._btnCenterOnMe:
            this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_CENTER"),oEvent.target,-20);
            break;
         default:
            var _loc4_ = oEvent.target._name;
            this.gapi.showTooltip(this.api.lang.getHintsCategory(Number(_loc4_.substr(9,_loc4_.length))).n,oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      if((var _loc0_ = oEvent.target) !== this._mnMap)
      {
         this.gapi.hideTooltip();
      }
      else
      {
         var _loc3_ = 0;
         while(_loc3_ < dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS.length)
         {
            this.setMovieClipTransform(this["_mcTriangle" + dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS[_loc3_]],dofus.graphics.gapi.ui.MapExplorer.OUT_TRIANGLE_TRANSFORM);
            _loc3_ = _loc3_ + 1;
         }
      }
   }
   function change(oEvent)
   {
      this._mnMap.zoom = oEvent.target.value;
   }
   function zoom(oEvent)
   {
      this._vsZoom.value = oEvent.target.zoom;
   }
   function select(oEvent)
   {
      this.api.sounds.events.onMapFlag();
      var _loc3_ = oEvent.coordinates;
      this._mnMap.clear("flag");
      if(this.api.kernel.GameManager.updateCompass(_loc3_.x,_loc3_.y,false))
      {
         this._mnMap.addXtraClip("UI_MapExplorerFlag","flag",_loc3_.x,_loc3_.y,255);
      }
   }
   function overMap(oEvent)
   {
      if(this.dungeon == undefined)
      {
         var _loc3_ = this.api.kernel.AreasManager.getAreaIDFromCoordinates(oEvent.coordinates.x,oEvent.coordinates.y,this._dmMap.superarea);
         var _loc4_ = this.api.kernel.AreasManager.getSubAreaIDFromCoordinates(oEvent.coordinates.x,oEvent.coordinates.y,this._dmMap.superarea);
         if(_loc4_ != undefined)
         {
            var _loc5_ = this.api.lang.getMapSubAreaText(_loc4_).n;
            var _loc6_ = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(_loc4_);
            if(_loc6_ != undefined)
            {
               var _loc7_ = _loc6_.color;
               var _loc8_ = this.api.lang.getMapAreaText(_loc3_).n + (_loc5_.substr(0,2) != "//"?" (" + _loc5_ + ") - ":" - ") + _loc6_.alignment.name;
            }
            else
            {
               _loc7_ = dofus.Constants.AREA_NO_ALIGNMENT_COLOR;
               _loc8_ = this.api.lang.getMapAreaText(_loc3_).n + (_loc5_.substr(0,2) != "//"?" (" + _loc5_ + ")":"");
            }
            if(this._vsZoom.value != 2)
            {
               this._mnMap.addSubareaClip(_loc4_,_loc7_ == -1?dofus.Constants.AREA_NO_ALIGNMENT_COLOR:_loc7_,20);
            }
            this._lblAreaName.text = _loc8_;
            this._lblArea._visible = true;
         }
         else
         {
            this.outMap();
         }
      }
   }
   function outMap(oEvent)
   {
      if(this.dungeon == undefined)
      {
         this._mnMap.removeAreaClip();
         if(this._lblAreaName.text != undefined)
         {
            this._lblAreaName.text = "";
         }
         this._lblArea._visible = false;
      }
   }
   function doubleClick(oEvent)
   {
      if(!this.api.datacenter.Game.isFight && this.dungeon == undefined)
      {
         var _loc3_ = oEvent.coordinates.x;
         var _loc4_ = oEvent.coordinates.y;
         if(_loc3_ != undefined && _loc4_ != undefined)
         {
            this.api.network.Basics.autorisedMoveCommand(_loc3_,_loc4_);
         }
      }
   }
   function xtraLayerLoad(oEvent)
   {
      switch(oEvent.mc._name)
      {
         case "dungeonHints":
            this.drawHintsDungeon();
            break;
         case "dungeonParchment":
            this.initDungeonParchment();
            break;
         default:
            var _loc3_ = oEvent.mc._name;
            this.drawHintsOnCategoryLayer(Number(_loc3_.substr(5,_loc3_.length)));
      }
   }
   function worldDataChanged(oEvent)
   {
      if(this["_mcFilter" + dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID].selected)
      {
         this.addToQueue({object:this,method:this.drawHintsOnCategoryLayer,params:[dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
      }
   }
}
