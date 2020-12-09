class dofus.graphics.gapi.controls.BookPageIndex extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BookPageIndex";
	function BookPageIndex()
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
		super.init(false,dofus.graphics.gapi.controls.BookPageIndex.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._lstChapters.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._lblIndex.text = this.api.lang.getText("TABLE_OF_CONTENTS");
	}
	function updateData()
	{
		this._lstChapters.dataProvider = this._oPage.chapters;
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		var var3 = var2.row.item[4];
		this.dispatchEvent({type:"chapterChange",pageNum:var3});
	}
}
