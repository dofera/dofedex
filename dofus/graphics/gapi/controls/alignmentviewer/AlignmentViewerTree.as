class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "AlignmentViewerTree";
	function AlignmentViewerTree()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._lblInfos.text = this.api.lang.getText("ALL_SPECIALIZATIONS");
		this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
	}
	function addListeners()
	{
		this._lstTree.addEventListener("itemRollOver",this);
		this._lstTree.addEventListener("itemRollOut",this);
		this._lstTree.addEventListener("itemSelected",this);
	}
	function initData()
	{
		var loc2 = this.api.datacenter.Player.specialization;
		var loc3 = loc2.alignment.index;
		var loc4 = loc2.index;
		var loc5 = loc2.order.index;
		var loc6 = new Array();
		var loc7 = this.api.lang.getAlignmentSpecializations();
		for(var k in loc7)
		{
			var loc8 = new dofus.datacenter.Specialization(Number(k));
			if(loc8.order.index == loc5)
			{
				if(loc8.description != "null")
				{
					var loc9 = loc8.alignment;
					var loc10 = loc8.order;
					var loc11 = loc6[loc3 != loc9.index?loc9.index + 1:0];
					if(loc11 == undefined)
					{
						loc11 = new Array({data:loc9,depth:0});
						loc6[loc3 != loc9.index?loc9.index + 1:0] = loc11;
					}
					var loc12 = loc11[loc10.index];
					if(loc12 == undefined)
					{
						loc12 = new Array({data:loc10,depth:1,sortField:-1});
						loc11[loc10.index] = loc12;
					}
					loc12.push({data:loc8,depth:2,sortField:loc9.value});
				}
			}
		}
		var loc13 = new ank.utils.();
		var loc14 = 0;
		while(loc14 < loc6.length)
		{
			if(loc6[loc14] != undefined)
			{
				var loc15 = new ank.utils.();
				var loc16 = 0;
				while(loc16 < loc6[loc14].length)
				{
					if(loc6[loc14][loc16] != undefined)
					{
						loc6[loc14][loc16].sortOn("sortField",Array.NUMERIC);
						loc15 = loc15.concat(loc6[loc14][loc16]);
					}
					loc16 = loc16 + 1;
				}
				loc13 = loc13.concat(loc15);
			}
			loc14 = loc14 + 1;
		}
		this._lstTree.dataProvider = loc13;
		if(loc4 != undefined)
		{
			var loc17 = -1;
			for(var k in loc13)
			{
				var loc18 = loc13[k].data;
				if(loc18 instanceof dofus.datacenter.Specialization)
				{
					if(loc18.index == loc4)
					{
						loc17 = Number(k);
						break;
					}
				}
			}
			this._lstTree.selectedIndex = loc17;
		}
	}
	function itemSelected(loc2)
	{
		this.gapi.hideTooltip();
		if(loc2.row.item.data instanceof dofus.datacenter.Specialization)
		{
			this.dispatchEvent({type:"specializationSelected",specialization:loc2.row.item.data});
		}
		else if(loc2.row.item.data instanceof dofus.datacenter.Order)
		{
			this.dispatchEvent({type:"orderSelected",order:loc2.row.item.data});
		}
		else if(loc2.row.item.data instanceof dofus.datacenter.Alignment)
		{
			this.dispatchEvent({type:"alignementSelected",alignement:loc2.row.item.data});
		}
		else
		{
			this._lstTree.selectedIndex = -1;
			this.dispatchEvent({type:"itemSelected"});
		}
	}
	function itemRollOver(loc2)
	{
		var loc3 = loc2.target.item.data;
		if(loc3 instanceof dofus.datacenter.Specialization)
		{
			this.gapi.showTooltip(loc3.description,this,this.__height + 30);
		}
	}
	function itemRollOut(loc2)
	{
		this.gapi.hideTooltip();
	}
}
