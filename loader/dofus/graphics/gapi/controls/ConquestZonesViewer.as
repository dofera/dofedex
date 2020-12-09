class dofus.graphics.gapi.controls.ConquestZonesViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ConquestZonesViewer";
	static var FILTER_VULNERALE_AREAS = -4;
	static var FILTER_CAPTURABLE_AREAS = -3;
	static var FILTER_ALL_AREAS = -2;
	static var FILTER_HOSTILE_AREAS = -1;
	function ConquestZonesViewer()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ConquestZonesViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("FILTER");
		this._lblAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"),null,false);
		this._lblAreaTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_AREA_WORD"),null,true);
		this._lblAreaDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
		this._lblVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"),null,false);
		this._lblVillageTitle.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_VILLAGE_WORD"),null,true);
		this._lblVillageDetails.text = this.api.lang.getText("CONQUEST_STATE_WORD") + " / " + this.api.lang.getText("CONQUEST_DOOR_WORD") + " / " + this.api.lang.getText("CONQUEST_PRISM_WORD");
	}
	function addListeners()
	{
		var ref = this;
		this._mcGotAreasInteractivity.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcGotAreasInteractivity.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcGotVillagesInteractivity.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcGotVillagesInteractivity.onRollOut = function()
		{
			ref.out({target:this});
		};
		this.api.datacenter.Conquest.addEventListener("worldDataChanged",this);
		this._cbFilter.addEventListener("itemSelected",this);
	}
	function refreshAreaList()
	{
		var var2 = this.api.datacenter.Conquest.worldDatas;
		var var3 = this._cbFilter.selectedItem.value;
		var var4 = new ank.utils.
();
		var var5 = new String();
		var var6 = 0;
		while(var6 < var2.areas.length)
		{
			if(!(var3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS && !var2.areas[var6].fighting))
			{
				if(!(var3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS && !var2.areas[var6].isCapturable()))
				{
					if(!(var3 == dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS && !var2.areas[var6].isVulnerable()))
					{
						if(!(var3 >= 0 && var2.areas[var6].alignment != var3))
						{
							if(var5 != var2.areas[var6].areaName)
							{
								var4.push({area:var2.areas[var6].areaId});
								var5 = var2.areas[var6].areaName;
							}
							var4.push(var2.areas[var6]);
						}
					}
				}
			}
			var6 = var6 + 1;
		}
		this._lstAreas.dataProvider = var4;
	}
	function initData()
	{
		var var2 = this.api.datacenter.Conquest.worldDatas;
		this._lblGotAreas.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"),"f",false) + " : " + var2.ownedAreas + " / " + var2.possibleAreas + " / " + var2.totalAreas;
		this._lblGotVillages.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("CONQUEST_POSSESSED_WORD"),"m",false) + " : " + var2.ownedVillages + " / " + var2.totalVillages;
		this.refreshAreaList();
		this._lstVillages.dataProvider = var2.villages;
		var var3 = new ank.utils.
();
		var var4 = this.api.lang.getAlignments();
		for(var s in var4)
		{
			if(var4[s].c)
			{
				var3.push({label:this.api.lang.getText("CONQUEST_ALIGNED_AREAS",[var4[s].n]),value:s});
			}
		}
		var3.push({label:this.api.lang.getText("CONQUEST_HOSTILE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_HOSTILE_AREAS});
		var3.push({label:this.api.lang.getText("CONQUEST_CAPTURABLE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_CAPTURABLE_AREAS});
		var3.push({label:this.api.lang.getText("CONQUEST_VULNERALE_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_VULNERALE_AREAS});
		var3.push({label:this.api.lang.getText("CONQUEST_ALL_AREAS"),value:dofus.graphics.gapi.controls.ConquestZonesViewer.FILTER_ALL_AREAS});
		this._cbFilter.dataProvider = var3;
		this._cbFilter.selectedIndex = var3.findFirstItem("value",this.api.kernel.OptionsManager.getOption("ConquestFilter")).index;
	}
	function over(§\x0f\r§)
	{
		var var3 = this.api.datacenter.Conquest.worldDatas;
		switch(var2.target)
		{
			case this._mcGotAreasInteractivity:
				this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_ZONES",[var3.ownedAreas,var3.possibleAreas,var3.ownedVillages,var3.totalAreas]),this._mcGotAreasInteractivity,-55);
				break;
			case this._mcGotVillagesInteractivity:
				this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_GOT_VILLAGES",[var3.ownedVillages,var3.totalVillages]),this._mcGotVillagesInteractivity,-20);
		}
	}
	function out(§\x0f\r§)
	{
		this.api.ui.hideTooltip();
	}
	function worldDataChanged(§\x0f\r§)
	{
		this.addToQueue({object:this,method:this.initData});
	}
	function itemSelected(§\x0f\r§)
	{
		this.api.kernel.OptionsManager.setOption("ConquestFilter",this._cbFilter.selectedItem.value);
		this.refreshAreaList();
	}
}
