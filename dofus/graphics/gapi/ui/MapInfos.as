class dofus.graphics.gapi.ui.MapInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MapInfos";
	function MapInfos()
	{
		super();
	}
	function update()
	{
		this.initText();
		this._visible = true;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MapInfos.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initText});
	}
	function initText()
	{
		var loc2 = this.api.datacenter.Map;
		if(loc2.name == undefined)
		{
			this._lblArea.text = "";
			this._lblCoordinates.text = "";
			this._lblAreaShadow.text = "";
			this._lblCoordinatesShadow.text = "";
		}
		else
		{
			var loc3 = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(loc2.subarea);
			var loc4 = loc2.name + (loc3 != undefined?loc3.alignment.name != undefined?" - " + loc3.alignment.name:"":"");
			this._lblArea.text = loc4;
			this._lblCoordinates.text = loc2.coordinates;
			this._lblAreaShadow.text = loc4;
			this._lblCoordinatesShadow.text = loc2.coordinates;
		}
	}
}
