class ank.battlefield.datacenter.Map extends Object
{
	function Map(§\x05\x02§)
	{
		super();
		this.initialize(var3);
	}
	function initialize(§\x05\x02§)
	{
		this.id = var2;
		this.originalsCellsBackup = new ank.utils.	();
	}
	function cleanSpritesOn()
	{
		if(this.data != undefined)
		{
			§§enumerate(this.data);
			while((var var0 = §§enumeration()) != null)
			{
				this.data[k].removeAllSpritesOnID();
			}
		}
	}
}
