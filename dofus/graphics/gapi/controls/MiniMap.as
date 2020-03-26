class dofus.graphics.gapi.controls.MiniMap extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MiniMap";
   static var HIDE_FLAG_ZONE = [[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,0,0,1,0,0,1],[1,0,0,0,0,0,1],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,1],[1,0,0,0,0,0,1],[1,1,0,0,0,1,1]];
   static var MAP_IMG_WIDTH = 15;
   static var MAP_IMG_HEIGHT = 15;
   var _aFlags = new Array();
   var _nMapScale = 40;
   var _nTileWidth = 40;
   var _nTileHeight = 23;
   function MiniMap()
   {
      super();
   }
   function updateFlags()
   {
      this.updateDataMap();
      if(this._oMap.x == undefined || this._oMap.y == undefined)
      {
         this.addToQueue({object:this,method:this.updateFlags});
         return undefined;
      }
      this.clearFlag();
      if(this.api.datacenter.Basics.banner_targetCoords)
      {
         this.addFlag(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],255);
      }
      if(this.api.datacenter.Basics.aks_infos_highlightCoords.length)
      {
         var _loc2_ = this.api.datacenter.Basics.aks_infos_highlightCoords;
         for(var i in _loc2_)
         {
            if(_loc2_[i])
            {
               if(_loc2_[i].miniMapTagId == undefined)
               {
                  _loc2_[i].miniMapTagId = this._nRandomTag;
               }
               if(_loc2_[i].miniMapTagId != this._nRandomTag)
               {
                  delete register2.i;
               }
               else
               {
                  switch(_loc2_[i].type)
                  {
                     case 1:
                        if(!_loc3_)
                        {
                           var _loc3_ = _loc2_[i];
                        }
                        else
                        {
                           var _loc4_ = Math.sqrt(Math.pow(_loc3_.x - this._oMap.x,2) + Math.pow(_loc3_.y - this._oMap.y,2));
                           var _loc5_ = Math.sqrt(Math.pow(_loc2_[i].x - this._oMap.x,2) + Math.pow(_loc2_[i].y - this._oMap.y,2));
                           if(_loc5_ < _loc4_)
                           {
                              _loc3_ = _loc2_[i];
                           }
                        }
                        break;
                     case 2:
                        var _loc6_ = _global.API.ui.getUIComponent("Party").getMemberById(_loc2_[i].playerID).name;
                        if(_loc6_ == undefined)
                        {
                           delete register2.i;
                           continue;
                        }
                        this.addFlag(_loc2_[i].x,_loc2_[i].y,dofus.Constants.FLAG_MAP_GROUP,_loc6_);
                        break;
                     case 3:
                        this.addFlag(_loc2_[i].x,_loc2_[i].y,dofus.Constants.FLAG_MAP_SEEK,_loc2_[i].playerName);
                  }
               }
            }
         }
         if(_loc3_)
         {
            this.addFlag(_loc3_.x,_loc3_.y,dofus.Constants.FLAG_MAP_PHOENIX,this.api.lang.getText("BANNER_MAP_PHOENIX"));
         }
      }
   }
   function clearFlag()
   {
      for(var i in this._mcFlagsDirection)
      {
         this._mcFlagsDirection[i].removeMovieClip();
      }
      for(var i in this._mcFlagsContainer)
      {
         this._mcFlagsContainer[i].removeMovieClip();
      }
      this._aFlags = new Array();
   }
   function addFlag(nX, nY, nColor, sLabel)
   {
      if(_global.isNaN(nX) || _global.isNaN(nY))
      {
         return undefined;
      }
      var _loc6_ = this._mcFlagsDirection.getNextHighestDepth();
      var _loc7_ = this._mcFlagsDirection.attachMovie("FlagDirection","dir" + _loc6_,_loc6_);
      _loc7_.stop();
      var _loc8_ = (nColor & 16711680) >> 16;
      var _loc9_ = (nColor & 65280) >> 8;
      var _loc10_ = nColor & 255;
      var _loc11_ = new Color(_loc7_._mcCursor._mc._mcColor);
      var _loc12_ = new Object();
      _loc12_ = {ra:0,ga:0,ba:0,rb:_loc8_,gb:_loc9_,bb:_loc10_};
      _loc11_.setTransform(_loc12_);
      if(!this._mcFlagsContainer)
      {
         this._mcFlagsContainer = this._mcFlags.createEmptyMovieClip("_mcFlagsContainer",1);
      }
      var _loc13_ = this._nMapScale / 100 * this._nTileWidth;
      var _loc14_ = this._nMapScale / 100 * this._nTileHeight;
      _loc6_ = this._mcFlagsContainer.getNextHighestDepth();
      var _loc15_ = this._mcFlagsContainer.attachMovie("UI_MapExplorerFlag","flag" + _loc6_,_loc6_);
      _loc15_._x = _loc13_ * nX + _loc13_ / 2;
      _loc15_._y = _loc14_ * nY + _loc14_ / 2;
      _loc15_._xscale = this._nMapScale;
      _loc15_._yscale = this._nMapScale;
      _loc11_ = new Color(_loc15_._mcColor);
      _loc12_ = new Object();
      _loc12_ = {ra:0,ga:0,ba:0,rb:_loc8_,gb:_loc9_,bb:_loc10_};
      _loc11_.setTransform(_loc12_);
      this._aFlags.push({x:nX,y:nY,color:nColor,mcDirection:_loc7_});
      _loc7_.tooltipText = nX + "," + nY + (!sLabel.length?"":" (" + sLabel + ")");
      _loc15_.tooltipText = _loc7_.tooltipText;
      _loc15_.gapi = this.gapi;
      _loc7_.gapi = this.gapi;
      _loc7_.mcTarget = _loc7_._mcCursor;
      _loc15_.mcTarget = _loc15_;
      _loc7_.onRollOver = _loc15_.onRollOver = function()
      {
         this.gapi.showTooltip(this.tooltipText,this,-20,{bXLimit:false,bYLimit:false});
      };
      _loc7_.onRollOut = _loc15_.onRollOut = function()
      {
         this.gapi.hideTooltip();
      };
      this.updateMap();
   }
   function updateHints()
   {
      if(_global.isNaN(this.dungeonID))
      {
         var _loc2_ = this.api.lang.getHintsCategories();
         _loc2_[-1] = {n:this.api.lang.getText("OPTION_GRID"),c:"Yellow"};
         var _loc3_ = this.api.kernel.OptionsManager.getOption("MapFilters");
         this._mcHintsContainer = this._ldrHints.content;
         var _loc4_ = -1;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc4_ != -1)
            {
               this.showHintsCategory(_loc4_,_loc3_[_loc4_] == 1);
            }
            _loc4_ = _loc4_ + 1;
         }
      }
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
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.MiniMap.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.loadMap});
      this.addToQueue({object:this,method:this.updateFlags});
      this._nRandomTag = Math.random();
   }
   function addListeners()
   {
      this.api.gfx.addEventListener("mapLoaded",this);
      this._ldrBitmapMap.addEventListener("initialization",this);
   }
   function initMap()
   {
      this._mcBitmapContainer.removeMovieClip();
      this._mcBitmapContainer = this._ldrBitmapMap.content.createEmptyMovieClip("_mcBitmapContainer",1);
      this._mcBitmapContainer._visible = false;
      if(this.api.datacenter.Player.isAuthorized)
      {
         this._mcBitmapContainer.onMouseUp = this.onMouseUp;
         this._mcBitmapContainer.onRelease = function()
         {
         };
      }
      else
      {
         this._mcBitmapContainer.onRelease = this.click;
      }
      this._mcCursor._xscale = this._nMapScale;
      this._mcCursor._yscale = this._nMapScale;
      this._mcCursor.oMap = this._oMap;
      this._mcCursor.gapi = this.gapi;
      this._mcCursor.onRollOver = function()
      {
         this.gapi.showTooltip(this.oMap.x + "," + this.oMap.y,this,-20,{bXLimit:false,bYLimit:false});
      };
      this._mcCursor.onRollOut = function()
      {
         this.gapi.hideTooltip();
      };
      this.updateMap();
      this.updateHints();
   }
   function drawMap()
   {
      var _loc2_ = -10;
      while(_loc2_ < 10)
      {
         var _loc3_ = -10;
         while(_loc3_ < 10)
         {
            var _loc4_ = Math.floor(this._oMap.x / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_WIDTH);
            var _loc5_ = Math.floor(this._oMap.y / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_HEIGHT);
            if(_loc4_ < _loc2_ - 2 || (_loc4_ > _loc2_ + 2 || (_loc5_ < _loc3_ - 2 || _loc5_ > _loc3_ + 2)))
            {
               if(this._mcBitmapContainer[_loc2_ + "_" + _loc3_] != undefined)
               {
                  this._mcBitmapContainer[_loc2_ + "_" + _loc3_].removeMovieClip();
               }
            }
            else if(this._mcBitmapContainer[_loc2_ + "_" + _loc3_] == undefined)
            {
               var _loc6_ = this._mcBitmapContainer.attachMovie(_loc2_ + "_" + _loc3_,_loc2_ + "_" + _loc3_,this._mcBitmapContainer.getNextHighestDepth());
               _loc6_._xscale = this._nMapScale;
               _loc6_._yscale = this._nMapScale;
               _loc6_._x = _loc6_._width * _loc2_;
               _loc6_._y = _loc6_._height * _loc3_;
            }
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function initDungeon()
   {
      this._mcBitmapContainer.removeMovieClip();
      this._mcBitmapContainer = this._ldrBitmapMap.createEmptyMovieClip("_mcDongeonContainer",1);
      this._mcBg.onRelease = this.click;
      this._mcCursor._xscale = this._nMapScale;
      this._mcCursor._yscale = this._nMapScale;
      var _loc2_ = this.dungeon.m;
      var _loc3_ = this.dungeonCurrentMap;
      var _loc4_ = 0;
      for(var a in _loc2_)
      {
         var _loc5_ = _loc2_[a];
         if(_loc3_.z == _loc5_.z)
         {
            _loc4_;
            var _loc6_ = this._mcBitmapContainer.attachMovie("UI_MapExplorerRectangle","dungeonMap" + _loc4_,_loc4_++);
            _loc6_._xscale = this._nMapScale;
            _loc6_._yscale = this._nMapScale;
            _loc6_._x = _loc6_._width * _loc5_.x + _loc6_._width / 2 + 1;
            _loc6_._y = _loc6_._height * _loc5_.y + _loc6_._height / 2 + 1;
            if(_loc5_.n != undefined)
            {
               _loc6_.label = _loc5_.n + " (" + _loc5_.x + "," + _loc5_.y + ")";
               _loc6_.gapi = this.gapi;
               _loc6_.onRollOver = function()
               {
                  this.gapi.showTooltip(this.label,this,-20,{bXLimit:false,bYLimit:false});
               };
               _loc6_.onRollOut = function()
               {
                  this.gapi.hideTooltip();
               };
            }
         }
      }
   }
   function loadMap(bForceReload)
   {
      if(this._oMap.superarea == undefined)
      {
         this.addToQueue({object:this,method:this.loadMap,params:[bForceReload]});
         return false;
      }
      if(_global.isNaN(this.dungeonID))
      {
         if(this._oMap.superarea !== this._nCurrentArea || bForceReload)
         {
            this._nCurrentArea = this._oMap.superarea;
            this._ldrBitmapMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + this._nCurrentArea + ".swf";
            return true;
         }
         return false;
      }
      this.initDungeon();
      this._nCurrentArea = -1;
   }
   function showHintsCategory(categoryID, bShow)
   {
      var _loc4_ = this.api.kernel.OptionsManager.getOption("MapFilters");
      _loc4_[categoryID] = bShow;
      this.api.kernel.OptionsManager.setOption("MapFilters",_loc4_);
      var _loc5_ = "hints" + categoryID;
      if(!this._mcHintsContainer[_loc5_])
      {
         this._mcHintsContainer.createEmptyMovieClip(_loc5_,categoryID);
      }
      if(bShow)
      {
         var _loc6_ = this.api.lang.getHintsByCategory(categoryID);
         var _loc7_ = this._nMapScale / 100 * this._nTileWidth;
         var _loc8_ = this._nMapScale / 100 * this._nTileHeight;
         var _loc9_ = 0;
         for(; _loc9_ < _loc6_.length; _loc9_ = _loc9_ + 1)
         {
            var _loc10_ = new dofus.datacenter.Hint(_loc6_[_loc9_]);
            if(_loc10_.superAreaID === this._oMap.superarea)
            {
               var _loc11_ = Math.sqrt(Math.pow(_loc10_.x - this._oMap.x,2) + Math.pow(_loc10_.y - this._oMap.y,2));
               if(_loc11_ > 6)
               {
                  this._mcHintsContainer[_loc5_]["hint" + _loc9_].removeMovieClip();
                  continue;
               }
               if(this._mcHintsContainer[_loc5_]["hint" + _loc9_] != undefined)
               {
                  continue;
               }
               var _loc12_ = this._mcHintsContainer[_loc5_].attachMovie(_loc10_.gfx,"hint" + _loc9_,_loc9_,{_xscale:this._nMapScale,_yscale:this._nMapScale});
               _loc12_._x = _loc7_ * _loc10_.x + _loc7_ / 2;
               _loc12_._y = _loc8_ * _loc10_.y + _loc8_ / 2;
               _loc12_.oHint = _loc10_;
               _loc12_.gapi = this.gapi;
               _loc12_.onRollOver = function()
               {
                  this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")",this,-20,{bXLimit:false,bYLimit:false});
               };
               _loc12_.onRollOut = function()
               {
                  this.gapi.hideTooltip();
               };
            }
            else
            {
               this._mcHintsContainer[_loc5_]["hint" + _loc9_].removeMovieClip();
            }
         }
      }
      else
      {
         this._ldrHints.content[_loc5_].removeMovieClip();
      }
   }
   function getConquestAreaList()
   {
      var _loc2_ = this.api.datacenter.Conquest.worldDatas;
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
         else
         {
            _loc7_ = this.api.lang.getText("BRAKMARIAN_PRISM");
            _loc6_ = 421;
         }
         _loc3_.push({g:_loc6_,m:_loc2_.areas[_loc5_].prism,n:_loc7_,superAreaID:this.api.lang.getMapAreaText(_loc2_.areas[_loc5_].id).a});
         _loc5_ = _loc5_ + 1;
      }
      return _loc3_;
   }
   function updateDataMap()
   {
      if(_global.isNaN(this.dungeonID))
      {
         this._oMap = this.api.datacenter.Map;
         this._mcHintsContainer._visible = true;
         this._mcFlagsContainer._visible = true;
      }
      else
      {
         this._oMap = this.dungeonCurrentMap;
         this._mcHintsContainer._visible = false;
         this._mcFlagsContainer._visible = false;
      }
      this._mcCursor.oMap = this._oMap;
   }
   function updateMap()
   {
      this.updateDataMap();
      this.updateHints();
      var _loc2_ = this._nMapScale / 100 * this._nTileWidth;
      var _loc3_ = this._nMapScale / 100 * this._nTileHeight;
      this._mcBitmapContainer._x = (- _loc2_) * this._oMap.x - _loc2_ / 2;
      this._mcBitmapContainer._y = (- _loc3_) * this._oMap.y - _loc3_ / 2;
      this._mcHintsContainer._x = this._mcBitmapContainer._x;
      this._mcHintsContainer._y = this._mcBitmapContainer._y;
      this._mcFlagsContainer._x = this._mcBitmapContainer._x;
      this._mcFlagsContainer._y = this._mcBitmapContainer._y;
      this.drawMap();
      for(var i in this._aFlags)
      {
         var _loc4_ = this._aFlags[i].x - this._oMap.x;
         var _loc5_ = this._aFlags[i].y - this._oMap.y;
         if(!(_global.isNaN(_loc5_) || _global.isNaN(_loc4_)))
         {
            if(dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[_loc5_ + 6][_loc4_ + 3] == undefined || dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[_loc5_ + 6][_loc4_ + 3] == 1)
            {
               this._aFlags[i].mcDirection._visible = true;
               var _loc6_ = Math.floor(Math.atan2(_loc5_,_loc4_) / Math.PI * 180);
               if(_loc6_ < 0)
               {
                  _loc6_ = _loc6_ + 360;
               }
               if(_loc6_ > 360)
               {
                  _loc6_ = _loc6_ - 360;
               }
               this._aFlags[i].mcDirection.gotoAndStop(_loc6_ + 1);
               this._aFlags[i].mcDirection._mcCursor.gotoAndStop(_loc6_ + 1);
            }
            else
            {
               this._aFlags[i].mcDirection._visible = false;
            }
         }
      }
      this._mcBitmapContainer._visible = true;
   }
   function onClickTimer(bIsClick)
   {
      ank.utils.Timer.removeTimer(this,"minimap");
      this._bTimerEnable = false;
      if(bIsClick)
      {
         this.click();
      }
   }
   function getCoordinatesFromReal(nRealX, nRealY)
   {
      var _loc4_ = this._nMapScale / 100 * this._nTileWidth;
      var _loc5_ = this._nMapScale / 100 * this._nTileHeight;
      var _loc6_ = Math.floor(nRealX / _loc4_);
      var _loc7_ = Math.floor(nRealY / _loc5_);
      return {x:_loc6_,y:_loc7_};
   }
   function mapLoaded(oEvent)
   {
      this.updateDataMap();
      if(!this.loadMap())
      {
         this.updateMap();
      }
   }
   function initialization(oEvent)
   {
      this.initMap();
   }
   function click()
   {
      var _loc2_ = new Object();
      _loc2_.target = _global.API.ui.getUIComponent("Banner").illustration;
      _global.API.ui.getUIComponent("Banner").click(_loc2_);
   }
   function doubleClick(oEvent)
   {
      if(!this.api.datacenter.Game.isFight && _global.isNaN(this.dungeonID))
      {
         var _loc3_ = oEvent.coordinates.x;
         var _loc4_ = oEvent.coordinates.y;
         if(_loc3_ != undefined && _loc4_ != undefined)
         {
            this.api.network.Basics.autorisedMoveCommand(_loc3_,_loc4_);
         }
      }
   }
   function onMouseUp()
   {
      if(this._mcBg.hitTest(_root._xmouse,_root._ymouse,true))
      {
         if(this._bTimerEnable != true)
         {
            this._bTimerEnable = true;
            ank.utils.Timer.setTimer(this,"minimap",this,this.onClickTimer,ank.gapi.Gapi.DBLCLICK_DELAY,[true]);
         }
         else
         {
            this.onClickTimer(false);
            var _loc2_ = this._mcBitmapContainer._xmouse;
            var _loc3_ = this._mcBitmapContainer._ymouse;
            var _loc4_ = this.getCoordinatesFromReal(_loc2_,_loc3_);
            this.doubleClick({coordinates:_loc4_});
         }
      }
   }
}
