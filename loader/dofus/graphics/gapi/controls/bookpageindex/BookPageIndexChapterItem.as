class dofus.graphics.gapi.controls.bookpageindex.BookPageIndexChapterItem extends ank.gapi.core.UIBasicComponent
{
	function BookPageIndexChapterItem()
	{
		super();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._lblPageNum.text = !var2?"":var4[4];
			var var5 = this._lblPageNum.textWidth;
			this._lblChapter.text = !var2?"":var4[0];
			this._lblChapter.setSize(this.__width - var5 - 30,this.__height);
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
