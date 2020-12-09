class com.ankamagames.exceptions.AbstractException extends Error
{
	function AbstractException(objectErrorSource, className, methodName, §\t\x1c§)
	{
		super(var6);
		this._className = className;
		this._methodName = methodName;
		this._objectErrorSource = objectErrorSource;
	}
	function getSource(§\x1e\n\f§)
	{
		return this._objectErrorSource;
	}
	function getMessage(§\x1e\n\f§)
	{
		return !!super.message?super.toString():null;
	}
	function getExceptionName(§\x1e\n\f§)
	{
		return "com.ankamagames.exceptions.AbstractException";
	}
	function getClassName(§\x1e\n\f§)
	{
		return this._className;
	}
	function getMethodName(§\x1e\n\f§)
	{
		return !!this._methodName?this._methodName:null;
	}
	function toString(§\x1e\n\f§)
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
