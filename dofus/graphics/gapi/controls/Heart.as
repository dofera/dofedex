class dofus.graphics.gapi.controls.Heart extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Heart";
	function Heart()
	{
		super();
	}
	function __set__value(var2)
	{
		var2 = Number(var2);
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		this._nValue = var2;
		if(this._nMax != undefined)
		{
			this.applyValue();
		}
		return this.__get__value();
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__max(var2)
	{
		var2 = Number(var2);
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		this._nMax = var2;
		if(this._nValue != undefined)
		{
			this.applyValue();
		}
		return this.__get__max();
	}
	function __get__max()
	{
		return this._nMax;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Heart.CLASS_NAME);
	}
	function createChildren()
	{
		this._nMaxHeight = this._mcRectangle._height;
		this._nDisplayState = 0;
		this.stop();
	}
	function applyValue()
	{
		switch(this._nDisplayState)
		{
			case 1:
				this._txtCurrent.text = String(this._nValue);
				this._txtMax.text = String(this._nMax);
				break;
			case 2:
				this._txtPercent.text = String(Math.round(this._nValue / this._nMax * 100));
				break;
			default:
				this._txtValue.text = String(this._nValue);
		}
		this._mcRectangle._height = this._nValue / this._nMax * this._nMaxHeight;
	}
	function toggleDisplay()
	{
		this._nDisplayState++;
		if(this._nDisplayState > 2)
		{
			this._nDisplayState = 0;
		}
		this._nDisplayState = Number(this._nDisplayState);
		if(_global.isNaN(this._nDisplayState))
		{
			this._nDisplayState = 0;
		}
		switch(this._nDisplayState)
		{
			case 1:
				this.gotoAndStop("Double");
				break;
			case 2:
				this.gotoAndStop("Percent");
				break;
			default:
				this.gotoAndStop("Value");
		}
		this.addToQueue({object:this,method:this.applyValue});
	}
}
