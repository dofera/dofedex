class dofus.graphics.gapi.controls.jobviewer.JobViewerSkillItem extends ank.gapi.core.UIBasicComponent
{
	function JobViewerSkillItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._mcArrow._visible = true;
			this._lblSkill.text = loc4.description;
			this._lblSource.text = loc4.interactiveObject != undefined?loc4.interactiveObject:"";
			this._lblSkill.setSize(this._lblSource.width - this._lblSource.textWidth - 15,this.__height);
			if(loc4.item != undefined)
			{
				if(loc4.param1 == loc4.param2)
				{
					var loc5 = "(#4s)  #1";
				}
				else
				{
					loc5 = "(#4s)  #1{~2 " + this._mcList.gapi.api.lang.getText("TO_RANGE") + " }#2";
				}
				this._lblQuantity.text = ank.utils.PatternDecoder.getDescription(loc5,new Array(loc4.param1,loc4.param2,loc4.param3,Math.round(loc4.param4 / 100) / 10));
				this._ctrIcon.contentData = loc4.item;
			}
			else
			{
				var loc6 = this._parent._parent._parent._parent;
				var loc7 = ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("SLOT"),"n",loc4.param1 < 2);
				var loc8 = "#1 " + loc7 + " (#2%)";
				this._lblQuantity.text = ank.utils.PatternDecoder.getDescription(loc8,new Array(loc4.param1,loc4.param4));
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
	function over(loc2)
	{
		var loc3 = loc2.target.contentData;
		this._mcList._parent._parent.gapi.showTooltip(loc3.name,loc2.target,-20);
	}
	function out(loc2)
	{
		this._mcList._parent._parent.gapi.hideTooltip();
	}
}
