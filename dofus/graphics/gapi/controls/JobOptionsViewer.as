class dofus.graphics.gapi.controls.JobOptionsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "JobOptionsViewer";
	function JobOptionsViewer()
	{
		super();
	}
	function __set__job(loc2)
	{
		this._oJob.removeEventListener("optionsChanged",this);
		this._oJob = loc2;
		this._oJob.addEventListener("optionsChanged",this);
		if(this.initialized)
		{
			this.optionsChanged();
		}
		return this.__get__job();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.JobOptionsViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this.api.datacenter.Player.addEventListener("craftPublicModeChanged",this);
		this._vsCraftComplexity.addEventListener("change",this);
		this._btnEnabled.addEventListener("click",this);
		this._btnEnabled.addEventListener("over",this);
		this._btnEnabled.addEventListener("out",this);
		this._btnValidate.addEventListener("click",this);
		this._btnNotFree.addEventListener("click",this);
		this._btnFreeIfFailed.addEventListener("click",this);
		this._btnRessourcesNeeded.addEventListener("click",this);
	}
	function initTexts()
	{
		this._lblReferencingOptions.text = this.api.lang.getText("REFERENCING_OPTIONS");
		this._lbNotFree.text = this.api.lang.getText("NOT_FREE");
		this._lblFreeIfFailed.text = this.api.lang.getText("FREE_IF_FAILED");
		this._lblRessourcesNeeded.text = this.api.lang.getText("CRAFT_RESSOURCES_NEEDED");
		this._lblCraftComplexity.text = this.api.lang.getText("MIN_ITEM_IN_RECEIPT");
		this._txtInfos.text = this.api.lang.getText("PUBLIC_MODE_INFOS");
		this._btnValidate.label = this.api.lang.getText("SAVE");
		this._btnValidate.enabled = false;
		this.craftPublicModeChanged();
	}
	function initData()
	{
		this.optionsChanged();
	}
	function refreshBtnEnabledLabel()
	{
		this._btnEnabled.label = !this.api.datacenter.Player.craftPublicMode?this.api.lang.getText("ENABLE"):this.api.lang.getText("DISABLE");
	}
	function refreshCraftComplexityLabel(loc2)
	{
		this._lblCraftComplexityValue.text = loc2.toString() + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("SLOT"),"m",loc2 < 2);
	}
	function change(loc2)
	{
		if((var loc0 = loc2.target._name) === "_vsCraftComplexity")
		{
			this.refreshCraftComplexityLabel(this._vsCraftComplexity.value);
			this._btnValidate.enabled = true;
		}
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnEnabled":
				this.api.network.Exchange.setPublicMode(!this.api.datacenter.Player.craftPublicMode);
				break;
			case "_btnValidate":
				var loc3 = this.api.datacenter.Player.Jobs.findFirstItem("id",this._oJob.id);
				if(loc3.index != -1)
				{
					var loc4 = (!this._btnNotFree.selected?0:1) + (!this._btnFreeIfFailed.selected?0:2) + (!this._btnRessourcesNeeded.selected?0:4);
					this.api.network.Job.changeJobStats(loc3.index,loc4,this._vsCraftComplexity._visible != false?this._vsCraftComplexity.value:2);
				}
				break;
			case "_btnNotFree":
				this._btnFreeIfFailed.enabled = !this._btnNotFree.selected?false:true;
				break;
			default:
				switch(null)
				{
					case "_btnFreeIfFailed":
					case "_btnRessourcesNeeded":
				}
		}
		this._btnValidate.enabled = true;
	}
	function optionsChanged(loc2)
	{
		if(this._oJob != undefined && this._btnNotFree.selected != undefined)
		{
			var loc3 = this._oJob.options;
			var loc4 = this._oJob.getMaxSkillSlot();
			loc4 = loc4 <= 8?loc4:8;
			if(loc4 > 2)
			{
				this._vsCraftComplexity._visible = true;
				this._vsCraftComplexity.markerCount = loc4 - 1;
				this._vsCraftComplexity.min = 2;
				this._vsCraftComplexity.max = loc4;
				this._vsCraftComplexity.redraw();
				this._vsCraftComplexity.value = loc3.minSlots;
			}
			else
			{
				this._vsCraftComplexity._visible = false;
			}
			this.refreshCraftComplexityLabel(loc3.minSlots);
			this._btnNotFree.selected = loc3.isNotFree;
			this._btnFreeIfFailed.selected = loc3.isFreeIfFailed;
			this._btnFreeIfFailed.enabled = !this._btnNotFree.selected?false:true;
			this._btnRessourcesNeeded.selected = loc3.ressourcesNeeded;
			this._btnValidate.enabled = false;
		}
	}
	function craftPublicModeChanged(loc2)
	{
		this._lblPublicMode.text = this.api.lang.getText("PUBLIC_MODE") + " (" + this.api.lang.getText(!this.api.datacenter.Player.craftPublicMode?"INACTIVE":"ACTIVE") + ")";
		this.refreshBtnEnabledLabel();
		this._mcPublicDisable._visible = !this.api.datacenter.Player.craftPublicMode;
		this._mcPublicEnable._visible = this.api.datacenter.Player.craftPublicMode;
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._btnEnabled)
		{
			var loc3 = !this.api.datacenter.Player.craftPublicMode?this.api.lang.getText("ENABLE_PUBLIC_MODE"):this.api.lang.getText("DISABLE_PUBLIC_MODE");
			this.gapi.showTooltip(loc3,loc2.target,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
