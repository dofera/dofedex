class dofus.graphics.gapi.ui.Subway extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Subway";
	static var SUBWAY_TYPE_SUBWAY = 1;
	static var SUBWAY_TYPE_PRISM = 2;
	var _nCurrentCategory = 0;
	var _nType = dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY;
	function Subway()
	{
		super();
	}
	function __set__data(var2)
	{
		this.addToQueue({object:this,method:function(var2)
		{
			this._eaData = var2;
			if(this.initialized)
			{
				this.initData();
			}
		},params:[var2]});
		return this.__get__data();
	}
	function __set__type(var2)
	{
		this._nType = var2;
		return this.__get__type();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Subway.CLASS_NAME);
	}
	function callClose()
	{
		switch(this._nType)
		{
			case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
				this.api.network.Subway.leave();
				break;
			case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
				this.api.network.Subway.prismLeave();
		}
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		if((var var0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(var0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
			{
				this._winBg.title = this.api.lang.getText("PRISM_LIST");
				this._lblPrismNotice._visible = true;
				this._lblDescription._visible = false;
				this._lblPrismNotice.text = this.api.lang.getText("PRISM_NOTICE");
			}
		}
		else
		{
			this._winBg.title = this.api.lang.getText("SUBWAY_LIST");
			this._lblPrismNotice._visible = false;
			this._lblDescription._visible = true;
		}
		this._lblCoords.text = this.api.lang.getText("COORDINATES_SMALL");
		this._lblName.text = this.api.lang.getText("PLACE");
		this._lblCost.text = this.api.lang.getText("COST");
		this._lblDescription.text = this.api.lang.getText("CLICK_ON_WAYPOINT");
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		if((var0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(var0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
			{
				this._lstSubway.dataProvider = this._eaData;
			}
		}
		else
		{
			for(var a in this._eaData)
			{
				var var2 = new Object();
				var2._y = this._mcTabPlacer._y;
				var2._height = 20;
				var2.backgroundDown = "ButtonTabDown";
				var2.backgroundUp = "ButtonTabUp";
				var2.styleName = "BrownTabButton";
				var2.toggle = true;
				var2.selected = true;
				var2.enabled = true;
				var2.label = " " + this._eaData[a][0].category + " ";
				var var3 = (ank.gapi.controls.Button)this.attachMovie("Button","_btnTab" + a,this.getNextHighestDepth(),var2);
				var3.addEventListener("click",this);
			}
			this.setCurrentTab(0);
		}
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._lstSubway.addEventListener("itemSelected",this);
	}
	function initData()
	{
		if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			return undefined;
		}
		if(this._eaData != undefined && this._eaData.length > 0)
		{
			for(var a in this._eaData)
			{
				this.setCurrentTab(Number(a));
				return undefined;
				
				break;
			}
		}
	}
	function updateCurrentTabInformations()
	{
		if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			return undefined;
		}
		this._eaData[this._nCurrentCategory].sortOn("fieldToSort",Array.CASEINSENSITIVE);
		this._lstSubway.dataProvider = this._eaData[this._nCurrentCategory];
	}
	function setCurrentTab(var2)
	{
		if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			return undefined;
		}
		var var3 = this["_btnTab" + this._nCurrentCategory];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		this._nCurrentCategory = var2;
		this.updateCurrentTabInformations();
		this.setTabsPreferedSize();
	}
	function setTabsPreferedSize()
	{
		if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			return undefined;
		}
		var var2 = this._mcTabPlacer._x;
		for(var a in this._eaData)
		{
			var var3 = (ank.gapi.controls.Button)this["_btnTab" + a];
			var3._x = var2;
			var3.setPreferedSize();
			var2 = var2 + var3.width;
		}
	}
	function click(var2)
	{
		var var3 = var2.target._name;
		switch(var3)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			default:
				this.setCurrentTab(Number(var3.substr(7)));
		}
	}
	function itemSelected(var2)
	{
		var var3 = var2.row.item;
		var var4 = var3.cost;
		if(this.api.datacenter.Player.Kama < var4)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGH_RICH"),"ERROR_BOX");
		}
		else if((var var0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(var0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
			{
				this.api.network.Subway.prismUse(var3.mapID);
			}
		}
		else
		{
			this.api.network.Subway.use(var3.mapID);
		}
	}
}
