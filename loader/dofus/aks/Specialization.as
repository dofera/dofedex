class dofus.aks.Specialization extends dofus.aks.Handler
{
	function Specialization(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function onSet(var2)
	{
		var var3 = Number(var2);
		if(_global.isNaN(var3) || (var2.length == 0 || var3 == 0))
		{
			this.api.datacenter.Player.specialization = undefined;
		}
		else
		{
			var var4 = new dofus.datacenter.Specialization(var3);
			this.api.datacenter.Player.specialization = var4;
		}
	}
	function onChange(var2)
	{
		this.onSet(var2);
		var var3 = this.api.datacenter.Player.specialization;
		if(var3 == undefined)
		{
			this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"),this.api.lang.getText("YOU_HAVE_NO_SPECIALIZATION"),"ERROR_BOX");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("SPECIALIZATION"),this.api.lang.getText("YOUR_SPECIALIZATION_CHANGED",[var3.name]),"ERROR_BOX");
		}
	}
}
