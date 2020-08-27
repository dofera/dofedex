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
		var var2 = this.api.datacenter.Map;
		if(var2.name == undefined)
		{
			this._lblArea.text = "";
			this._lblCoordinates.text = "";
			this._lblAreaShadow.text = "";
			this._lblCoordinatesShadow.text = "";
		}
		else
		{
			var var3 = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(var2.subarea);
			var var4 = var2.name + (var3 != undefined?var3.alignment.name != undefined?" - " + var3.alignment.name:"":"");
			this._lblArea.text = var4;
			this._lblCoordinates.text = var2.coordinates;
			this._lblAreaShadow.text = var4;
			this._lblCoordinatesShadow.text = var2.coordinates;
		}
	}
}
