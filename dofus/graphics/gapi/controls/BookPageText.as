class dofus.graphics.gapi.controls.BookPageText extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BookPageText";
	function BookPageText()
	{
		super();
	}
	function __set__page(loc2)
	{
		this._oPage = loc2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__page();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.BookPageText.CLASS_NAME);
	}
	function createChildren()
	{
		this._txtPage.wordWrap = true;
		this._txtPage.multiline = true;
		this._txtPage.embedFonts = true;
		this.addToQueue({object:this,method:this.updateData});
	}
	function updateData()
	{
		this.setCssStyle(this._oPage.cssFile);
	}
	function setCssStyle(loc2)
	{
		var loc3 = new TextField.StyleSheet();
		loc3.owner = this;
		loc3.onLoad = function()
		{
			this.owner.layoutContent(this);
		};
		loc3.load(loc2);
	}
	function layoutContent(loc2)
	{
		this._txtPage.styleSheet = loc2;
		this._txtPage.htmlText = this._oPage.text;
	}
}
