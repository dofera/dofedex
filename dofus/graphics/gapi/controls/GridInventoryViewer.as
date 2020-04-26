class dofus.graphics.gapi.controls.GridInventoryViewer extends dofus.graphics.gapi.controls.InventoryViewer
{
	static var CLASS_NAME = "GridInventoryViewer";
	var _bShowKamas = true;
	var _bCheckPlayerPods = false;
	var _bCheckMountPods = false;
	function GridInventoryViewer()
	{
		super();
	}
	function __get__checkPlayerPods()
	{
		return this._bCheckPlayerPods;
	}
	function __get__checkMountPods()
	{
		return this._bCheckMountPods;
	}
	function __set__checkPlayerPods(loc2)
	{
		this._bCheckPlayerPods = loc2;
		return this.__get__checkPlayerPods();
	}
	function __set__checkMountPods(loc2)
	{
		this._bCheckMountPods = loc2;
		return this.__get__checkMountPods();
	}
	function __set__showKamas(loc2)
	{
		this._bShowKamas = loc2;
		this._btnDragKama._visible = this._lblKama._visible = this._mcKamaSymbol._visible = this._mcKamaSymbol2._visible = loc2;
		return this.__get__showKamas();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.GridInventoryViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this._oDataViewer = this._cgGrid;
		this.addToQueue({object:this,method:this.addListeners});
		super.createChildren();
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		super.addListeners();
		this._cgGrid.addEventListener("dropItem",this);
		this._cgGrid.addEventListener("dragItem",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.addEventListener("overItem",this);
		this._cgGrid.addEventListener("outItem",this);
		this._cgGrid.addEventListener("dblClickItem",this);
		this._btnDragKama.onRelease = function()
		{
			this._parent.askKamaQuantity();
		};
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
	}
	function initData()
	{
		this.modelChanged();
		this.kamaChanged({value:this._oKamasProvider.Kama});
	}
	function validateDrop(loc2, loc3, loc4)
	{
		loc4 = Number(loc4);
		if(loc4 < 1 || _global.isNaN(loc4))
		{
			return undefined;
		}
		if(loc4 > loc3.Quantity)
		{
			loc4 = loc3.Quantity;
		}
		this.dispatchEvent({type:"dropItem",item:loc3,quantity:loc4});
	}
	function validateKama(loc2)
	{
		loc2 = Number(loc2);
		if(loc2 < 1 || _global.isNaN(loc2))
		{
			return undefined;
		}
		if(loc2 > this._oKamasProvider.Kama)
		{
			loc2 = this._oKamasProvider.Kama;
		}
		this.dispatchEvent({type:"dragKama",quantity:loc2});
	}
	function askKamaQuantity()
	{
		var loc2 = this._oKamasProvider.Kama == undefined?0:Number(this._oKamasProvider.Kama);
		var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:loc2,max:loc2,params:{targetType:"kama"}});
		loc3.addEventListener("validate",this);
	}
	function showOneItem(loc2)
	{
		var loc3 = 0;
		while(loc3 < this._cgGrid.dataProvider.length)
		{
			if(loc2 == this._cgGrid.dataProvider[loc3].unicID)
			{
				this._cgGrid.setVPosition(loc3 / this._cgGrid.visibleColumnCount);
				this._cgGrid.selectedIndex = loc3;
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
	function dragItem(loc2)
	{
		if(loc2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(loc2.target.contentData);
	}
	function dropItem(loc2)
	{
		var loc3 = this.gapi.getCursor();
		if(loc3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		var loc4 = loc3.Quantity;
		if(this.checkPlayerPods)
		{
			loc4 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(loc3,false);
		}
		else if(this.checkMountPods)
		{
			loc4 = this.api.datacenter.Player.getPossibleItemReceiveQuantity(loc3,true);
		}
		if(loc4 <= 0)
		{
			this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_6"),"ERROR_BOX",{name:undefined});
		}
		else if(loc4 > 1)
		{
			var loc5 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc4,params:{targetType:"item",oItem:loc3}});
			loc5.addEventListener("validate",this);
		}
		else
		{
			this.validateDrop(this._cgGrid,loc3,1);
		}
	}
	function selectItem(loc2)
	{
		if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc2.target.contentData != undefined)
		{
			this.api.kernel.GameManager.insertItemInChat(loc2.target.contentData);
			return undefined;
		}
		this.dispatchEvent({type:"selectedItem",item:loc2.target.contentData});
	}
	function overItem(loc2)
	{
		var loc3 = loc2.target.contentData;
		var loc4 = -20;
		var loc5 = loc3.name;
		var loc6 = true;
		for(var s in loc3.effects)
		{
			var loc7 = loc3.effects[s];
			if(loc7.description.length > 0)
			{
				if(loc6)
				{
					loc5 = loc5 + "\n";
					loc4 = loc4 - 10;
					loc6 = false;
				}
				loc5 = loc5 + "\n" + loc7.description;
				loc4 = loc4 - 12;
			}
		}
		this.gapi.showTooltip(loc5,loc2.target,loc4,undefined,loc2.target.contentData.style + "ToolTip");
	}
	function outItem(loc2)
	{
		this.gapi.hideTooltip();
	}
	function dblClickItem(loc2)
	{
		this.dispatchEvent({type:loc2.type,item:loc2.target.contentData,target:this,index:loc2.target.id});
	}
	function validate(loc2)
	{
		switch(loc2.params.targetType)
		{
			case "item":
				this.validateDrop(this._cgGrid,loc2.params.oItem,loc2.value);
				break;
			case "kama":
				this.validateKama(loc2.value);
		}
	}
}
