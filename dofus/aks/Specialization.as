class dofus.aks.Specialization extends dofus.aks.Handler
{
	function Specialization(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function onSet(loc2)
	{
		var loc3 = Number(loc2);
		if(_global.isNaN(loc3) || (loc2.length == 0 || loc3 == 0))
		{
			this.api.datacenter.Player.specialization = undefined;
		}
		else
		{
			var loc4 = new dofus.datacenter.Specialization(loc3);
			this.api.datacenter.Player.specialization = loc4;
		}
	}
	function onChange(loc2)
	{
		this.onSet(loc2);
		var loc3 = this.api.datacenter.Player.specialization;
		if(loc3 == undefined)
		{
			this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"),this.api.lang.getText("YOU_HAVE_NO_SPECIALIZATION"),"ERROR_BOX");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"),this.api.lang.getText("YOUR_SPECIALIZATION_CHANGED",[loc3.name]),"ERROR_BOX");
		}
	}
}
