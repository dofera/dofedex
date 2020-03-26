class ank.battlefield.mc.Sprite extends MovieClip
{
   var _nLastAlphaValue = 100;
   var _bGfxLoaded = false;
   var _bChevauchorGfxLoaded = false;
   static var WALK_SPEEDS = [0.07,0.06,0.06,0.06,0.07,0.06,0.06,0.06];
   static var MOUNT_SPEEDS = [0.23,0.2,0.2,0.2,0.23,0.2,0.2,0.2];
   static var RUN_SPEEDS = [0.17,0.15,0.15,0.15,0.17,0.15,0.15,0.15];
   function Sprite(b, sd, d)
   {
      super();
      this.initialize(b,sd,d);
   }
   function __get__data()
   {
      return this._oData;
   }
   function __set__mcCarried(mc)
   {
      this._mcCarried = mc;
      return this.__get__mcCarried();
   }
   function __set__mcChevauchorPos(mc)
   {
      this._mcChevauchorPos = mc;
      return this.__get__mcChevauchorPos();
   }
   function __set__isHidden(b)
   {
      this.setHidden(b);
      return this.__get__isHidden();
   }
   function __get__isHidden()
   {
      return this._bHidden;
   }
   function initialize(b, sd, d)
   {
      _global.GAC.addSprite(this,d);
      this._mcBattlefield = b;
      this._oSprites = sd;
      this._oData = d;
      this._mvlLoader = new MovieClipLoader();
      this._mvlLoader.addListener(this);
      this.setPosition(this._oData.cellNum);
      this.draw();
      this._ACTION = d;
      this.api = _global.API;
   }
   function draw()
   {
      this._mcGfx.removeMovieClip();
      this.createEmptyMovieClip("_mcGfx",20);
      this.setHidden(this._bHidden);
      this._bGfxLoaded = false;
      this._bChevauchorGfxLoaded = false;
      this._mvlLoader.loadClip(!!this._oData.isMounting?this._oData.mount.gfxFile:this._oData.gfxFile,this._mcGfx);
   }
   function clear(Void)
   {
      this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
      this._mcGfx.removeMovieClip();
      this._oData.direction = 1;
      this.removeExtraClip();
      this._oData.isClear = true;
   }
   function select(bool)
   {
      var _loc3_ = new Object();
      if(bool)
      {
         _loc3_ = {ra:60,rb:102,ga:60,gb:102,ba:60,bb:102};
      }
      else
      {
         _loc3_ = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
      }
      this.setColorTransform(_loc3_);
   }
   function addExtraClip(sFile, nColor, bTop)
   {
      if(sFile == undefined)
      {
         return undefined;
      }
      if(bTop == undefined)
      {
         bTop = false;
      }
      this.removeExtraClip(bTop);
      if(bTop)
      {
         var _loc4_ = new Object();
         _loc4_.file = sFile;
         _loc4_.color = nColor;
         this._oData.xtraClipTopParams = _loc4_;
         if(!this._bGfxLoaded)
         {
            return undefined;
         }
      }
      var _loc5_ = new MovieClipLoader();
      var _loc6_ = new Object();
      _loc6_.onLoadInit = function(mc)
      {
         if(nColor != undefined)
         {
            var _loc3_ = new Color(mc);
            _loc3_.setRGB(nColor);
         }
      };
      _loc5_.addListener(_loc6_);
      var mc = !bTop?this._mcXtraBack:this._mcXtraTop;
      _loc5_.unloadClip(mc);
      _loc5_.loadClip(sFile,mc);
   }
   function removeExtraClip(bTop)
   {
      switch(bTop)
      {
         case true:
            this._mcXtraTop.removeMovieClip();
            this.createEmptyMovieClip("_mcXtraTop",30);
            break;
         case false:
            this._mcXtraBack.removeMovieClip();
            this.createEmptyMovieClip("_mcXtraBack",10);
            break;
         default:
            this._mcXtraTop.removeMovieClip();
            this._mcXtraBack.removeMovieClip();
            this.createEmptyMovieClip("_mcXtraTop",30);
            this.createEmptyMovieClip("_mcXtraBack",10);
      }
   }
   function setColorTransform(t)
   {
      var _loc3_ = new Color(this);
      _loc3_.setTransform(t);
   }
   function setNewCellNum(nCellNum)
   {
      this._oData.cellNum = Number(nCellNum);
   }
   function setDirection(nDir)
   {
      if(nDir == undefined)
      {
         nDir = this._oData.direction;
      }
      this._oData.direction = nDir;
      this.setAnim(this._oData.animation);
   }
   function setPosition(nCellNum)
   {
      this.updateMap(nCellNum,this._oData.isVisible);
      this.setDepth(nCellNum);
      if(nCellNum == undefined)
      {
         nCellNum = this._oData.cellNum;
      }
      else
      {
         this.setNewCellNum(nCellNum);
      }
      var _loc3_ = this._mcBattlefield.mapHandler.getCellData(nCellNum);
      var _loc4_ = this._mcBattlefield.mapHandler.getCellHeight(nCellNum);
      var _loc5_ = _loc4_ - Math.floor(_loc4_);
      this._x = _loc3_.x;
      this._y = _loc3_.y - _loc5_ * ank.battlefield.Constants.LEVEL_HEIGHT;
   }
   function setDepth(nCellNum)
   {
      if(nCellNum == undefined)
      {
         nCellNum = this._oData.cellNum;
      }
      var _loc3_ = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler,this._oSprites,nCellNum,this._mcBattlefield.bGhostView);
      this.swapDepths(_loc3_);
      if(this._oData.hasCarriedChild())
      {
         this._oData.carriedChild.mc.setDepth(nCellNum);
      }
   }
   function setVisible(bool)
   {
      this._oData.isVisible = bool;
      this._visible = bool;
      this.updateMap(this._oData.cellNum,bool);
   }
   function setAlpha(value)
   {
      this._mcGfx._alpha = value;
   }
   function setHidden(b)
   {
      this._bHidden = b;
      if(this._bHidden)
      {
         this._mcGfx._x = this._mcGfx._y = -5000;
         this._mcGfx._visible = false;
      }
      else
      {
         this._mcGfx._x = this._mcGfx._y = 0;
         this._mcGfx._visible = true;
      }
   }
   function setGhostView(bool)
   {
      this.setDepth();
      if(bool)
      {
         this._nLastAlphaValue = this._mcGfx._alpha;
         this.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
      }
      else
      {
         this.setAlpha(this._nLastAlphaValue);
      }
   }
   function moveToCell(seq, cellNum, bStop, sSpeedType, sAnimation, bForceAnimation)
   {
      if(cellNum != this._oData.cellNum)
      {
         var _loc8_ = this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum);
         var _loc9_ = this._mcBattlefield.mapHandler.getCellData(cellNum);
         var _loc10_ = _loc9_.x;
         var _loc11_ = _loc9_.y;
         var _loc12_ = 0.01;
         if(_loc9_.groundSlope != 1)
         {
            _loc11_ = _loc11_ - ank.battlefield.Constants.HALF_LEVEL_HEIGHT;
         }
         if(sAnimation.toLowerCase() != "static")
         {
            this._oData.direction = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc8_.x,_loc8_.rootY,_loc10_,_loc9_.rootY,true);
         }
         switch(sSpeedType)
         {
            case "slide":
               var _loc13_ = 0.25;
               this.setAnim(sAnimation);
               break;
            case "walk":
            default:
               _loc13_ = ank.battlefield.mc.Sprite.WALK_SPEEDS[this._oData.direction];
               this.setAnim(sAnimation != undefined?sAnimation:"walk",undefined,bForceAnimation);
               break;
            case "run":
               _loc13_ = !!this._oData.isMounting?ank.battlefield.mc.Sprite.MOUNT_SPEEDS[this._oData.direction]:ank.battlefield.mc.Sprite.RUN_SPEEDS[this._oData.direction];
               this.setAnim(sAnimation != undefined?sAnimation:"run",undefined,bForceAnimation);
         }
         _loc13_ = _loc13_ * this._oData.speedModerator;
         if(_loc9_.groundLevel < _loc8_.groundLevel)
         {
            _loc13_ = _loc13_ + _loc12_;
         }
         else if(_loc9_.groundLevel > _loc8_.groundLevel)
         {
            _loc13_ = _loc13_ - _loc12_;
         }
         else if(_loc8_.groundSlope != _loc9_.groundSlope)
         {
            if(_loc9_.groundSlope == 1)
            {
               _loc13_ = _loc13_ + _loc12_;
            }
            else if(_loc8_.groundSlope == 1)
            {
               _loc13_ = _loc13_ - _loc12_;
            }
         }
         this._nDistance = Math.sqrt(Math.pow(this._x - _loc10_,2) + Math.pow(this._y - _loc11_,2));
         var _loc14_ = Math.atan2(_loc11_ - this._y,_loc10_ - this._x);
         var _loc15_ = Math.cos(_loc14_);
         var _loc16_ = Math.sin(_loc14_);
         this._nLastTimer = getTimer();
         var _loc17_ = Number(cellNum) > this._oData.cellNum;
         this.updateMap(cellNum,this._oData.isVisible,true);
         this.setNewCellNum(cellNum);
         this._oData.isInMove = true;
         if(this._oData.hasCarriedChild())
         {
            var _loc18_ = this._oData.carriedChild;
            var _loc19_ = _loc18_.mc;
            _loc19_.setDirection(this._oData.direction);
            _loc19_.updateMap(cellNum,_loc18_.isVisible);
            _loc19_.setNewCellNum(cellNum);
         }
         if(_loc17_)
         {
            this.setDepth(cellNum);
         }
         ank.utils.CyclicTimer.addFunction(this,this,this.basicMove,[_loc13_,_loc15_,_loc16_],this,this.basicMoveEnd,[seq,_loc10_,_loc11_,cellNum,bStop,sSpeedType == "slide",!_loc17_]);
      }
      else
      {
         seq.onActionEnd();
      }
   }
   function basicMove(speed, cosRot, sinRot)
   {
      var _loc5_ = getTimer() - this._nLastTimer;
      var _loc6_ = speed * (_loc5_ <= 50?_loc5_:50);
      this._x = this._x + _loc6_ * cosRot;
      this._y = this._y + _loc6_ * sinRot;
      this._nDistance = this._nDistance - _loc6_;
      this._nLastTimer = getTimer();
      if(this._nDistance <= _loc6_)
      {
         return false;
      }
      return true;
   }
   function basicMoveEnd(seq, xDest, yDest, cellNum, bStop, bSlide, bSetDepth)
   {
      if(this._nOldCellNum != undefined)
      {
         this._mcBattlefield.mapHandler.getCellData(this._nOldCellNum).removeSpriteOnID(this._oData.id);
         this._nOldCellNum = undefined;
      }
      if(bStop)
      {
         this._x = xDest;
         this._y = yDest;
         this.setAnim(this._oData.defaultAnimation);
         this._oData.isInMove = false;
         if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && this.data instanceof dofus.datacenter.MonsterGroup)
         {
            this._rollOver();
         }
      }
      if(bSetDepth)
      {
         this.setDepth(cellNum);
      }
      seq.onActionEnd();
   }
   function saveLastAnimation(sAnim)
   {
      if(!this._oData.isMounting)
      {
         this._mcGfx.mcAnim.lastAnimation = sAnim;
      }
      else
      {
         this._mcChevauchor.mcAnim.lastAnimation = sAnim;
         this._mcGfx.mcAnimFront.lastAnimation = sAnim;
         this._mcGfx.mcAnimBack.lastAnimation = sAnim;
      }
   }
   function setAnimTimer(anim, bLoop, bForced, nTimer)
   {
      this.setAnim(anim,bLoop,bForced);
      if(_global.isNaN(Number(nTimer)))
      {
         return undefined;
      }
      if(nTimer < 1)
      {
         return undefined;
      }
      ank.utils.Timer.setTimer(this,"battlefield",this,this.setAnim,nTimer,[this._oData.defaultAnimation]);
   }
   function setAnim(anim, bLoop, bForced)
   {
      if(anim == undefined)
      {
         anim = this._oData.defaultAnimation;
      }
      anim = String(anim).toLowerCase();
      if(bLoop == undefined)
      {
         bLoop = false;
      }
      if(bForced == undefined)
      {
         bForced = false;
      }
      var _loc5_ = this._oData.noFlip;
      this._oData.bAnimLoop = bLoop;
      var _loc6_ = this._mcGfx;
      var _loc7_ = "";
      if(this._oData.hasCarriedChild())
      {
         _loc7_ = _loc7_ + "_C";
      }
      switch(this._oData.direction)
      {
         case 0:
            var _loc10_ = "S";
            var _loc8_ = anim + _loc7_ + _loc10_;
            var _loc9_ = "staticR";
            this._xscale = 100;
            break;
         case 1:
            _loc10_ = "R";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticR";
            this._xscale = 100;
            break;
         case 2:
            _loc10_ = "F";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticR";
            this._xscale = 100;
            break;
         case 3:
            _loc10_ = "R";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticR";
            if(!_loc5_)
            {
               this._xscale = -100;
            }
            break;
         case 4:
            _loc10_ = "S";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticL";
            if(!_loc5_)
            {
               this._xscale = -100;
            }
            break;
         case 5:
            _loc10_ = "L";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticL";
            this._xscale = 100;
            break;
         case 6:
            _loc10_ = "B";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticL";
            this._xscale = 100;
            break;
         case 7:
            _loc10_ = "L";
            _loc8_ = anim + _loc7_ + _loc10_;
            _loc9_ = "staticL";
            if(!_loc5_)
            {
               this._xscale = -100;
            }
      }
      var _loc11_ = this._oData.fullAnimation;
      var _loc12_ = this._oData.animation;
      this._oData.animation = anim;
      this._oData.fullAnimation = _loc8_;
      if(this._oData.xtraClipTopAnimations != undefined)
      {
         if(this._oData.xtraClipTopAnimations[_loc8_])
         {
            this.addExtraClip(this._oData.xtraClipTopParams.file,this._oData.xtraClipTopParams.color,true);
         }
         else if(this._mcXtraTop != undefined)
         {
            this.removeExtraClip(true);
         }
      }
      if(bForced || _loc8_ != _loc11_)
      {
         if(!this._oData.isMounting)
         {
            _loc6_.mcAnim.removeMovieClip();
            if(_loc6_.attachMovie(_loc8_,"mcAnim",10,{lastAnimation:_loc12_}) == undefined)
            {
               _loc6_.attachMovie("static" + _loc10_,"mcAnim",10,{lastAnimation:_loc12_});
               ank.utils.Logger.err("L\'anim (" + _loc8_ + ") n\'existe pas !");
            }
            if(ank.battlefield.Battlefield.useCacheAsBitmapOnStaticAnim)
            {
               (MovieClip)_loc6_.mcAnim.cacheAsBitmap = (MovieClip)_loc6_.mcAnim._totalframes == 1;
            }
         }
         else
         {
            this._mcChevauchor.mcAnim.removeMovieClip();
            _loc6_.mcAnimFront.removeMovieClip();
            _loc6_.mcAnimBack.removeMovieClip();
            if(this._mcChevauchor.attachMovie(_loc8_,"mcAnim",1,{lastAnimation:_loc12_}) == undefined)
            {
               this._mcChevauchor.attachMovie("static" + _loc10_,"mcAnim",1,{lastAnimation:_loc12_});
            }
            if(_loc6_.attachMovie(_loc8_ + "_Front","mcAnimFront",30,{lastAnimation:_loc12_}) == undefined)
            {
               _loc6_.attachMovie("static" + _loc10_ + "_Front","mcAnimFront",30,{lastAnimation:_loc12_});
            }
            if(_loc6_.attachMovie(_loc8_ + "_Back","mcAnimBack",10,{lastAnimation:_loc12_}) == undefined)
            {
               _loc6_.attachMovie("static" + _loc10_ + "_Back","mcAnimBack",10,{lastAnimation:_loc12_});
            }
         }
      }
      if(this._oData.hasCarriedChild())
      {
         ank.utils.CyclicTimer.addFunction(this,this,this.updateCarriedPosition);
      }
      if(this._oData.isMounting)
      {
         this.chevauchorUpdater = this.createEmptyMovieClip("chevauchorUpdater",1000);
         this.chevauchorUpdater.sprite = this;
         this.chevauchorUpdater.onEnterFrame = function()
         {
            this.sprite.updateChevauchorPosition();
         };
      }
   }
   function updateCarriedPosition()
   {
      if(this._oData.hasCarriedChild())
      {
         if(this._mcCarried != undefined)
         {
            var _loc2_ = {x:this._mcCarried._x,y:this._mcCarried._y};
            this._mcCarried._parent.localToGlobal(_loc2_);
            this._mcBattlefield.container.globalToLocal(_loc2_);
            this._oData.carriedChild.mc._x = _loc2_.x;
            this._oData.carriedChild.mc._y = _loc2_.y;
         }
      }
      return this._oData.animation == "static"?false:true;
   }
   function updateChevauchorPosition()
   {
      if(this._oData.isMounting)
      {
         if(this._mcChevauchorPos != undefined)
         {
            var _loc2_ = {x:this._mcChevauchorPos._x,y:this._mcChevauchorPos._y};
            this._mcChevauchorPos._parent.localToGlobal(_loc2_);
            this._mcGfx.globalToLocal(_loc2_);
            this._mcChevauchor._x = _loc2_.x;
            this._mcChevauchor._y = _loc2_.y;
            this._mcChevauchor._rotation = this._mcChevauchorPos._rotation;
            this._mcChevauchor._xscale = this._mcChevauchorPos._xscale;
            this._mcChevauchor._yscale = this._mcChevauchorPos._yscale;
         }
      }
      if(this._oData.animation == "static")
      {
         this.chevauchorUpdater.removeMovieClip();
      }
      return true;
   }
   function updateMap(nCellNum, bVisible, bDontRemoveAllSpriteOn)
   {
      var _loc5_ = this._mcBattlefield.mapHandler.getCellData(nCellNum);
      if(_loc5_ == undefined)
      {
         if(bVisible)
         {
            this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).addSpriteOnID(this._oData.id);
         }
         else
         {
            this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
         }
         return undefined;
      }
      if(bDontRemoveAllSpriteOn != true)
      {
         this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
      }
      else
      {
         this._nOldCellNum = this._oData.cellNum;
      }
      if(bVisible)
      {
         _loc5_.addSpriteOnID(this._oData.id);
      }
   }
   function setScale(nScaleX, nScaleY)
   {
      this._mcGfx._xscale = nScaleX;
      this._mcGfx._yscale = nScaleY == undefined?nScaleX:nScaleY;
   }
   function onLoadInit(mc)
   {
      this.onEnterFrame = function()
      {
         if(!this._bGfxLoaded)
         {
            this._bGfxLoaded = true;
            if(this._oData.isMounting)
            {
               this._mcChevauchor = this._mcGfx.createEmptyMovieClip("chevauchor",20);
               this._mvlLoader.loadClip(this._oData.mount.chevauchorGfxFile,this._mcChevauchor);
            }
         }
         else
         {
            this._bChevauchorGfxLoaded = true;
         }
         if(this._bGfxLoaded && (!this._oData.isMounting || this._bChevauchorGfxLoaded))
         {
            if(_global.isNaN(Number(this._oData.startAnimationTimer)))
            {
               this.setAnim(this._oData.startAnimation,undefined,true);
            }
            else
            {
               this.setAnimTimer(this._oData.startAnimation,false,false,this._oData.startAnimationTimer);
            }
            delete this.onEnterFrame;
         }
      };
   }
   function _release(Void)
   {
      this._mcBattlefield.onSpriteRelease(this);
   }
   function _rollOver(Void)
   {
      this._mcBattlefield.onSpriteRollOver(this);
   }
   function _rollOut(Void)
   {
      this._mcBattlefield.onSpriteRollOut(this);
   }
}
