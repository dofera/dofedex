class dofus.graphics.gapi.ui.DocumentBook extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DocumentBook";
	function DocumentBook()
	{
		super();
	}
	function __set__document(loc2)
	{
		this._oDoc = loc2;
		return this.__get__document();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.DocumentBook.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.api.network.Documents.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.setLeftPageNumber,params:[0]});
		this._btnPrevious._visible = false;
		this._btnNext._visible = false;
		this._btnAskPageLeft.enabled = false;
		this._btnAskPageRight.enabled = false;
	}
	function addListeners()
	{
		this._btnPrevious.addEventListener("click",this);
		this._btnPrevious.addEventListener("over",this);
		this._btnPrevious.addEventListener("out",this);
		this._btnNext.addEventListener("click",this);
		this._btnNext.addEventListener("over",this);
		this._btnNext.addEventListener("out",this);
		this._btnClose.addEventListener("click",this);
		this._btnAskPageLeft.addEventListener("click",this);
		this._btnAskPageRight.addEventListener("click",this);
		this._btnAskPageLeft.addEventListener("over",this);
		this._btnAskPageRight.addEventListener("over",this);
		this._btnAskPageLeft.addEventListener("out",this);
		this._btnAskPageRight.addEventListener("out",this);
	}
	function setLeftPageNumber(loc2)
	{
		if(this._oDoc == undefined)
		{
			return undefined;
		}
		this._nCurrentLeftPageNum = loc2;
		var loc3 = this._oDoc.getPage(loc2);
		var loc4 = this._oDoc.getPage(loc2 + 1);
		this.layoutContent(loc3,true);
		this.layoutContent(loc4,false);
		this._btnPrevious._visible = loc2 > 0;
		this._btnNext._visible = loc2 + 2 < this._oDoc.pageCount;
	}
	function layoutContent(loc2, loc3)
	{
		var loc4 = !loc3?"_mcRightRenderer":"_mcLeftRenderer";
		var loc5 = !loc3?this._mcRightPlacer:this._mcLeftPlacer;
		this[loc4].removeMovieClip();
		switch(loc2.type)
		{
			case "title":
				this.attachMovie("BookPageTitle",loc4,this.getNextHighestDepth(),{_x:loc5._x,_y:loc5._y,page:loc2});
				break;
			case "index":
				this.attachMovie("BookPageIndex",loc4,this.getNextHighestDepth(),{_x:loc5._x,_y:loc5._y,page:loc2});
				this[loc4].addEventListener("chapterChange",this);
				break;
			case "text":
				this.attachMovie("BookPageText",loc4,this.getNextHighestDepth(),{_x:loc5._x,_y:loc5._y,page:loc2});
				break;
			case "blank":
		}
		if(loc3)
		{
			this._lblLeftPageNum.text = loc2.num != undefined?loc2.num:"";
			this._btnAskPageLeft.enabled = loc2.num != undefined;
		}
		else
		{
			this._lblRightPageNum.text = loc2.num != undefined?loc2.num:"";
			this._btnAskPageRight.enabled = loc2.num != undefined;
		}
	}
	function askPage(loc2)
	{
		var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:loc2,max:loc2});
		loc3.addEventListener("validate",this);
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnPrevious":
				this.setLeftPageNumber(this._nCurrentLeftPageNum - 2);
				break;
			case "_btnNext":
				this.setLeftPageNumber(this._nCurrentLeftPageNum + 2);
				break;
			case "_btnClose":
				this.callClose();
				break;
			default:
				switch(null)
				{
					case "_btnAskPageLeft":
						this.askPage(1);
						break;
					case "_btnAskPageRight":
						this.askPage(this._oDoc.pageCount - 1);
				}
		}
	}
	function chapterChange(loc2)
	{
		var loc3 = loc2.pageNum % 2 != 0?loc2.pageNum - 1:loc2.pageNum;
		this.setLeftPageNumber(loc3);
	}
	function validate(loc2)
	{
		var loc3 = Number(loc2.value);
		if(_global.isNaN(loc3))
		{
			loc3 = 1;
		}
		if(loc3 < 1)
		{
			loc3 = 1;
		}
		if(loc3 >= this._oDoc.pageCount)
		{
			loc3 = this._oDoc.pageCount - 1;
		}
		var loc4 = loc3 % 2 != 0?loc3 - 1:loc3;
		this.setLeftPageNumber(loc4);
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnPrevious":
				this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_PAGE"),loc2.target,-20);
				break;
			case "_btnNext":
				this.gapi.showTooltip(this.api.lang.getText("NEXT_PAGE"),loc2.target,-20);
				break;
			default:
				this.gapi.showTooltip(this.api.lang.getText("CHOOSE_PAGE_NUMBER"),loc2.target,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
