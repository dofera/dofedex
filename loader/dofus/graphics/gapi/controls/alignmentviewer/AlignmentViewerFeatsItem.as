class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerFeatsItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	function AlignmentViewerFeatsItem()
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
			this._ldrIcon.contentPath = var4.iconFile;
			this._lblName.text = var4.name + (var4.level != undefined?" (" + this._mcList.gapi.api.lang.getText("LEVEL_SMALL") + " " + var4.level + ")":"");
			this._lblEffect.text = var4.effect.description != undefined?var4.effect.description:"";
		}
		else if(this._lblName.text != undefined)
		{
			this._ldrIcon.contentPath = "";
			this._lblName.text = "";
			this._lblEffect.text = "";
		}
	}
}
