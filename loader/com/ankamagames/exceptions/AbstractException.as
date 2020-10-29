class com.ankamagames.exceptions.AbstractException extends Error
{
	function AbstractException(objectErrorSource, className, methodName, §\t\x10§)
	{
		super(var6);
		this._className = className;
		this._methodName = methodName;
		this._objectErrorSource = objectErrorSource;
	}
	function getSource(var2)
	{
		return this._objectErrorSource;
	}
	function getMessage(var2)
	{
		return !!super.message?super.toString():null;
	}
	function getExceptionName(var2)
	{
		return "com.ankamagames.exceptions.AbstractException";
	}
	function getClassName(var2)
	{
		return this._className;
	}
	function getMethodName(var2)
	{
		return !!this._methodName?this._methodName:null;
	}
	function toString(var2)
	{
		var var3 = this.getExceptionName() + " in " + this.getClassName() + (this.getMethodName() == null?"":"." + this.getMethodName());
		var var4 = this.getMessage();
		if(!var4)
		{
			return var3;
		}
		return "[EXCEPTION] " + var3 + " :\r\n\t" + var4;
	}
}
