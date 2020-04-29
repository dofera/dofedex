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
	function Sprite(var3, var4, var5, var6, var7)
	{
		super();
		this.initialize(var3,var4,var5,var6,var7);
	}
	function initialize(sID, §\x0f\x12§, §\x1e\x13\x14§, §\b\x18§, §\x07\x10§)
	{
		this.id = sID;
		this.clipClass = var3;
		this._sGfxFile = var4;
		this._nCellNum = Number(var5);
		this._nDirection = var6 != undefined?Number(var6):1;
		this._oSequencer = new ank.utils.(1000);
		this._bInMove = false;
		this._bVisible = true;
		this._bClear = false;
		this._eoLinkedChilds = new ank.utils.();
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
	function __set__childIndex(var2)
	{
		this._nChildIndex = var2;
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
	function __set__linkedParent(var2)
	{
		this._oLinkedParent = var2;
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
	function __set__carriedChild(var2)
	{
		this._oCarriedChild = var2;
		return this.__get__carriedChild();
	}
	function __get__carriedParent()
	{
		return this._oCarriedParent;
	}
	function __set__carriedParent(var2)
	{
		this._oCarriedParent = var2;
		return this.__get__carriedParent();
	}
	function __get__gfxFile()
	{
		return this._sGfxFile;
	}
	function __set__gfxFile(var2)
	{
		this.dispatchEvent({type:"gfxFileChanged",value:var2});
		this._sGfxFile = var2;
		return this.__get__gfxFile();
	}
	function __get__defaultAnimation()
	{
		return this._sDefaultAnimation;
	}
	function __set__defaultAnimation(var2)
	{
		this._sDefaultAnimation = var2;
		return this.__get__defaultAnimation();
	}
	function __get__startAnimation()
	{
		return this._sStartAnimation;
	}
	function __set__startAnimation(var2)
	{
		this._sStartAnimation = var2;
		return this.__get__startAnimation();
	}
	function __get__startAnimationTimer()
	{
		return this._nStartAnimationTimer;
	}
	function __set__startAnimationTimer(var2)
	{
		this._nStartAnimationTimer = var2;
		return this.__get__startAnimationTimer();
	}
	function __get__speedModerator()
	{
		return this._nSpeedModerator;
	}
	function __set__speedModerator(var2)
	{
		this._nSpeedModerator = Number(var2);
		return this.__get__speedModerator();
	}
	function __get__isVisible()
	{
		return this._bVisible;
	}
	function __set__isVisible(var2)
	{
		this._bVisible = var2;
		return this.__get__isVisible();
	}
	function __get__isHidden(var2)
	{
		return this._bHidden;
	}
	function __set__isHidden(var2)
	{
		this.mc.isHidden = this._bHidden = var2;
		return this.__get__isHidden();
	}
	function __get__isInMove()
	{
		return this._bInMove;
	}
	function __set__isInMove(var2)
	{
		this._bInMove = var2;
		if(this.hasCarriedChild())
		{
			this.carriedChild.isInMove = var2;
		}
		return this.__get__isInMove();
	}
	function __get__isClear()
	{
		return this._bClear;
	}
	function __set__isClear(var2)
	{
		this._bClear = var2;
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
	function __set__cellNum(var2)
	{
		this._nLastCellNum = this._nCellNum != undefined?this._nCellNum:var2;
		this._nCellNum = Number(var2);
		return this.__get__cellNum();
	}
	function __get__direction()
	{
		return this._nDirection;
	}
	function __set__direction(var2)
	{
		this._nDirection = Number(var2);
		return this.__get__direction();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color1(var2)
	{
		this._nColor1 = Number(var2);
		return this.__get__color1();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color2(var2)
	{
		this._nColor2 = Number(var2);
		return this.__get__color2();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__color3(var2)
	{
		this._nColor3 = Number(var2);
		return this.__get__color3();
	}
	function __get__accessories()
	{
		return this._aAccessories;
	}
	function __set__accessories(var2)
	{
		this.dispatchEvent({type:"accessoriesChanged",value:var2});
		this._aAccessories = var2;
		return this.__get__accessories();
	}
	function __get__sequencer()
	{
		return this._oSequencer;
	}
	function __set__sequencer(var2)
	{
		this._oSequencer = var2;
		return this.__get__sequencer();
	}
	function __get__allDirections()
	{
		return this._bAllDirections;
	}
	function __set__allDirections(var2)
	{
		this._bAllDirections = var2;
		return this.__get__allDirections();
	}
	function __get__forceWalk()
	{
		return this._bForceWalk;
	}
	function __set__forceWalk(var2)
	{
		this._bForceWalk = var2;
		return this.__get__forceWalk();
	}
	function __get__forceRun()
	{
		return this._bForceRun;
	}
	function __set__forceRun(var2)
	{
		this._bForceRun = var2;
		return this.__get__forceRun();
	}
	function __get__noFlip()
	{
		return this._bNoFlip;
	}
	function __set__noFlip(var2)
	{
		this._bNoFlip = var2;
		return this.__get__noFlip();
	}
	function __get__mount()
	{
		return this._oMount;
	}
	function __set__mount(var2)
	{
		this._oMount = var2;
		return this.__get__mount();
	}
	function __get__isMounting()
	{
		return this._oMount != undefined;
	}
}
