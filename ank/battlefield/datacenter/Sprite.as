class ank.battlefield.datacenter.Sprite extends Object
{
   var allowGhostMode = true;
   var bAnimLoop = false;
   var _nChildIndex = -1;
   var _nLastCellNum = -1;
   var _sDefaultAnimation = "static";
   var _sStartAnimation = "static";
   var _nSpeedModerator = 1;
   var _bHidden = false;
   var _bAllDirections = true;
   var _bForceWalk = false;
   var _bForceRun = false;
   var _bNoFlip = false;
   function Sprite(nID, fClipClass, sGfxFile, nCellNum, nDir)
   {
      super();
      this.initialize(nID,fClipClass,sGfxFile,nCellNum,nDir);
   }
   function initialize(sID, fClipClass, sGfxFile, nCellNum, nDir)
   {
      this.id = sID;
      this.clipClass = fClipClass;
      this._sGfxFile = sGfxFile;
      this._nCellNum = Number(nCellNum);
      this._nDirection = nDir != undefined?Number(nDir):1;
      this._oSequencer = new ank.utils.Sequencer(1000);
      this._bInMove = false;
      this._bVisible = true;
      this._bClear = false;
      this._eoLinkedChilds = new ank.utils.ExtendedObject();
      mx.events.EventDispatcher.initialize(this);
   }
   function __get__hasChilds()
   {
      return this._eoLinkedChilds.getLength() != 0;
   }
   function __get__hasParent()
   {
      return this.linkedParent != undefined;
   }
   function __get__childIndex()
   {
      return this._nChildIndex;
   }
   function __set__childIndex(nChildIndex)
   {
      this._nChildIndex = nChildIndex;
      return this.__get__childIndex();
   }
   function __get__linkedChilds()
   {
      return this._eoLinkedChilds;
   }
   function __get__linkedParent()
   {
      return this._oLinkedParent;
   }
   function __set__linkedParent(oLinkedParent)
   {
      this._oLinkedParent = oLinkedParent;
      return this.__get__linkedParent();
   }
   function hasCarriedChild()
   {
      return this._oCarriedChild != undefined;
   }
   function hasCarriedParent()
   {
      return this._oCarriedParent != undefined;
   }
   function __get__carriedChild()
   {
      return this._oCarriedChild;
   }
   function __set__carriedChild(o)
   {
      this._oCarriedChild = o;
      return this.__get__carriedChild();
   }
   function __get__carriedParent()
   {
      return this._oCarriedParent;
   }
   function __set__carriedParent(o)
   {
      this._oCarriedParent = o;
      return this.__get__carriedParent();
   }
   function __get__gfxFile()
   {
      return this._sGfxFile;
   }
   function __set__gfxFile(sGfxFile)
   {
      this.dispatchEvent({type:"gfxFileChanged",value:sGfxFile});
      this._sGfxFile = sGfxFile;
      return this.__get__gfxFile();
   }
   function __get__defaultAnimation()
   {
      return this._sDefaultAnimation;
   }
   function __set__defaultAnimation(value)
   {
      this._sDefaultAnimation = value;
      return this.__get__defaultAnimation();
   }
   function __get__startAnimation()
   {
      return this._sStartAnimation;
   }
   function __set__startAnimation(value)
   {
      this._sStartAnimation = value;
      return this.__get__startAnimation();
   }
   function __get__startAnimationTimer()
   {
      return this._nStartAnimationTimer;
   }
   function __set__startAnimationTimer(value)
   {
      this._nStartAnimationTimer = value;
      return this.__get__startAnimationTimer();
   }
   function __get__speedModerator()
   {
      return this._nSpeedModerator;
   }
   function __set__speedModerator(value)
   {
      this._nSpeedModerator = Number(value);
      return this.__get__speedModerator();
   }
   function __get__isVisible()
   {
      return this._bVisible;
   }
   function __set__isVisible(value)
   {
      this._bVisible = value;
      return this.__get__isVisible();
   }
   function __get__isHidden(Void)
   {
      return this._bHidden;
   }
   function __set__isHidden(value)
   {
      this.mc.isHidden = this._bHidden = value;
      return this.__get__isHidden();
   }
   function __get__isInMove()
   {
      return this._bInMove;
   }
   function __set__isInMove(value)
   {
      this._bInMove = value;
      if(this.hasCarriedChild())
      {
         this.carriedChild.isInMove = value;
      }
      return this.__get__isInMove();
   }
   function __get__isClear()
   {
      return this._bClear;
   }
   function __set__isClear(value)
   {
      this._bClear = value;
      return this.__get__isClear();
   }
   function __get__lastCellNum()
   {
      return this._nLastCellNum;
   }
   function __get__cellNum()
   {
      return this._nCellNum;
   }
   function __set__cellNum(value)
   {
      this._nLastCellNum = this._nCellNum != undefined?this._nCellNum:value;
      this._nCellNum = Number(value);
      return this.__get__cellNum();
   }
   function __get__direction()
   {
      return this._nDirection;
   }
   function __set__direction(value)
   {
      this._nDirection = Number(value);
      return this.__get__direction();
   }
   function __get__color1()
   {
      return this._nColor1;
   }
   function __set__color1(value)
   {
      this._nColor1 = Number(value);
      return this.__get__color1();
   }
   function __get__color2()
   {
      return this._nColor2;
   }
   function __set__color2(value)
   {
      this._nColor2 = Number(value);
      return this.__get__color2();
   }
   function __get__color3()
   {
      return this._nColor3;
   }
   function __set__color3(value)
   {
      this._nColor3 = Number(value);
      return this.__get__color3();
   }
   function __get__accessories()
   {
      return this._aAccessories;
   }
   function __set__accessories(value)
   {
      this.dispatchEvent({type:"accessoriesChanged",value:value});
      this._aAccessories = value;
      return this.__get__accessories();
   }
   function __get__sequencer()
   {
      return this._oSequencer;
   }
   function __set__sequencer(value)
   {
      this._oSequencer = value;
      return this.__get__sequencer();
   }
   function __get__allDirections()
   {
      return this._bAllDirections;
   }
   function __set__allDirections(bAllDirections)
   {
      this._bAllDirections = bAllDirections;
      return this.__get__allDirections();
   }
   function __get__forceWalk()
   {
      return this._bForceWalk;
   }
   function __set__forceWalk(bForceWalk)
   {
      this._bForceWalk = bForceWalk;
      return this.__get__forceWalk();
   }
   function __get__forceRun()
   {
      return this._bForceRun;
   }
   function __set__forceRun(bForceRun)
   {
      this._bForceRun = bForceRun;
      return this.__get__forceRun();
   }
   function __get__noFlip()
   {
      return this._bNoFlip;
   }
   function __set__noFlip(bNoFlip)
   {
      this._bNoFlip = bNoFlip;
      return this.__get__noFlip();
   }
   function __get__mount()
   {
      return this._oMount;
   }
   function __set__mount(v)
   {
      this._oMount = v;
      return this.__get__mount();
   }
   function __get__isMounting()
   {
      return this._oMount != undefined;
   }
}
