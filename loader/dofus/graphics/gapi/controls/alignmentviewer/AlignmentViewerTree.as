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
		var var2 = this.api.datacenter.Player.specialization;
		var var3 = var2.alignment.index;
		var var4 = var2.index;
		var var5 = var2.order.index;
		var var6 = new Array();
		var var7 = this.api.lang.getAlignmentSpecializations();
		for(var k in var7)
		{
			var var8 = new dofus.datacenter.Specialization(Number(k));
			if(var8.order.index == var5)
			{
				if(var8.description != "null")
				{
					var var9 = var8.alignment;
					var var10 = var8.order;
					var var11 = var6[var3 != var9.index?var9.index + 1:0];
					if(var11 == undefined)
					{
						var11 = new Array({data:var9,depth:0});
						var6[var3 != var9.index?var9.index + 1:0] = var11;
					}
					var var12 = var11[var10.index];
					if(var12 == undefined)
					{
						var12 = new Array({data:var10,depth:1,sortField:-1});
						var11[var10.index] = var12;
					}
					var12.push({data:var8,depth:2,sortField:var9.value});
				}
			}
		}
		var var13 = new ank.utils.();
		var var14 = 0;
		while(var14 < var6.length)
		{
			if(var6[var14] != undefined)
			{
				var var15 = new ank.utils.();
				var var16 = 0;
				while(var16 < var6[var14].length)
				{
					if(var6[var14][var16] != undefined)
					{
						var6[var14][var16].sortOn("sortField",Array.NUMERIC);
						var15 = var15.concat(var6[var14][var16]);
					}
					var16 = var16 + 1;
				}
				var13 = var13.concat(var15);
			}
			var14 = var14 + 1;
		}
		this._lstTree.dataProvider = var13;
		if(var4 != undefined)
		{
			var var17 = -1;
			for(var k in var13)
			{
				var var18 = var13[k].data;
				if(var18 instanceof dofus.datacenter.Specialization)
				{
					if(var18.index == var4)
					{
						var17 = Number(k);
						break;
					}
				}
			}
			this._lstTree.selectedIndex = var17;
		}
	}
	function itemSelected(var2)
	{
		this.gapi.hideTooltip();
		if(var2.row.item.data instanceof dofus.datacenter.Specialization)
		{
			this.dispatchEvent({type:"specializationSelected",specialization:var2.row.item.data});
		}
		else if(var2.row.item.data instanceof dofus.datacenter.Order)
		{
			this.dispatchEvent({type:"orderSelected",order:var2.row.item.data});
		}
		else if(var2.row.item.data instanceof dofus.datacenter.Alignment)
		{
			this.dispatchEvent({type:"alignementSelected",alignement:var2.row.item.data});
		}
		else
		{
			this._lstTree.selectedIndex = -1;
			this.dispatchEvent({type:"itemSelected"});
		}
	}
	function itemRollOver(var2)
	{
		var var3 = var2.target.item.data;
		if(var3 instanceof dofus.datacenter.Specialization)
		{
			this.gapi.showTooltip(var3.description,this,this.__height + 30);
		}
	}
	function itemRollOut(var2)
	{
		this.gapi.hideTooltip();
	}
}
