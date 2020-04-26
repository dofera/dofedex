class dofus.graphics.gapi.controls.bookpageindex.BookPageIndexChapterItem extends ank.gapi.core.UIBasicComponent
{
	function BookPageIndexChapterItem()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._lblPageNum.text = !loc2?"":loc4[4];
			var loc5 = this._lblPageNum.textWidth;
			this._lblChapter.text = !loc2?"":loc4[0];
			this._lblChapter.setSize(this.__width - loc5 - 30,this.__height);
		}
		else if(this._lblPageNum.text != undefined)
		{
			this._lblPageNum.text = "";
			this._lblChapter.text = "";
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.arrange();
	}
	function size()
	{
		super.size();
		this.addToQueue({object:this,method:this.arrange});
	}
	function arrange()
	{
		this._lblChapter.setSize(this.__width - 50,this.__height);
		this._lblPageNum.setSize(this.__width - 20,this.__height);
	}
}
