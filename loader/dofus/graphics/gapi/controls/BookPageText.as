class dofus.graphics.gapi.controls.BookPageText extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BookPageText";
	function BookPageText()
	{
		super();
	}
	function __set__page(§\x1e\x18\x16§)
	{
		this._oPage = var2;
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
	function setCssStyle(§\x1e\x13\x14§)
	{
		var var3 = new TextField.StyleSheet();
		var3.owner = this;
		var3.onLoad = function()
		{
			this.owner.layoutContent(this);
		};
		var3.load(var2);
	}
	function layoutContent(§\x1e\r\x17§)
	{
		this._txtPage.styleSheet = var2;
		this._txtPage.htmlText = this._oPage.text;
	}
}
