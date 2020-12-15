class dofus.graphics.battlefield.EffectIcon extends MovieClip
{
	static var COLOR_PLUS = 255;
	static var COLOR_MINUS = 16711680;
	static var COLOR_FACTOR = 65280;
	function EffectIcon()
	{
		super();
		_global.subtrace("yahoo");
		this.initialize(this._sOperator,this._nQte);
	}
	function __set__operator(var2)
	{
		this._sOperator = var2;
		return this.__get__operator();
	}
	function __set__qte(var2)
	{
		this._nQte = var2;
		return this.__get__qte();
	}
	function initialize(var2, var3)
	{
		switch(var2)
		{
			case "-":
				this.attachMovie("Icon-","_mcOp",10,{_x:1,_y:1});
				var var4 = new Color(this._mcbackground);
				var4.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_MINUS);
				break;
			case "+":
				this.attachMovie("Icon+","_mcOp",10,{_x:1,_y:1});
				var var5 = new Color(this._mcbackground);
				var5.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_PLUS);
				break;
			case "*":
				this.attachMovie("Icon*","_mcOp",10,{_x:1,_y:1});
				var var6 = new Color(this._mcbackground);
				var6.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_FACTOR);
		}
	}
}
