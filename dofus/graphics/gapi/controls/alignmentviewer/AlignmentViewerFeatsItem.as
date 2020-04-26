class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerFeatsItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function AlignmentViewerFeatsItem()
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
			this._ldrIcon.contentPath = loc4.iconFile;
			this._lblName.text = loc4.name + (loc4.level != undefined?" (" + this._mcList.gapi.api.lang.getText("LEVEL_SMALL") + " " + loc4.level + ")":"");
			this._lblEffect.text = loc4.effect.description != undefined?loc4.effect.description:"";
		}
		else if(this._lblName.text != undefined)
		{
			this._ldrIcon.contentPath = "";
			this._lblName.text = "";
			this._lblEffect.text = "";
		}
	}
}
