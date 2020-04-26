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
	function __set__data(loc2)
	{
		this.addToQueue({object:this,method:function(loc2)
		{
			this._eaData = loc2;
			if(this.initialized)
			{
				this.initData();
			}
		},params:[loc2]});
		return this.__get__data();
	}
	function __set__type(loc2)
	{
		this._nType = loc2;
		return this.__get__type();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Subway.CLASS_NAME);
	}
	function callClose()
	{
		if((var loc0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(loc0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
			{
				this.api.network.Subway.prismLeave();
			}
		}
		else
		{
			this.api.network.Subway.leave();
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
		if((var loc0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(loc0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
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
		if((loc0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(loc0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
			{
				this._lstSubway.dataProvider = this._eaData;
			}
		}
		else
		{
			for(var a in this._eaData)
			{
				var loc2 = new Object();
				loc2._y = this._mcTabPlacer._y;
				loc2._height = 20;
				loc2.backgroundDown = "ButtonTabDown";
				loc2.backgroundUp = "ButtonTabUp";
				loc2.styleName = "BrownTabButton";
				loc2.toggle = true;
				loc2.selected = true;
				loc2.enabled = true;
				loc2.label = " " + this._eaData[a][0].category + " ";
				var loc3 = (ank.gapi.controls.Button)this.attachMovie("Button","_btnTab" + a,this.getNextHighestDepth(),loc2);
				loc3.addEventListener("click",this);
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
	function setCurrentTab(loc2)
	{
		if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			return undefined;
		}
		var loc3 = this["_btnTab" + this._nCurrentCategory];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._nCurrentCategory = loc2;
		this.updateCurrentTabInformations();
		this.setTabsPreferedSize();
	}
	function setTabsPreferedSize()
	{
		if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			return undefined;
		}
		var loc2 = this._mcTabPlacer._x;
		for(var a in this._eaData)
		{
			var loc3 = (ank.gapi.controls.Button)this["_btnTab" + a];
			loc3._x = loc2;
			loc3.setPreferedSize();
			loc2 = loc2 + loc3.width;
		}
	}
	function click(loc2)
	{
		var loc3 = loc2.target._name;
		switch(loc3)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			default:
				this.setCurrentTab(Number(loc3.substr(7)));
		}
	}
	function itemSelected(loc2)
	{
		var loc3 = loc2.row.item;
		var loc4 = loc3.cost;
		if(this.api.datacenter.Player.Kama < loc4)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGH_RICH"),"ERROR_BOX");
		}
		else if((var loc0 = this._nType) !== dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
		{
			if(loc0 === dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM)
			{
				this.api.network.Subway.prismUse(loc3.mapID);
			}
		}
		else
		{
			this.api.network.Subway.use(loc3.mapID);
		}
	}
}
