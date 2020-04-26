class dofus.graphics.gapi.controls.InventoryViewerWithAllFilter extends dofus.graphics.gapi.controls.InventoryViewer
{
	static var DEFAULT_FILTER = 3;
	static var FILTER_ID_ALL = 3;
	static var FILTER_ALL = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,false];
	function InventoryViewerWithAllFilter()
	{
		super();
	}
	function setFilter(loc2)
	{
		if(loc3 == this._nCurrentFilterID)
		{
			return undefined;
		}
		if(loc3 == dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL)
		{
			this.click({target:this._btnFilterAll});
			this._btnFilterAll.selected = true;
		}
		else
		{
			super.setFilter(loc3);
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
	function click(loc2)
	{
		if(loc3.target == this._btnFilterAll)
		{
			if(loc3.target != this._btnSelectedFilterButton)
			{
				this._btnSelectedFilterButton.selected = false;
				this._btnSelectedFilterButton = loc3.target;
				this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ALL;
				this._lblFilter.text = this.api.lang.getText("ALL");
				this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewerWithAllFilter.FILTER_ID_ALL;
				this.updateData();
			}
			else
			{
				loc3.target.selected = true;
			}
		}
		else
		{
			super.click(loc3);
		}
	}
	function over(loc2)
	{
		if(loc3.target == this._btnFilterAll)
		{
			this.api.ui.showTooltip(this.api.lang.getText("ALL"),loc3.target,-20);
		}
		else
		{
			super.over(loc3);
		}
	}
}
