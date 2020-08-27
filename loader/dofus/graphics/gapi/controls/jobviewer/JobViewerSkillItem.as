class dofus.graphics.gapi.controls.jobviewer.JobViewerSkillItem extends ank.gapi.core.UIBasicComponent
{
	function JobViewerSkillItem()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._mcArrow._visible = true;
			this._lblSkill.text = var4.description;
			this._lblSource.text = var4.interactiveObject != undefined?var4.interactiveObject:"";
			this._lblSkill.setSize(this._lblSource.width - this._lblSource.textWidth - 15,this.__height);
			if(var4.item != undefined)
			{
				if(var4.param1 == var4.param2)
				{
					var var5 = "(#4s)  #1";
				}
				else
				{
					var5 = "(#4s)  #1{~2 " + this._mcList.gapi.api.lang.getText("TO_RANGE") + " }#2";
				}
				this._lblQuantity.text = ank.utils.PatternDecoder.getDescription(var5,new Array(var4.param1,var4.param2,var4.param3,Math.round(var4.param4 / 100) / 10));
				this._ctrIcon.contentData = var4.item;
			}
			else
			{
				var var6 = this._parent._parent._parent._parent;
				var var7 = ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("SLOT"),"n",var4.param1 < 2);
				var var8 = "#1 " + var7 + " (#2%)";
				this._lblQuantity.text = ank.utils.PatternDecoder.getDescription(var8,new Array(var4.param1,var4.param4));
				this._ctrIcon.contentData = undefined;
			}
		}
		else if(this._lblSource.text != undefined)
		{
			this._mcArrow._visible = false;
			this._lblSource.text = "";
			this._lblSkill.text = "";
			this._lblQuantity.text = "";
			this._ctrIcon.contentData = undefined;
		}
	}
	function init()
	{
		super.init(false);
		this._mcArrow._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._ctrIcon.addEventListener("over",this);
		this._ctrIcon.addEventListener("out",this);
	}
	function over(var2)
	{
		var var3 = var2.target.contentData;
		this._mcList._parent._parent.gapi.showTooltip(var3.name,var2.target,-20);
	}
	function out(var2)
	{
		this._mcList._parent._parent.gapi.hideTooltip();
	}
}
