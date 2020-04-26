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
	var bInCreaturesMode = false;
	function Sprite(loc3, loc4, loc5, loc6, loc7)
	{
		super();
		this.initialize(loc3,loc4,loc5,loc6,loc7);
	}
	function initialize(sID, §\x0f\x14§, §\x1e\x13\x16§, §\b\x1a§, §\x07\x12§)
	{
		this.id = sID;
		this.clipClass = loc3;
		this._sGfxFile = loc4;
		this._nCellNum = Number(loc5);
		this._nDirection = loc6 != undefined?Number(loc6):1;
		this._oSequencer = new ank.utils.(1000);
		this._bInMove = false;
		this._bVisible = true;
		this._bClear = false;
		this._eoLinkedChilds = new ank.utils.();
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
	function __set__childIndex(loc2)
	{
		this._nChildIndex = loc2;
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
	function __set__linkedParent(loc2)
	{
		this._oLinkedParent = loc2;
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
	function __set__carriedChild(loc2)
	{
		this._oCarriedChild = loc2;
		return this.__get__carriedChild();
	}
	function __get__carriedParent()
	{
		return this._oCarriedParent;
	}
	function __set__carriedParent(loc2)
	{
		this._oCarriedParent = loc2;
		return this.__get__carriedParent();
	}
	function __get__gfxFile()
	{
		return this._sGfxFile;
	}
	function __set__gfxFile(loc2)
	{
		this.dispatchEvent({type:"gfxFileChanged",value:loc2});
		this._sGfxFile = loc2;
		return this.__get__gfxFile();
	}
	function __get__defaultAnimation()
	{
		return this._sDefaultAnimation;
	}
	function __set__defaultAnimation(loc2)
	{
		this._sDefaultAnimation = loc2;
		return this.__get__defaultAnimation();
	}
	function __get__startAnimation()
	{
		return this._sStartAnimation;
	}
	function __set__startAnimation(loc2)
	{
		this._sStartAnimation = loc2;
		return this.__get__startAnimation();
	}
	function __get__startAnimationTimer()
	{
		return this._nStartAnimationTimer;
	}
	function __set__startAnimationTimer(loc2)
	{
		this._nStartAnimationTimer = loc2;
		return this.__get__startAnimationTimer();
	}
	function __get__speedModerator()
	{
		return this._nSpeedModerator;
	}
	function __set__speedModerator(loc2)
	{
		this._nSpeedModerator = Number(loc2);
		return this.__get__speedModerator();
	}
	function __get__isVisible()
	{
		return this._bVisible;
	}
	function __set__isVisible(loc2)
	{
		this._bVisible = loc2;
		return this.__get__isVisible();
	}
	function __get__isHidden(loc2)
	{
		return this._bHidden;
	}
	function __set__isHidden(loc2)
	{
		this.mc.isHidden = this._bHidden = loc2;
		return this.__get__isHidden();
	}
	function __get__isInMove()
	{
		return this._bInMove;
	}
	function __set__isInMove(loc2)
	{
		this._bInMove = loc2;
		if(this.hasCarriedChild())
		{
			this.carriedChild.isInMove = loc2;
		}
		return this.__get__isInMove();
	}
	function __get__isClear()
	{
		return this._bClear;
	}
	function __set__isClear(loc2)
	{
		this._bClear = loc2;
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
	function __set__cellNum(loc2)
	{
		this._nLastCellNum = this._nCellNum != undefined?this._nCellNum:loc2;
		this._nCellNum = Number(loc2);
		return this.__get__cellNum();
	}
	function __get__direction()
	{
		return this._nDirection;
	}
	function __set__direction(loc2)
	{
		this._nDirection = Number(loc2);
		return this.__get__direction();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color1(loc2)
	{
		this._nColor1 = Number(loc2);
		return this.__get__color1();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color2(loc2)
	{
		this._nColor2 = Number(loc2);
		return this.__get__color2();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__color3(loc2)
	{
		this._nColor3 = Number(loc2);
		return this.__get__color3();
	}
	function __get__accessories()
	{
		return this._aAccessories;
	}
	function __set__accessories(loc2)
	{
		this.dispatchEvent({type:"accessoriesChanged",value:loc2});
		this._aAccessories = loc2;
		return this.__get__accessories();
	}
	function __get__sequencer()
	{
		return this._oSequencer;
	}
	function __set__sequencer(loc2)
	{
		this._oSequencer = loc2;
		return this.__get__sequencer();
	}
	function __get__allDirections()
	{
		return this._bAllDirections;
	}
	function __set__allDirections(loc2)
	{
		this._bAllDirections = loc2;
		return this.__get__allDirections();
	}
	function __get__forceWalk()
	{
		return this._bForceWalk;
	}
	function __set__forceWalk(loc2)
	{
		this._bForceWalk = loc2;
		return this.__get__forceWalk();
	}
	function __get__forceRun()
	{
		return this._bForceRun;
	}
	function __set__forceRun(loc2)
	{
		this._bForceRun = loc2;
		return this.__get__forceRun();
	}
	function __get__noFlip()
	{
		return this._bNoFlip;
	}
	function __set__noFlip(loc2)
	{
		this._bNoFlip = loc2;
		return this.__get__noFlip();
	}
	function __get__mount()
	{
		return this._oMount;
	}
	function __set__mount(loc2)
	{
		this._oMount = loc2;
		return this.__get__mount();
	}
	function __get__isMounting()
	{
		return this._oMount != undefined;
	}
}
