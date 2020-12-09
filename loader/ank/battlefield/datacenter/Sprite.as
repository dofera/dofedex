class ank.battlefield.datacenter.Sprite extends Object
{
	var allowGhostMode = true;
	var bAnimLoop = false;
	var _nChildIndex = -1;
	var _nFutureCellNum = -1;
	var _sDefaultAnimation = "static";
	var _sStartAnimation = "static";
	var _nSpeedModerator = 1;
	var _bHidden = false;
	var _bAllDirections = true;
	var _bForceWalk = false;
	var _bForceRun = false;
	var _bNoFlip = false;
	var _bIsPendingClearing = false;
	var _bUncarryingSprite = false;
	var bInCreaturesMode = false;
	function Sprite(§\x05\x02§, §\x0e\x1d§, §\x1e\x12\f§, §\b\x02§, §\x06\x14§)
	{
		super();
		this.initialize(var3,var4,var5,var6,var7);
	}
	function initialize(sID, §\x0e\x1d§, §\x1e\x12\f§, §\b\x02§, §\x06\x14§)
	{
		this.id = sID;
		this.clipClass = var3;
		this._sGfxFile = var4;
		this.refreshGfxFileName();
		this._nCellNum = Number(var5);
		this._nDirection = var6 != undefined?Number(var6):1;
		this._oSequencer = new ank.utils.(1000);
		this._bInMove = false;
		this._bVisible = true;
		this._bClear = false;
		this._eoLinkedChilds = new ank.utils.	();
		mx.events.EventDispatcher.initialize(this);
	}
	function refreshGfxFileName()
	{
		var var2 = this._sGfxFile.split(".")[0].split("/");
		this._sGfxFileName = var2[var2.length - 1];
	}
	function __set__uncarryingSprite(§\x14\x0f§)
	{
		this._bUncarryingSprite = var2;
		return this.__get__uncarryingSprite();
	}
	function __get__uncarryingSprite()
	{
		return this._bUncarryingSprite;
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
	function __set__childIndex(§\x07\x11§)
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
	function __set__linkedParent(§\x1e\x19\x07§)
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
	function __set__carriedChild(§\x1e\x1a\x1b§)
	{
		this._oCarriedChild = var2;
		return this.__get__carriedChild();
	}
	function __get__carriedParent()
	{
		return this._oCarriedParent;
	}
	function __set__carriedParent(§\x1e\x1a\x1b§)
	{
		this._oCarriedParent = var2;
		return this.__get__carriedParent();
	}
	function __get__gfxFile()
	{
		return this._sGfxFile;
	}
	function __set__gfxFile(§\x1e\x12\f§)
	{
		this.dispatchEvent({type:"gfxFileChanged",value:var2});
		this._sGfxFile = var2;
		this.refreshGfxFileName();
		return this.__get__gfxFile();
	}
	function __get__gfxFileName()
	{
		return this._sGfxFileName;
	}
	function __get__defaultAnimation()
	{
		return this._sDefaultAnimation;
	}
	function __set__defaultAnimation(§\x1e\n\x0f§)
	{
		this._sDefaultAnimation = var2;
		return this.__get__defaultAnimation();
	}
	function __get__startAnimation()
	{
		return this._sStartAnimation;
	}
	function __set__startAnimation(§\x1e\n\x0f§)
	{
		this._sStartAnimation = var2;
		return this.__get__startAnimation();
	}
	function __get__startAnimationTimer()
	{
		return this._nStartAnimationTimer;
	}
	function __set__startAnimationTimer(§\x1e\n\x0f§)
	{
		this._nStartAnimationTimer = var2;
		return this.__get__startAnimationTimer();
	}
	function __get__speedModerator()
	{
		return this._nSpeedModerator;
	}
	function __set__speedModerator(§\x1e\n\x0f§)
	{
		this._nSpeedModerator = Number(var2);
		return this.__get__speedModerator();
	}
	function __get__isVisible()
	{
		return this._bVisible;
	}
	function __set__isVisible(§\x1e\n\x0f§)
	{
		this._bVisible = var2;
		return this.__get__isVisible();
	}
	function __get__isHidden(§\x1e\n\f§)
	{
		return this._bHidden;
	}
	function __set__isHidden(§\x1e\n\x0f§)
	{
		this.mc.isHidden = this._bHidden = var2;
		return this.__get__isHidden();
	}
	function __get__isInMove()
	{
		return this._bInMove;
	}
	function __set__isInMove(§\x1e\n\x0f§)
	{
		if(!var2)
		{
			this._nFutureCellNum = -1;
			this._sMoveSpeedType = undefined;
			this._sMoveAnimation = undefined;
		}
		this._bInMove = var2;
		if(this.hasCarriedChild())
		{
			this.carriedChild.isInMove = var2;
		}
		return this.__get__isInMove();
	}
	function __get__moveSpeedType()
	{
		return this._sMoveSpeedType;
	}
	function __set__moveSpeedType(§\x1e\x10\b§)
	{
		this._sMoveSpeedType = var2;
		return this.__get__moveSpeedType();
	}
	function __get__moveAnimation()
	{
		return this._sMoveAnimation;
	}
	function __set__moveAnimation(§\x1e\x10\t§)
	{
		this._sMoveAnimation = var2;
		return this.__get__moveAnimation();
	}
	function __get__isClear()
	{
		return this._bClear;
	}
	function __set__isClear(§\x1e\n\x0f§)
	{
		this._bClear = var2;
		return this.__get__isClear();
	}
	function __get__cellNum()
	{
		return this._nCellNum;
	}
	function __set__cellNum(§\x1e\n\x0f§)
	{
		this._nCellNum = Number(var2);
		return this.__get__cellNum();
	}
	function __get__futureCellNum()
	{
		return this._nFutureCellNum;
	}
	function __set__futureCellNum(§\x05\f§)
	{
		this._nFutureCellNum = var2;
		return this.__get__futureCellNum();
	}
	function __get__direction()
	{
		return this._nDirection;
	}
	function __set__direction(§\x1e\n\x0f§)
	{
		this._nDirection = Number(var2);
		return this.__get__direction();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color1(§\x1e\n\x0f§)
	{
		this._nColor1 = Number(var2);
		return this.__get__color1();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color2(§\x1e\n\x0f§)
	{
		this._nColor2 = Number(var2);
		return this.__get__color2();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__color3(§\x1e\n\x0f§)
	{
		this._nColor3 = Number(var2);
		return this.__get__color3();
	}
	function __get__accessories()
	{
		return this._aAccessories;
	}
	function __set__accessories(§\x1e\n\x0f§)
	{
		this.dispatchEvent({type:"accessoriesChanged",value:var2});
		this._aAccessories = var2;
		return this.__get__accessories();
	}
	function __get__sequencer()
	{
		return this._oSequencer;
	}
	function __set__sequencer(§\x1e\n\x0f§)
	{
		this._oSequencer = var2;
		return this.__get__sequencer();
	}
	function __get__allDirections()
	{
		return this._bAllDirections;
	}
	function __set__allDirections(§\x1c\x15§)
	{
		this._bAllDirections = var2;
		return this.__get__allDirections();
	}
	function __get__forceWalk()
	{
		return this._bForceWalk;
	}
	function __set__forceWalk(§\x19\x11§)
	{
		this._bForceWalk = var2;
		return this.__get__forceWalk();
	}
	function __get__forceRun()
	{
		return this._bForceRun;
	}
	function __set__forceRun(§\x19\x15§)
	{
		this._bForceRun = var2;
		return this.__get__forceRun();
	}
	function __get__noFlip()
	{
		return this._bNoFlip;
	}
	function __set__noFlip(§\x17\x0e§)
	{
		this._bNoFlip = var2;
		return this.__get__noFlip();
	}
	function __get__mount()
	{
		return this._oMount;
	}
	function __set__mount(§\x1e\n\x13§)
	{
		this._oMount = var2;
		return this.__get__mount();
	}
	function __get__isMounting()
	{
		return this._oMount != undefined;
	}
	function __get__isPendingClearing()
	{
		return this._bIsPendingClearing;
	}
	function __set__isPendingClearing(§\x18\x10§)
	{
		this._bIsPendingClearing = var2;
		return this.__get__isPendingClearing();
	}
}
