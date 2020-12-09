class dofus.graphics.gapi.controls.InventoryViewerWithAllFilter extends dofus.graphics.gapi.controls.InventoryViewer
{
	static var DEFAULT_FILTER = 3;
	static var FILTER_ID_ALL = 3;
	static var FILTER_ALL = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,false];
	function InventoryViewerWithAllFilter()
	{
		super();
	}
	function setFilter(§\x05\x10§)
	{
		if(var3 == this._nCurrentFilterID)
		{
			return undefined;
		}
		if(var3 == dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL)
		{
			this.click({target:this._btnFilterAll});
			this._btnFilterAll.selected = true;
		}
		else
		{
			super.setFilter(var3);
		}
	}
	function createChildren()
	{
		super.createChildren();
	}
	function addListeners()
	{
		super.addListeners();
		this._btnFilterAll.addEventListener("click",this);
		this._btnFilterAll.addEventListener("over",this);
		this._btnFilterAll.addEventListener("out",this);
	}
	function getDefaultFilter()
	{
		return dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL;
	}
	function setPreferedFilter()
	{
		this.setFilter(this.getDefaultFilter());
	}
	function click(§\x1e\x19\x18§)
	{
		if(var3.target == this._btnFilterAll)
		{
			if(var3.target != this._btnSelectedFilterButton)
			{
				this._btnSelectedFilterButton.selected = false;
				this._btnSelectedFilterButton = var3.target;
				this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ALL;
				this._lblFilter.text = this.api.lang.getText("ALL");
				this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL;
				this.updateData();
			}
			else
			{
				var3.target.selected = true;
			}
		}
		else
		{
			super.click(var3);
		}
	}
	function over(§\x1e\x19\x18§)
	{
		if(var3.target == this._btnFilterAll)
		{
			this.api.ui.showTooltip(this.api.lang.getText("ALL"),var3.target,-20);
		}
		else
		{
			super.over(var3);
		}
	}
}
