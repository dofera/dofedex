class dofus.graphics.gapi.ui.DocumentBook extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DocumentBook";
	function DocumentBook()
	{
		super();
	}
	function __set__document(§\x1e\x19\x1d§)
	{
		this._oDoc = var2;
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
	function setLeftPageNumber(§\x02\n§)
	{
		if(this._oDoc == undefined)
		{
			return undefined;
		}
		this._nCurrentLeftPageNum = var2;
		var var3 = this._oDoc.getPage(var2);
		var var4 = this._oDoc.getPage(var2 + 1);
		this.layoutContent(var3,true);
		this.layoutContent(var4,false);
		this._btnPrevious._visible = var2 > 0;
		this._btnNext._visible = var2 + 2 < this._oDoc.pageCount;
	}
	function layoutContent(§\x1e\x18\x16§, §\x18\x07§)
	{
		var var4 = !var3?"_mcRightRenderer":"_mcLeftRenderer";
		var var5 = !var3?this._mcRightPlacer:this._mcLeftPlacer;
		this[var4].removeMovieClip();
		switch(var2.type)
		{
			case "title":
				this.attachMovie("BookPageTitle",var4,this.getNextHighestDepth(),{_x:var5._x,_y:var5._y,page:var2});
				break;
			case "index":
				this.attachMovie("BookPageIndex",var4,this.getNextHighestDepth(),{_x:var5._x,_y:var5._y,page:var2});
				this[var4].addEventListener("chapterChange",this);
				break;
			case "text":
				this.attachMovie("BookPageText",var4,this.getNextHighestDepth(),{_x:var5._x,_y:var5._y,page:var2});
				break;
			case "blank":
		}
		if(var3)
		{
			this._lblLeftPageNum.text = var2.num != undefined?var2.num:"";
			this._btnAskPageLeft.enabled = var2.num != undefined;
		}
		else
		{
			this._lblRightPageNum.text = var2.num != undefined?var2.num:"";
			this._btnAskPageRight.enabled = var2.num != undefined;
		}
	}
	function askPage(§\x02\n§)
	{
		var var3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:var2,max:var2});
		var3.addEventListener("validate",this);
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnPrevious":
				this.setLeftPageNumber(this._nCurrentLeftPageNum - 2);
				break;
			case "_btnNext":
				this.setLeftPageNumber(this._nCurrentLeftPageNum + 2);
				break;
			default:
				switch(null)
				{
					case "_btnClose":
						this.callClose();
						break;
					case "_btnAskPageLeft":
						this.askPage(1);
						break;
					case "_btnAskPageRight":
						this.askPage(this._oDoc.pageCount - 1);
				}
		}
	}
	function chapterChange(§\x1e\x19\x18§)
	{
		var var3 = var2.pageNum % 2 != 0?var2.pageNum - 1:var2.pageNum;
		this.setLeftPageNumber(var3);
	}
	function validate(§\x1e\x19\x18§)
	{
		var var3 = Number(var2.value);
		if(_global.isNaN(var3))
		{
			var3 = 1;
		}
		if(var3 < 1)
		{
			var3 = 1;
		}
		if(var3 >= this._oDoc.pageCount)
		{
			var3 = this._oDoc.pageCount - 1;
		}
		var var4 = var3 % 2 != 0?var3 - 1:var3;
		this.setLeftPageNumber(var4);
	}
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnPrevious":
				this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_PAGE"),var2.target,-20);
				break;
			case "_btnNext":
				this.gapi.showTooltip(this.api.lang.getText("NEXT_PAGE"),var2.target,-20);
				break;
			default:
				this.gapi.showTooltip(this.api.lang.getText("CHOOSE_PAGE_NUMBER"),var2.target,-20);
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
}
