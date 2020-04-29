class dofus.graphics.gapi.controls.JobOptionsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "JobOptionsViewer";
	function JobOptionsViewer()
	{
		super();
	}
	function __set__job(var2)
	{
		this._oJob.removeEventListener("optionsChanged",this);
		this._oJob = var2;
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
	function refreshCraftComplexityLabel(var2)
	{
		this._lblCraftComplexityValue.text = var2.toString() + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("SLOT"),"m",var2 < 2);
	}
	function change(var2)
	{
		if((var var0 = var2.target._name) === "_vsCraftComplexity")
		{
			this.refreshCraftComplexityLabel(this._vsCraftComplexity.value);
			this._btnValidate.enabled = true;
		}
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnEnabled":
				this.api.network.Exchange.setPublicMode(!this.api.datacenter.Player.craftPublicMode);
				break;
			case "_btnValidate":
				var var3 = this.api.datacenter.Player.Jobs.findFirstItem("id",this._oJob.id);
				if(var3.index != -1)
				{
					var var4 = (!this._btnNotFree.selected?0:1) + (!this._btnFreeIfFailed.selected?0:2) + (!this._btnRessourcesNeeded.selected?0:4);
					this.api.network.Job.changeJobStats(var3.index,var4,this._vsCraftComplexity._visible != false?this._vsCraftComplexity.value:2);
				}
				break;
			default:
				switch(null)
				{
					case "_btnNotFree":
						this._btnFreeIfFailed.enabled = !this._btnNotFree.selected?false:true;
					case "_btnFreeIfFailed":
					case "_btnRessourcesNeeded":
						this._btnValidate.enabled = true;
				}
		}
	}
	function optionsChanged(var2)
	{
		if(this._oJob != undefined && this._btnNotFree.selected != undefined)
		{
			var var3 = this._oJob.options;
			var var4 = this._oJob.getMaxSkillSlot();
			var4 = var4 <= 8?var4:8;
			if(var4 > 2)
			{
				this._vsCraftComplexity._visible = true;
				this._vsCraftComplexity.markerCount = var4 - 1;
				this._vsCraftComplexity.min = 2;
				this._vsCraftComplexity.max = var4;
				this._vsCraftComplexity.redraw();
				this._vsCraftComplexity.value = var3.minSlots;
			}
			else
			{
				this._vsCraftComplexity._visible = false;
			}
			this.refreshCraftComplexityLabel(var3.minSlots);
			this._btnNotFree.selected = var3.isNotFree;
			this._btnFreeIfFailed.selected = var3.isFreeIfFailed;
			this._btnFreeIfFailed.enabled = !this._btnNotFree.selected?false:true;
			this._btnRessourcesNeeded.selected = var3.ressourcesNeeded;
			this._btnValidate.enabled = false;
		}
	}
	function craftPublicModeChanged(var2)
	{
		this._lblPublicMode.text = this.api.lang.getText("PUBLIC_MODE") + " (" + this.api.lang.getText(!this.api.datacenter.Player.craftPublicMode?"INACTIVE":"ACTIVE") + ")";
		this.refreshBtnEnabledLabel();
		this._mcPublicDisable._visible = !this.api.datacenter.Player.craftPublicMode;
		this._mcPublicEnable._visible = this.api.datacenter.Player.craftPublicMode;
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._btnEnabled)
		{
			var var3 = !this.api.datacenter.Player.craftPublicMode?this.api.lang.getText("ENABLE_PUBLIC_MODE"):this.api.lang.getText("DISABLE_PUBLIC_MODE");
			this.gapi.showTooltip(var3,var2.target,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
